import { GoogleGenerativeAI } from '@google/generative-ai';
import { FullReportSchema, FullReport } from '../types/zodSchemas';

const genAI = new GoogleGenerativeAI(process.env.GENAI_KEY!);

export const generateContent = async (prompt: string) => {
  const model = genAI.getGenerativeModel({ model: 'gemini-pro' });
  const result = await model.generateContent(prompt);
  const response = await result.response;
  return response.text();
};

export const generateFullReport = async (baziData: any): Promise<FullReport> => {
  const prompt = `
基于以下八字命盘数据，生成一份结构化的完整报告。请以JSON格式返回，严格遵循以下Schema：
{
  "originalChartAnalysis": {
    "strengthAnalysis": "string",
    "keyGods": {
      "fuyi": "string",
      "tongguan": "string",
      "bingyao": "string",
      "tiaohou": "string"
    },
    "shenSha": "string"
  },
  "annualFortune2026": {
    "career": "string",
    "wealth": "string",
    "health": "string"
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
    return FullReportSchema.parse(parsed);
  } catch (error) {
    throw new Error('Failed to parse Gemini response as FullReport');
  }
};