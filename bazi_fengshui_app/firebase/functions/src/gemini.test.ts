// src/gemini.test.ts
import { z } from 'zod';
import { JsonParsingError, ValidationError, GeminiApiError } from './types/errors';

// 模擬整個 @google/generative-ai 模組
const mockGenerateContent = jest.fn();
jest.mock('@google/generative-ai', () => {
  // 模擬類別和方法
  return {
    GoogleGenerativeAI: jest.fn().mockImplementation(() => {
      return {
        getGenerativeModel: jest.fn().mockReturnValue({
          generateContent: mockGenerateContent,
        }),
      };
    }),
  };
});

// Import after mock
import { generateAndValidateJson } from './gemini';

// 定義一個測試用的 Zod schema
const UserProfileSchema = z.object({
  name: z.string().min(1),
  age: z.number().positive(),
  email: z.string().email(),
});

describe('generateAndValidateJson', () => {
  // 在每次測試前重置 mock
  beforeEach(() => {
    mockGenerateContent.mockClear();
  });

  // 測試 1: 成功路徑 - API 返回有效且符合 schema 的 JSON
  test('應成功解析並驗證有效的 JSON 回應', async () => {
    const mockApiResponse = {
      name: 'John Doe',
      age: 30,
      email: 'john.doe@example.com',
    };

    // 設定 mock 函數的返回值
    mockGenerateContent.mockResolvedValue({
      response: {
        text: () => JSON.stringify(mockApiResponse),
      },
    });

    const result = await generateAndValidateJson('創建一個使用者個人資料', UserProfileSchema);

    expect(result).toEqual(mockApiResponse);
    expect(mockGenerateContent).toHaveBeenCalledTimes(1);
    // 驗證 prompt 是否包含 JSON 指導
    expect(mockGenerateContent.mock.calls[0][0].contents[0].parts[0].text).toContain('請以有效的 JSON 格式提供您的回覆');
  });

  // 測試 2: 錯誤路徑 - API 返回的不是有效的 JSON 字串
  test('當 API 回應不是有效的 JSON 時應拋出 JsonParsingError', async () => {
    const invalidJsonString = '這不是一個JSON';

    mockGenerateContent.mockResolvedValue({
      response: {
        text: () => invalidJsonString,
      },
    });

    await expect(generateAndValidateJson('無關緊要的 prompt', UserProfileSchema))
      .rejects.toThrow(JsonParsingError);

    await expect(generateAndValidateJson('無關緊要的 prompt', UserProfileSchema))
      .rejects.toThrow(`無法解析 Gemini API 的回應為 JSON。收到的原始文字: "${invalidJsonString}"`);
  });

  // 測試 3: 錯誤路徑 - JSON 結構有效，但不符合 Zod schema
  test('當 JSON 不符合 Zod schema 時應拋出 ValidationError', async () => {
    const nonConformingData = {
      name: 'Jane Doe',
      // 'age' 屬性缺失
      email: 'jane.doe@example.com',
    };

    mockGenerateContent.mockResolvedValue({
      response: {
        text: () => JSON.stringify(nonConformingData),
      },
    });

    await expect(generateAndValidateJson('無關緊要的 prompt', UserProfileSchema))
      .rejects.toThrow(ValidationError);

    try {
      await generateAndValidateJson('無關緊要的 prompt', UserProfileSchema);
    } catch (error) {
      if (error instanceof ValidationError) {
        expect(error.message).toBe('Gemini API 的回應未通過 Zod 驗證。');
        expect(error.issues).toHaveLength(1);
        expect(error.issues[0].code).toBe('invalid_type');
        expect(error.issues[0].path).toEqual(['age']);
      } else {
        fail('預期拋出 ValidationError，但收到了其他錯誤');
      }
    }
  });

  // 測試 4: 錯誤路徑 - API 呼叫本身失敗
  test('當 generateContent 拋出錯誤時應拋出 GeminiApiError', async () => {
    const apiErrorMessage = 'API rate limit exceeded';
    mockGenerateContent.mockRejectedValue(new Error(apiErrorMessage));

    await expect(generateAndValidateJson('無關緊要的 prompt', UserProfileSchema))
      .rejects.toThrow(GeminiApiError);

    await expect(generateAndValidateJson('無關緊要的 prompt', UserProfileSchema))
      .rejects.toThrow(`Gemini API 呼叫失敗: ${apiErrorMessage}`);
  });
});