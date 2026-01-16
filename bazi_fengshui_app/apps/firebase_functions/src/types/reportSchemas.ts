import { z } from 'zod';

// 函式輸入驗證
export const ReportRequestSchema = z.object({
  chartId: z.string().min(1),
  reportType: z.enum(['career', 'wealth', 'health', 'relationship']),
});

// === 兩種不同的報告類型範例 ===
const CareerReportSchema = z.object({
  reportType: z.literal('career'),
  title: z.string().describe("報告標題，例如「個人事業潛力分析報告」"),
  summary: z.object({
    overallPotential: z.string().describe("綜合事業潛力總評，一段約 100-150 字的摘要"),
    keyStrengths: z.array(z.string()).describe("根據命盤分析出的 3-5 個核心事業優勢"),
  }),
  careerPathSuggestions: z.array(z.object({
    pathName: z.string().describe("建議的職業路徑或行業領域"),
    reason: z.string().describe("選擇此路徑的命理學原因"),
    suitabilityScore: z.number().min(1).max(10).describe("適合度評分，1-10分"),
  })),
});

const WealthReportSchema = z.object({
  reportType: z.literal('wealth'),
  title: z.string().describe("報告標題，例如「個人財富格局分析」"),
  fiveYearProjection: z.number().describe("未來五年的財富增長潛力預估值"),
  investmentSuggestions: z.array(z.string()).describe("具體的投資方向建議"),
});

// TODO: add health and relationship schemas
const HealthReportSchema = z.object({
  reportType: z.literal('health'),
  title: z.string(),
  healthSummary: z.string(),
});

const RelationshipReportSchema = z.object({
  reportType: z.literal('relationship'),
  title: z.string(),
  relationshipAdvice: z.string(),
});

// 使用 Zod 的 discriminatedUnion 來處理多種報告結構
export const ReportDataSchema = z.discriminatedUnion('reportType', [
  CareerReportSchema,
  WealthReportSchema,
  HealthReportSchema,
  RelationshipReportSchema,
]);
export type ReportData = z.infer<typeof ReportDataSchema>;

// Manual JSON schema for AI prompts (removed zod-to-json-schema dependency)
export const reportJsonSchema = {
  type: 'object',
  required: ['reportType'],
  properties: {
    reportType: { type: 'string', enum: ['career', 'wealth', 'health', 'relationship'] },
    title: { type: 'string' },
    // Add more properties as needed based on reportType
  },
  description: 'Report data with discriminated union based on reportType',
};

// === 最終回傳給前端的完整結構 ===
export const FunctionResponseSchema = z.object({
  report: ReportDataSchema,
  metadata: z.object({
    source: z.enum(['cache', 'gemini']),
    promptVersion: z.string(),
    deployTag: z.string(),
    cacheTimestamp: z.string().optional(),
  }),
});

export type FunctionResponse = z.infer<typeof FunctionResponseSchema>;
