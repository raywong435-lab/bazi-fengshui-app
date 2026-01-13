import { z } from 'zod';

// Birth info schema for input validation
export const birthInfoSchema = z.object({
  name: z.string(),
  birthDate: z.string(), // ISO date string
  birthTime: z.string(), // HH:MM format
  gender: z.enum(['male', 'female']),
  location: z.string(), // city or coordinates
});

// 基礎分析模塊，用於原局、大運、流年
const BaziAnalysisSchema = z.object({
  strengthAnalysis: z.string().describe("日主強弱判斷，包含是否得令、得地、得黨，以及是否為特殊格局（如專旺、從格、羊刃格）的詳細分析。"),
  keyGods: z.object({
    fuyi: z.string().describe("扶抑用神的判斷結果。"),
    tongguan: z.string().describe("通關用神的判斷結果。"),
    bingyao: z.string().describe("病藥用神的判斷結果。"),
    tiaohou: z.string().describe("調候用神的判斷結果。"),
  }).describe("關鍵用神的綜合分析。"),
  shenSha: z.string().describe("對命盤中重要神煞（如空亡、天乙貴人等）的解讀。"),
});

// 2026 年流年運勢模塊
const AnnualFortuneSchema = z.object({
  career: z.string().describe("針對 2026 年的事業運勢分析與建議。"),
  wealth: z.string().describe("針對 2026 年的財運運勢分析與建議。"),
  health: z.string().describe("針對 2026 年的健康運勢分析與建議。"),
});

// 最終輸出的完整報告結構
export const FullReportSchema = z.object({
  originalChartAnalysis: BaziAnalysisSchema.describe("對命主八字原局的完整分析。"),
  annualFortune2026: AnnualFortuneSchema.describe("對命主 2026 年流年運勢的詳細分析。"),
});

// Alias for backward compatibility
export const reportSchema = FullReportSchema;

// 從 Zod Schema 推斷出 TypeScript 型別
export type FullReport = z.infer<typeof FullReportSchema>;