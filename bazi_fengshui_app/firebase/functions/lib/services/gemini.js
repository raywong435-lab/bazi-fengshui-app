"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateAndValidateJson = generateAndValidateJson;
exports.createPrompt = createPrompt;
exports.generateReportWithGemini = generateReportWithGemini;
const generative_ai_1 = require("@google/generative-ai");
const errors_1 = require("../types/errors");
// 優先使用環境變數 `GEMINI_API_KEY`，若無則退回 `GENAI_KEY`。
const API_KEY = process.env.GEMINI_API_KEY || process.env.GENAI_KEY || '';
if (!API_KEY) {
    console.warn('Warning: GEMINI_API_KEY / GENAI_KEY not set. Gemini calls will fail without an API key.');
}
const genAI = new generative_ai_1.GoogleGenerativeAI(API_KEY);
const generativeModel = genAI.getGenerativeModel({ model: 'gemini-pro' });
async function generateAndValidateJson(prompt, schema) {
    const generationConfig = {};
    try {
        const result = await generativeModel.generateContent({
            contents: [{ role: 'user', parts: [{ text: prompt }] }],
            generationConfig,
        });
        const response = result.response;
        const responseText = response.text();
        if (!responseText) {
            throw new errors_1.GeminiApiError('Gemini API returned an empty response.');
        }
        let parsedJson;
        try {
            parsedJson = JSON.parse(responseText);
        }
        catch (error) {
            throw new errors_1.JsonParsingError(`Failed to parse Gemini response as JSON. Raw text: "${responseText}"`);
        }
        const validationResult = schema.safeParse(parsedJson);
        if (!validationResult.success) {
            throw new errors_1.ValidationError('Gemini response failed Zod validation.', validationResult.error.issues);
        }
        return validationResult.data;
    }
    catch (error) {
        if (error instanceof errors_1.ValidationError || error instanceof errors_1.JsonParsingError) {
            throw error;
        }
        console.error('Gemini API call failed:', error);
        throw new errors_1.GeminiApiError(`Gemini API call failed: ${(error === null || error === void 0 ? void 0 : error.message) || error}`);
    }
}
// Build prompt without triple-backtick fences to avoid template parsing errors in TypeScript strings.
// Use a small, manually authored simplified JSON schema for guiding the model when zod->json-schema
// conversion is too deep/complex. Final validation is still done with the Zod schema.
function createPrompt(baziData, reportType, simplifiedSchema) {
    const baziInfo = JSON.stringify(baziData, null, 2);
    const schemaForPrompt = simplifiedSchema ||
        {
            type: 'object',
            properties: {
                reportType: { type: 'string' },
                title: { type: 'string' },
                summary: { type: 'string' },
                recommendations: { type: 'array', items: { type: 'string' } },
                sections: { type: 'array', items: { type: 'object' } },
            },
            required: ['reportType', 'title', 'summary'],
        };
    return [
        'ROLE: 你是一位資深且專業的現代八字命理與職涯規劃顧問，結合傳統與現代職場洞察。',
        `CONTEXT: 為用戶生成一份 "${reportType}" 報告。以下為該用戶的八字資料 (純 JSON):`,
        baziInfo,
        'TASK: 根據上方八字資料，生成一份建設性且具體的分析報告。',
        'OUTPUT_FORMAT: 只回傳一個有效的 JSON 物件，格式需符合下方的簡化 JSON Schema（僅供結構參考）：',
        JSON.stringify(schemaForPrompt, null, 2),
        `CONSTRAINTS: 回覆只能是 JSON 物件、不可以包含任何 Markdown 或額外說明；reportType 欄位必須為 "${reportType}"。`,
    ].join('\n\n');
}
async function generateReportWithGemini(chartData, reportType) {
    const prompt = createPrompt(chartData, reportType);
    // Import Zod schema at runtime to avoid circular import/type explosion
    const { ReportDataSchema } = await Promise.resolve().then(() => require('../types/reportSchemas'));
    // Use a simplified JSON Schema for the model prompt to avoid deep type conversion problems
    // (zod-to-json-schema can produce deeply nested types that cause compile-time or runtime issues).
    // Final, authoritative validation is done with the Zod schema below.
    const simplifiedForPrompt = {
        type: 'object',
        properties: {
            reportType: { type: 'string' },
            title: { type: 'string' },
            summary: { type: 'string' },
            recommendations: { type: 'array', items: { type: 'string' } },
        },
        required: ['reportType', 'title', 'summary'],
    };
    // TODO: 使用 zod-to-json-schema 轉換時遇到深層類型導致的型別錯誤；此處使用 `as any` 作為保守暫時解法，
    // 並以人工撰寫的 `simplifiedForPrompt` 作為 prompt 參考，最終仍以 Zod `ReportDataSchema` 做驗證。
    // 後續建議：拆分大型 schema、或升級/修正 zod-to-json-schema 使用，或撰寫輔助函式以產生淺層 schema。
    const validated = await generateAndValidateJson(prompt + '\n\n' + JSON.stringify(simplifiedForPrompt), ReportDataSchema);
    return validated;
}
//# sourceMappingURL=gemini.js.map