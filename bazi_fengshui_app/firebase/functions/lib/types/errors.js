"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ValidationError = exports.JsonParsingError = exports.GeminiApiError = void 0;
// src/errors.ts
class GeminiApiError extends Error {
    constructor(message) {
        super(message);
        this.name = 'GeminiApiError';
    }
}
exports.GeminiApiError = GeminiApiError;
class JsonParsingError extends Error {
    constructor(message) {
        super(message);
        this.name = 'JsonParsingError';
    }
}
exports.JsonParsingError = JsonParsingError;
class ValidationError extends Error {
    constructor(message, issues) {
        super(message);
        this.issues = issues;
        this.name = 'ValidationError';
    }
}
exports.ValidationError = ValidationError;
//# sourceMappingURL=errors.js.map