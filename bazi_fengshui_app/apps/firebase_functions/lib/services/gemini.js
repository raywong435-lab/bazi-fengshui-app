"use strict";
var _a;
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateAndValidateJson = generateAndValidateJson;
exports.buildBaziReportPrompt = buildBaziReportPrompt;
exports.createPrompt = createPrompt;
exports.generateReportWithGemini = generateReportWithGemini;
const functions = require("firebase-functions");
const generative_ai_1 = require("@google/generative-ai");
const errors_1 = require("../types/errors");
// Resolve API key in this priority order:
// 1) functions config (`firebase functions:config:set gemini.key="..."`) — works with emulator
// 2) environment variable `GEMINI_API_KEY`
// 3) fall back to legacy `GENAI_KEY` env var
const functionsConfigKey = (_a = (functions && functions.config && functions.config().gemini)) === null || _a === void 0 ? void 0 : _a.key;
const API_KEY = functionsConfigKey || process.env.GEMINI_API_KEY || process.env.GENAI_KEY || '';
if (!API_KEY) {
    console.warn('Warning: Gemini API key not found in functions config or GEMINI_API_KEY/GENAI_KEY env vars.');
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
/**
 * Build prompt template for Bazi report generation.
 * Note: We use array.join() instead of template literals with triple-backticks
 * to avoid TypeScript compiler issues with code fence markers in strings.
 */
function buildBaziReportPrompt(birthData, chartData) {
    const schemaDescription = 'JSON object with: analysis (string), insights (array of strings), recommendations (array of strings)';
    const lines = [
        '你是一個專業的八字命理分析師。',
        '',
        '根據以下出生數據和八字圖表，生成詳細的命理報告。',
        '',
        '出生數據:',
        `年: ${birthData.year}, 月: ${birthData.month}, 日: ${birthData.day}, 時: ${birthData.hour}`,
        '',
        '八字圖表:',
        JSON.stringify(chartData, null, 2),
        '',
        '請以下列JSON格式返回分析結果:',
        '```json',
        '{',
        '  "analysis": "string",',
        '  "insights": ["string"],',
        '  "recommendations": ["string"]',
        '}',
        '```',
        '',
        '確保返回的JSON可以被正確解析。',
    ];
    return lines.join('\n');
}
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
            },
            required: ['reportType', 'title', 'summary'],
        };
    // Note: We intentionally avoid triple-backtick fences (```json) in the prompt string to prevent
    // accidental TypeScript template literal parsing/formatting issues.
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
    // TODO: If `zod-to-json-schema` usage is desired in the future, split the `ReportDataSchema`
    // into smaller pieces or create a shallow schema generator to avoid deep type instantiation errors.
    // For now we intentionally provide `simplifiedForPrompt` to the model and use the full Zod schema
    // (ReportDataSchema) only for final validation at runtime.
    const validated = await generateAndValidateJson(prompt + '\n\n' + JSON.stringify(simplifiedForPrompt), ReportDataSchema);
    return validated;
}
//# sourceMappingURL=gemini.js.map