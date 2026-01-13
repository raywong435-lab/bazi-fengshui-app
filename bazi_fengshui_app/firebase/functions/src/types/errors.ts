// src/errors.ts
export class GeminiApiError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'GeminiApiError';
  }
}

export class JsonParsingError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'JsonParsingError';
  }
}

export class ValidationError extends Error {
  constructor(message: string, public issues: any[]) {
    super(message);
    this.name = 'ValidationError';
  }
}