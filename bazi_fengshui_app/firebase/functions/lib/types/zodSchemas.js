"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.reportSchema = exports.FullReportSchema = exports.birthInfoSchema = void 0;
const zod_1 = require("zod");
// Birth info schema for input validation
exports.birthInfoSchema = zod_1.z.object({
    name: zod_1.z.string(),
    birthDate: zod_1.z.string(), // ISO date string
    birthTime: zod_1.z.string(), // HH:MM format
    gender: zod_1.z.enum(['male', 'female']),
    location: zod_1.z.string(), // city or coordinates
});
// 基礎分析模塊，用於原局、大運、流年
const BaziAnalysisSchema = zod_1.z.object({
    strengthAnalysis: zod_1.z.string().describe("日主強弱判斷，包含是否得令、得地、得黨，以及是否為特殊格局（如專旺、從格、羊刃格）的詳細分析。"),
    keyGods: zod_1.z.object({
        fuyi: zod_1.z.string().describe("扶抑用神的判斷結果。"),
        tongguan: zod_1.z.string().describe("通關用神的判斷結果。"),
        bingyao: zod_1.z.string().describe("病藥用神的判斷結果。"),
        tiaohou: zod_1.z.string().describe("調候用神的判斷結果。"),
    }).describe("關鍵用神的綜合分析。"),
    shenSha: zod_1.z.string().describe("對命盤中重要神煞（如空亡、天乙貴人等）的解讀。"),
});
// 2026 年流年運勢模塊
const AnnualFortuneSchema = zod_1.z.object({
    career: zod_1.z.string().describe("針對 2026 年的事業運勢分析與建議。"),
    wealth: zod_1.z.string().describe("針對 2026 年的財運運勢分析與建議。"),
    health: zod_1.z.string().describe("針對 2026 年的健康運勢分析與建議。"),
});
// 最終輸出的完整報告結構
exports.FullReportSchema = zod_1.z.object({
    originalChartAnalysis: BaziAnalysisSchema.describe("對命主八字原局的完整分析。"),
    annualFortune2026: AnnualFortuneSchema.describe("對命主 2026 年流年運勢的詳細分析。"),
});
// Alias for backward compatibility
exports.reportSchema = exports.FullReportSchema;
//# sourceMappingURL=zodSchemas.js.map