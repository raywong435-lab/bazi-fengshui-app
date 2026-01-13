"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateStructuredCareerReport = exports.generateContent = void 0;
const generative_ai_1 = require("@google/generative-ai");
const zodSchemas_1 = require("../types/zodSchemas");
const genAI = new generative_ai_1.GoogleGenerativeAI(process.env.GENAI_KEY);
const generateContent = async (prompt) => {
    const model = genAI.getGenerativeModel({ model: 'gemini-pro' });
    const result = await model.generateContent(prompt);
    const response = await result.response;
    return response.text();
};
exports.generateContent = generateContent;
const generateStructuredCareerReport = async (baziData) => {
    const prompt = `
基于以下八字命盘数据，生成一份结构化的职业发展报告。请以JSON格式返回，严格遵循以下Schema：
{
  "careerPath": "string",
  "strengths": ["string"],
  "challenges": ["string"],
  "recommendations": ["string"],
  "timeline": {
    "shortTerm": "string",
    "longTerm": "string"
  }
}

只返回JSON，不要其他文本。

八字数据: ${JSON.stringify(baziData)}
  `;
    const model = genAI.getGenerativeModel({ model: 'gemini-pro' });
    const result = await model.generateContent(prompt);
    const response = await result.response;
    const text = response.text();
    try {
        const parsed = JSON.parse(text);
        return zodSchemas_1.CareerReport.parse(parsed);
    }
    catch (error) {
        throw new Error('Failed to parse Gemini response as CareerReport');
    }
};
exports.generateStructuredCareerReport = generateStructuredCareerReport;
//# sourceMappingURL=geminiClient.js.map