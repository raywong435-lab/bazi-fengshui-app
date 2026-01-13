"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createChartLogic = exports.createChart = void 0;
const functions = require("firebase-functions");
const lunar_typescript_1 = require("lunar-typescript");
const zod_1 = require("zod");
// Zod schema for input validation
const createChartInputSchema = zod_1.z.object({
    name: zod_1.z.string(),
    birthDate: zod_1.z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
    birthTime: zod_1.z.string().regex(/^\d{2}:\d{2}$/),
    timeZone: zod_1.z.string(),
    gender: zod_1.z.enum(["male", "female"]),
});
const createChartLogic = async (data) => {
    // Validate input
    if (!data.year || !data.month || !data.day || !data.hour || !data.minute || !data.gender) {
        throw new Error('必须提供完整的出生信息。');
    }
    try {
        const solar = lunar_typescript_1.Solar.fromYmdHms(data.year, data.month, data.day, data.hour, data.minute, 0);
        const lunar = solar.getLunar();
        const bazi = lunar.getEightChar();
        const chartData = {
            year: {
                heavenlyStem: bazi.getYearGan(),
                earthlyBranch: bazi.getYearZhi(),
            },
            month: {
                heavenlyStem: bazi.getMonthGan(),
                earthlyBranch: bazi.getMonthZhi(),
            },
            day: {
                heavenlyStem: bazi.getDayGan(),
                earthlyBranch: bazi.getDayZhi(),
            },
            hour: {
                heavenlyStem: bazi.getTimeGan(),
                earthlyBranch: bazi.getTimeZhi(),
            },
        };
        return chartData;
    }
    catch (error) {
        console.error("Bazi calculation failed:", error);
        throw new Error("排盘过程中发生内部错误。");
    }
};
exports.createChartLogic = createChartLogic;
// Main callable function: accepts user-friendly input, validates, and maps to calculation logic
exports.createChart = functions.region("asia-east1").https.onCall(async (data, context) => {
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
//# sourceMappingURL=createChart.js.map