"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateFullReport = exports.generateContent = void 0;
const generative_ai_1 = require("@google/generative-ai");
const genAI = new generative_ai_1.GoogleGenerativeAI(process.env.GENAI_KEY || process.env.GEMINI_API_KEY || '');
const generateContent = async (prompt) => {
    const model = genAI.getGenerativeModel({ model: 'gemini-pro' });
    const result = await model.generateContent({ contents: [{ role: 'user', parts: [{ text: prompt }] }] });
    const response = result.response;
    return response.text();
};
exports.generateContent = generateContent;
// For local builds, return parsed JSON without strict Zod validation to avoid missing schema imports.
const generateFullReport = async (baziData) => {
    const prompt = `基于以下八字命盘数据，生成一份结构化的完整报告（JSON only）。八字数据: ${JSON.stringify(baziData)}`;
    const text = await (0, exports.generateContent)(prompt);
    try {
        const parsed = JSON.parse(text);
        return parsed;
    }
    catch (error) {
        throw new Error('Failed to parse Gemini response as JSON');
    }
};
exports.generateFullReport = generateFullReport;
//# sourceMappingURL=geminiClient.js.map