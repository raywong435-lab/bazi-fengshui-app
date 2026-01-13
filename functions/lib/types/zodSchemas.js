"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CareerReport = exports.reportSchema = exports.birthInfoSchema = void 0;
const zod_1 = require("zod");
exports.birthInfoSchema = zod_1.z.object({
    birthDate: zod_1.z.string(),
    birthTime: zod_1.z.string(),
    birthPlace: zod_1.z.string(),
});
exports.reportSchema = zod_1.z.object({
    content: zod_1.z.string(),
    metadata: zod_1.z.object({
        deployTag: zod_1.z.string(),
        promptVersion: zod_1.z.string(),
        source: zod_1.z.string(),
    }),
});
exports.CareerReport = zod_1.z.object({
    careerPath: zod_1.z.string(),
    strengths: zod_1.z.array(zod_1.z.string()),
    challenges: zod_1.z.array(zod_1.z.string()),
    recommendations: zod_1.z.array(zod_1.z.string()),
    timeline: zod_1.z.object({
        shortTerm: zod_1.z.string(),
        longTerm: zod_1.z.string(),
    }),
});
//# sourceMappingURL=zodSchemas.js.map