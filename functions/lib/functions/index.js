"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateReport = void 0;
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const zodSchemas_1 = require("../types/zodSchemas");
const geminiClient_1 = require("../services/geminiClient");
const charts_1 = require("./charts");
const reports_1 = require("./reports");
exports.generateReport = functions.https.onCall(async (data, context) => {
    // Check authentication
    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
    }
    const userId = context.auth.uid;
    // Validate input
    const birthInfo = zodSchemas_1.birthInfoSchema.parse(data);
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
    // Create chart
    const birthDate = new Date(birthInfo.birthDate);
    const [hourStr] = birthInfo.birthTime.split(':');
    const hour = parseInt(hourStr);
    const chartInput = {
        year: birthDate.getFullYear(),
        month: birthDate.getMonth() + 1,
        day: birthDate.getDate(),
        hour: hour,
        gender: 1, // 1 for male, placeholder
    };
    const chartData = await (0, charts_1.createChart)(chartInput);
    // Generate report
    const reportData = (0, reports_1.generateReportLogic)(birthInfo, chartData);
    // Call Gemini for content
    const prompt = `Generate a detailed astrology report for someone born on ${birthInfo.birthDate} at ${birthInfo.birthTime} in ${birthInfo.birthPlace}.`;
    const content = await (0, geminiClient_1.generateContent)(prompt);
    const report = Object.assign(Object.assign({}, reportData), { content, metadata: {
            deployTag: 'v1.0.0',
            promptVersion: '1.0',
            source: 'gemini',
        } });
    // Validate with Zod
    zodSchemas_1.reportSchema.parse(report);
    // Cache the report
    await cacheRef.set({
        report,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    return report;
});
//# sourceMappingURL=index.js.map