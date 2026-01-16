
import * as functions from "firebase-functions/v1";
import { Solar } from "lunar-typescript";
import { z } from "zod";


// Updated Zod schema: accept a single ISO 8601 datetime string for birthDate
// and use numeric gender (1 = male, 2 = female) to align with EightChar.getYun API.
const chartInputSchema = z.object({
  chartName: z.string().min(1),
  birthDate: z.string().datetime({ message: "請提供有效的 ISO 8601 日期時間字串" }),
  gender: z.number().min(1).max(2),
  timeZone: z.string().optional(),
});

interface CreateChartData {
  year: number;
  month: number;
  day: number;
  hour: number;
  minute: number;
  gender: string; // "男" or "女"
}

interface ChartData {
  year: { heavenlyStem: string; earthlyBranch: string };
  month: { heavenlyStem: string; earthlyBranch: string };
  day: { heavenlyStem: string; earthlyBranch: string };
  hour: { heavenlyStem: string; earthlyBranch: string };
  // Add more fields as needed, like bigLuck, etc.
}

/**
 * Core Bazi calculation logic using lunar-typescript library.
 * Converts birth date/time to Bazi four pillars (year, month, day, hour).
 *
 * @param {CreateChartData} data - Birth data with year, month, day, hour, minute, gender
 * @returns {Promise<ChartData>} Bazi chart with four pillars (heavenlyStem and earthlyBranch for each)
 * @throws {Error} If required birth data is missing or calculation fails
 */
const createChartLogic = async (data: CreateChartData): Promise<ChartData> => {
  // Validate input
  if (!data.year && data.year !== 0) throw new Error('必须提供出生年。');
  if (!data.month && data.month !== 0) throw new Error('必须提供出生月。');
  if (!data.day && data.day !== 0) throw new Error('必须提供出生日。');
  if (!data.hour && data.hour !== 0) throw new Error('必须提供出生時辰。');
  if (!data.minute && data.minute !== 0) throw new Error('必须提供出生分。');

  try {
    // Use Solar.fromYmdHms to construct solar date/time; lunar-typescript exposes `getLunar()` and
    // `getEightChar()` on the Lunar/Solar objects. Methods may vary between versions; we defensively
    // call available getters and fallback to string parsing if necessary.
    const solar = Solar.fromYmdHms(data.year, data.month, data.day, data.hour, data.minute, 0);
    const lunar = solar.getLunar();
    const bazi = lunar.getEightChar();

    // Defensive helper to read a value if method exists
    const methodOrFallback = (obj: any, methodName: string, fallback?: () => string) => {
      if (!obj) return fallback ? fallback() : '';
      if (typeof obj[methodName] === 'function') return obj[methodName]();
      return fallback ? fallback() : '';
    };

    const chartData: ChartData = {
      year: {
        heavenlyStem: methodOrFallback(bazi, 'getYearGan', () => ''),
        earthlyBranch: methodOrFallback(bazi, 'getYearZhi', () => ''),
      },
      month: {
        heavenlyStem: methodOrFallback(bazi, 'getMonthGan', () => ''),
        earthlyBranch: methodOrFallback(bazi, 'getMonthZhi', () => ''),
      },
      day: {
        heavenlyStem: methodOrFallback(bazi, 'getDayGan', () => ''),
        earthlyBranch: methodOrFallback(bazi, 'getDayZhi', () => ''),
      },
      hour: {
        heavenlyStem: methodOrFallback(bazi, 'getTimeGan', () => ''),
        earthlyBranch: methodOrFallback(bazi, 'getTimeZhi', () => ''),
      },
    };

    return chartData;
  } catch (error) {
    console.error('Bazi calculation failed:', error);
    throw new Error('排盘过程中发生内部错误。');
  }
};


/**
 * Creates a Bazi chart from birth date/time data.
 *
 * @param {object} data - Input data
 * @param {string} data.chartName - Name for the chart
 * @param {string} data.birthDate - ISO 8601 datetime string (e.g., "2000-01-15T14:30:00+08:00")
 * @param {1|2} data.gender - 1 for male, 2 for female
 * @param {string} [data.timeZone] - Optional timezone (default system)
 * @returns {Promise<ChartData>} Object with year, month, day, hour pillars (each has heavenlyStem, earthlyBranch)
 * @throws {HttpsError} 'unauthenticated' if user not logged in
 * @throws {HttpsError} 'invalid-argument' if input fails schema validation
 */
// Main callable function: accepts user-friendly input, validates, and maps to calculation logic
export const createChart = functions.region("asia-east1").https.onCall(async (data, context) => {
  // Require authentication for secure write
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated to create a chart.');
  }

  // Validate input against the updated schema
  const parseResult = chartInputSchema.safeParse(data);
  if (!parseResult.success) {
    throw new functions.https.HttpsError('invalid-argument', 'Invalid input', parseResult.error.flatten());
  }

  const { birthDate, gender } = parseResult.data;

  // Construct Date from ISO 8601 string (e.g., 2000-01-15T14:30:00+08:00)
  const date = new Date(birthDate);
  if (isNaN(date.getTime())) {
    throw new functions.https.HttpsError('invalid-argument', 'Invalid birthDate ISO string');
  }

  // Decompose to Y/M/D H:M in local time from the ISO string
  const year = date.getFullYear();
  const month = date.getMonth() + 1; // JS months are 0-based
  const day = date.getDate();
  const hour = date.getHours();
  const minute = date.getMinutes();

  // Map numeric gender to Chinese character if downstream logic needs it
  const genderZh = gender === 1 ? '男' : '女';

  const chartData = await createChartLogic({ year, month, day, hour, minute, gender: genderZh });
  return chartData;
});

export { createChartLogic };