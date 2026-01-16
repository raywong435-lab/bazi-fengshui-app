"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.birthInfoSchema = void 0;
const zod_1 = require("zod");
// Birth info schema for input validation
exports.birthInfoSchema = zod_1.z.object({
    name: zod_1.z.string(),
    birthDate: zod_1.z.string(), // ISO date string
    birthTime: zod_1.z.string(), // HH:MM format
    gender: zod_1.z.enum(['male', 'female']),
    location: zod_1.z.string(), // city or coordinates
});
//# sourceMappingURL=zodSchemas.js.map