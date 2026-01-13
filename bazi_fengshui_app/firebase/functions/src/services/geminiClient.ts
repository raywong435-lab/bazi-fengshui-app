import { GoogleGenerativeAI } from '@google/generative-ai';

const genAI = new GoogleGenerativeAI(process.env.GENAI_KEY || process.env.GEMINI_API_KEY || '');

export const generateContent = async (prompt: string) => {
  const model = genAI.getGenerativeModel({ model: 'gemini-pro' });
  const result = await model.generateContent({ contents: [{ role: 'user', parts: [{ text: prompt }] }] } as any);
  const response = result.response;
  return response.text();
};

// For local builds, return parsed JSON without strict Zod validation to avoid missing schema imports.
export const generateFullReport = async (baziData: any): Promise<any> => {
  const prompt = `基于以下八字命盘数据，生成一份结构化的完整报告（JSON only）。八字数据: ${JSON.stringify(baziData)}`;
  const text = await generateContent(prompt);
  try {
    const parsed = JSON.parse(text);
    return parsed;
  } catch (error) {
    throw new Error('Failed to parse Gemini response as JSON');
  }
};