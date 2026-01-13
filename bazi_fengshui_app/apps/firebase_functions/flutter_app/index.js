"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateReport = void 0;
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const zod_1 = require("zod");
const generative_ai_1 = require("@google/generative-ai");
admin.initializeApp();
const genAI = new generative_ai_1.GoogleGenerativeAI(functions.config().genai.key);
const birthInfoSchema = zod_1.z.object({
    birthDate: zod_1.z.string(),
    birthTime: zod_1.z.string(),
    birthPlace: zod_1.z.string(),
});
const reportSchema = zod_1.z.object({
    content: zod_1.z.string(),
    metadata: zod_1.z.object({
        deployTag: zod_1.z.string(),
        promptVersion: zod_1.z.string(),
        source: zod_1.z.string(),
    }),
});
exports.generateReport = functions.https.onCall(async (data, context) => {
    // Check authentication
    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
    }
    const userId = context.auth.uid;
    // Validate input
    const birthInfo = birthInfoSchema.parse(data);
    // Check and update quota
    const userRef = admin.firestore().collection('users').doc(userId);
    const quotaRef = userRef.collection('quotas').doc('monthly');
    await admin.firestore().runTransaction(async (transaction) => {
        const quotaDoc = await transaction.get(quotaRef);
        const currentMonth = new Date().toISOString().slice(0, 7); // YYYY-MM
        let quota = { month: currentMonth, count: 0 };
        if (quotaDoc.exists) {
            const data = quotaDoc.data();
            quota = {
                month: data.month || currentMonth,
                count: data.count || 0,
            };
            if (quota.month !== currentMonth) {
                quota = { month: currentMonth, count: 0 };
            }
        }
        if (quota.count >= 10) { // Assume 10 reports per month
            throw new functions.https.HttpsError('resource-exhausted', 'Monthly quota exceeded');
        }
        quota.count += 1;
        transaction.set(quotaRef, quota);
    });
    // Check cache
    const cacheKey = `${birthInfo.birthDate}_${birthInfo.birthTime}_${birthInfo.birthPlace}`;
    const cacheRef = admin.firestore().collection('cache').doc(cacheKey);
    const cacheDoc = await cacheRef.get();
    if (cacheDoc.exists) {
        const cachedData = cacheDoc.data();
        // Assume version check, for simplicity skip
        return cachedData.report;
    }
    // Generate prompt
    const prompt = `Generate a detailed astrology report for someone born on ${birthInfo.birthDate} at ${birthInfo.birthTime} in ${birthInfo.birthPlace}.`;
    // Call Gemini
    const model = genAI.getGenerativeModel({ model: 'gemini-pro' });
    const result = await model.generateContent(prompt);
    const response = await result.response;
    const content = response.text();
    const report = {
        content,
        metadata: {
            deployTag: 'v1.0.0',
            promptVersion: '1.0',
            source: 'gemini',
        },
    };
    // Validate with Zod
    reportSchema.parse(report);
    // Cache the report
    await cacheRef.set({
        report,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    return report;
});
//# sourceMappingURL=index.js.map