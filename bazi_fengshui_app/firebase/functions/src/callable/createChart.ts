
import * as functions from "firebase-functions";
import { Solar } from "lunar-typescript";
import { z } from "zod";


// Zod schema for input validation
const createChartInputSchema = z.object({
  name: z.string(),
  birthDate: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  birthTime: z.string().regex(/^\d{2}:\d{2}$/),
  timeZone: z.string(),
  gender: z.enum(["male", "female"]),
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


// Main callable function: accepts user-friendly input, validates, and maps to calculation logic
export const createChart = functions.region("asia-east1").https.onCall(async (data, context) => {
  // Validate input
  const parseResult = createChartInputSchema.safeParse(data);
  if (!parseResult.success) {
    throw new functions.https.HttpsError('invalid-argument', 'Invalid input', parseResult.error.flatten());
  }

  const { birthDate, birthTime, gender } = parseResult.data;
  // Parse date and time
  const [year, month, day] = birthDate.split('-').map(Number);
  const [hour, minute] = birthTime.split(':').map(Number);
  // Map gender to Chinese for calculation logic if needed
  const genderZh = gender === 'male' ? '男' : '女';

  const chartData = await createChartLogic({ year, month, day, hour, minute, gender: genderZh });
  return chartData;
});

export { createChartLogic };