import * as functions from 'firebase-functions/v1';
import { defineString } from 'firebase-functions/params';
import { GoogleGenerativeAI, GenerationConfig } from '@google/generative-ai';
import { z } from 'zod';
import { GeminiApiError, JsonParsingError, ValidationError } from '../types/errors';

// Resolve API key in this priority order:
// 1) Environment parameter (runtime): `GEMINI_API_KEY` from Firebase Secrets
// 2) Environment variable `GEMINI_API_KEY`
// 3) Legacy env var `GENAI_KEY`
// NOTE: We do NOT call .value() at module load time (deploy-time) to avoid
// triggering params evaluation during deployment. Instead, resolve lazily at runtime.
const GEMINI_KEY_PARAM = defineString('GEMINI_API_KEY');

function getApiKey(): string {
  // Resolve in priority order: param -> env var -> legacy env var
  const apiKeyFromParam = GEMINI_KEY_PARAM.value();
  const API_KEY = apiKeyFromParam || process.env.GEMINI_API_KEY || process.env.GENAI_KEY || '';
  if (!API_KEY) {
    console.warn('Warning: Gemini API key not found in Firebase Secrets, GEMINI_API_KEY, or GENAI_KEY env vars.');
  }
  return API_KEY;
}

function getGenerativeModel() {
  const API_KEY = getApiKey();
  const genAI = new GoogleGenerativeAI(API_KEY);
  return genAI.getGenerativeModel({ model: 'gemini-pro' });
}

export async function generateAndValidateJson<T extends z.ZodTypeAny>(
  prompt: string,
  schema: T
): Promise<z.infer<T>> {
  const generationConfig: GenerationConfig = {};
  const generativeModel = getGenerativeModel();

  try {
    const result = await generativeModel.generateContent({
      contents: [{ role: 'user', parts: [{ text: prompt }] }],
      generationConfig,
    });

    const response = result.response;
    const responseText = response.text();

    if (!responseText) {
      throw new GeminiApiError('Gemini API returned an empty response.');
    }

    let parsedJson: any;
    try {
      parsedJson = JSON.parse(responseText);
    } catch (error) {
      throw new JsonParsingError(`Failed to parse Gemini response as JSON. Raw text: "${responseText}"`);
    }

    const validationResult = schema.safeParse(parsedJson);
    if (!validationResult.success) {
      throw new ValidationError('Gemini response failed Zod validation.', validationResult.error.issues);
    }

    return validationResult.data;
  } catch (error: any) {
    if (error instanceof ValidationError || error instanceof JsonParsingError) {
      throw error;
    }
    console.error('Gemini API call failed:', error);
    throw new GeminiApiError(`Gemini API call failed: ${error?.message || error}`);
  }
}

/**
 * Build prompt template for Bazi report generation.
 * Note: We use array.join() instead of template literals with triple-backticks
 * to avoid TypeScript compiler issues with code fence markers in strings.
 */
// Use a small, manually authored simplified JSON schema for guiding the model when zod->json-schema
// conversion is too deep/complex. Final validation is still done with the Zod schema.
export function createPrompt(
  baziData: Record<string, any>,
  reportType: string,
  simplifiedSchema?: object
): string {
  const baziInfo = JSON.stringify(baziData, null, 2);

  const schemaForPrompt =
    simplifiedSchema ||
    ({
      type: 'object',
      properties: {
        reportType: { type: 'string' },
        title: { type: 'string' },
        summary: { type: 'string' },
        recommendations: { type: 'array', items: { type: 'string' } },
      },
      required: ['reportType', 'title', 'summary'],
    } as const);

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

export async function generateReportWithGemini(chartData: Record<string, any>, reportType: string) {
  const prompt = createPrompt(chartData, reportType);
  // Import Zod schema at runtime to avoid circular import/type explosion
  const { ReportDataSchema } = await import('../types/reportSchemas');

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
  const validated = await generateAndValidateJson(prompt + '\n\n' + JSON.stringify(simplifiedForPrompt), ReportDataSchema as z.ZodTypeAny);
  return validated;
}

/**
 * Simple wrapper for Gemini content generation.
 * Called by generateReportWithGemini and other functions.
 */
export const generateContent = async (prompt: string) => {
  const model = getGenerativeModel();
  const result = await model.generateContent({
    contents: [{ role: 'user', parts: [{ text: prompt }] }]
  } as any);
  const response = result.response;
  return response.text();
};

/**
 * Generate full structured report from Bazi data.
 * Returns parsed JSON response.
 */
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