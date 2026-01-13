"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FunctionResponseSchema = exports.reportJsonSchema = exports.ReportDataSchema = exports.ReportRequestSchema = void 0;
const zod_1 = require("zod");
const zod_to_json_schema_1 = require("zod-to-json-schema");
// 函式輸入驗證
exports.ReportRequestSchema = zod_1.z.object({
    chartId: zod_1.z.string().min(1),
    reportType: zod_1.z.enum(['career', 'wealth', 'health', 'relationship']),
});
// === 兩種不同的報告類型範例 ===
const CareerReportSchema = zod_1.z.object({
    reportType: zod_1.z.literal('career'),
    title: zod_1.z.string().describe("報告標題，例如「個人事業潛力分析報告」"),
    summary: zod_1.z.object({
        overallPotential: zod_1.z.string().describe("綜合事業潛力總評，一段約 100-150 字的摘要"),
        keyStrengths: zod_1.z.array(zod_1.z.string()).describe("根據命盤分析出的 3-5 個核心事業優勢"),
    }),
    careerPathSuggestions: zod_1.z.array(zod_1.z.object({
        pathName: zod_1.z.string().describe("建議的職業路徑或行業領域"),
        reason: zod_1.z.string().describe("選擇此路徑的命理學原因"),
        suitabilityScore: zod_1.z.number().min(1).max(10).describe("適合度評分，1-10分"),
    })),
});
const WealthReportSchema = zod_1.z.object({
    reportType: zod_1.z.literal('wealth'),
    title: zod_1.z.string().describe("報告標題，例如「個人財富格局分析」"),
    fiveYearProjection: zod_1.z.number().describe("未來五年的財富增長潛力預估值"),
    investmentSuggestions: zod_1.z.array(zod_1.z.string()).describe("具體的投資方向建議"),
});
// TODO: add health and relationship schemas
const HealthReportSchema = zod_1.z.object({
    reportType: zod_1.z.literal('health'),
    title: zod_1.z.string(),
    healthSummary: zod_1.z.string(),
});
const RelationshipReportSchema = zod_1.z.object({
    reportType: zod_1.z.literal('relationship'),
    title: zod_1.z.string(),
    relationshipAdvice: zod_1.z.string(),
});
// 使用 Zod 的 discriminatedUnion 來處理多種報告結構
exports.ReportDataSchema = zod_1.z.discriminatedUnion('reportType', [
    CareerReportSchema,
    WealthReportSchema,
    HealthReportSchema,
    RelationshipReportSchema,
]);
// 將 Zod Schema 轉換為 JSON Schema 供 AI 使用
exports.reportJsonSchema = (0, zod_to_json_schema_1.default)(exports.ReportDataSchema, { $refStrategy: 'none' });
// === 最終回傳給前端的完整結構 ===
exports.FunctionResponseSchema = zod_1.z.object({
    report: exports.ReportDataSchema,
    metadata: zod_1.z.object({
        source: zod_1.z.enum(['cache', 'gemini']),
        promptVersion: zod_1.z.string(),
        deployTag: zod_1.z.string(),
        cacheTimestamp: zod_1.z.string().optional(),
    }),
});
//# sourceMappingURL=reportSchemas.js.map