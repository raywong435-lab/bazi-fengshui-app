"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateReport = void 0;
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const zod_1 = require("zod");
const geminiClient_1 = require("../services/geminiClient");
const reportSchemas_1 = require("../types/reportSchemas");
const db = admin.firestore();
const PROMPT_VERSION = 'report-v1.0';
const inputSchema = zod_1.z.object({
    chartId: zod_1.z.string().min(1),
    reportType: zod_1.z.enum(['career', 'wealth', 'health', 'relationship']),
});
// generateReport callable: fetch chart by ID, check cache/quota, generate and cache report
exports.generateReport = functions.region('asia-east1').https.onCall(async (data, context) => {
    var _a;
    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }
    const uid = context.auth.uid;
    const parsed = reportSchemas_1.ReportRequestSchema.safeParse(data);
    if (!parsed.success) {
        throw new functions.https.HttpsError('invalid-argument', 'Invalid input', parsed.error.flatten());
    }
    const { chartId, reportType } = parsed.data;
    const cacheId = `${chartId}_${reportType}`;
    const cacheRef = db.collection('users').doc(uid).collection('reports').doc(cacheId);
    const cacheDoc = await cacheRef.get();
    if (cacheDoc.exists) {
        const cached = cacheDoc.data();
        if (((_a = cached.metadata) === null || _a === void 0 ? void 0 : _a.promptVersion) === PROMPT_VERSION) {
            return Object.assign(Object.assign({}, cached), { metadata: Object.assign(Object.assign({}, cached.metadata), { source: 'cache' }) });
        }
    }
    // Quota check and increment (monthly)
    await db.runTransaction(async (tx) => {
        const entRef = db.collection('users').doc(uid).collection('entitlements').doc('monthly');
        const entDoc = await tx.get(entRef);
        let ent = { quotaCount: 0, quotaLastReset: null };
        if (entDoc.exists)
            ent = entDoc.data();
        let { quotaCount = 0, quotaLastReset } = ent;
        const now = new Date();
        const lastResetDate = quotaLastReset ? quotaLastReset.toDate() : new Date(0);
        if (lastResetDate.getFullYear() < now.getFullYear() || lastResetDate.getMonth() < now.getMonth()) {
            quotaCount = 0;
        }
        const MONTHLY_LIMIT = 10;
        if (quotaCount >= MONTHLY_LIMIT) {
            throw new functions.https.HttpsError('permission-denied', `Monthly report limit (${MONTHLY_LIMIT}) reached.`);
        }
        tx.set(entRef, {
            quotaCount: admin.firestore.FieldValue.increment(1),
            quotaLastReset: admin.firestore.Timestamp.fromDate(now),
        }, { merge: true });
    });
    // Fetch chart document
    const chartRef = db.collection('users').doc(uid).collection('charts').doc(chartId);
    const chartDoc = await chartRef.get();
    if (!chartDoc.exists) {
        throw new functions.https.HttpsError('not-found', 'Chart not found');
    }
    const chartData = chartDoc.data();
    // Generate report: prefer structured FullReport when available
    let reportBody;
    try {
        if (reportType === 'career' || reportType === 'wealth' || reportType === 'health') {
            const full = await (0, geminiClient_1.generateFullReport)(chartData);
            // Map reportType to fields in FullReport if present
            if (full.annualFortune2026) {
                if (reportType === 'career')
                    reportBody = full.annualFortune2026.career || full;
                else if (reportType === 'wealth')
                    reportBody = full.annualFortune2026.wealth || full;
                else if (reportType === 'health')
                    reportBody = full.annualFortune2026.health || full;
                else
                    reportBody = full;
            }
            else {
                reportBody = full;
            }
        }
        else if (reportType === 'relationship') {
            const prompt = `基于以下八字命盘数据，生成一份详细的人际关系分析报告。请分析此人的性格特点、人际交往模式、适合的伴侣类型、潜在的感情挑战以及改善人际关系的建议。命盘数据: ${JSON.stringify(chartData)}`;
            const text = await (0, geminiClient_1.generateContent)(prompt);
            reportBody = { content: text };
        }
    }
    catch (err) {
        console.error('Report generation failed', err);
        throw new functions.https.HttpsError('internal', 'Report generation failed');
    }
    const metadata = {
        promptVersion: PROMPT_VERSION,
        deployTag: process.env.DEPLOY_TAG || 'local',
        source: 'gemini',
        chartId,
        reportType,
        generatedAt: new Date().toISOString(),
    };
    const reportToCache = { metadata, report: reportBody };
    // Validate response matches schema
    try {
        reportSchemas_1.FunctionResponseSchema.parse(reportToCache);
    }
    catch (err) {
        console.warn('Generated report did not match FunctionResponseSchema:', err);
        // Still cache raw result but mark source
    }
    // Optionally attach JSON Schema for AI to use (not stored on Firestore by default)
    reportToCache.__jsonSchema = reportSchemas_1.reportJsonSchema;
    await cacheRef.set(reportToCache);
    return reportToCache;
});
//# sourceMappingURL=generateReport.js.map