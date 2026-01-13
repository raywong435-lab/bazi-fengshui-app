import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { birthInfoSchema, reportSchema } from '../types/zodSchemas';
import { generateContent } from '../services/geminiClient';
import { createChart } from './charts';
import { generateReportLogic } from './reports';

export const generateReport = functions.https.onCall(async (data, context) => {
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

    let quota: { month: string; count: number } = { month: currentMonth, count: 0 };
    if (quotaDoc.exists) {
      const data = quotaDoc.data()!;
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
  const cacheKey = `${birthInfo.birthDate}_${birthInfo.birthTime}_${birthInfo.location}`;
  const cacheRef = admin.firestore().collection('cache').doc(cacheKey);
  const cacheDoc = await cacheRef.get();

  if (cacheDoc.exists) {
    const cachedData = cacheDoc.data()!;
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
  const chartData = await createChart(chartInput);

  // Generate report
  const reportData = generateReportLogic(birthInfo, chartData);

  // Call Gemini for content
  const prompt = `Generate a detailed astrology report for someone born on ${birthInfo.birthDate} at ${birthInfo.birthTime} in ${birthInfo.location}.`;
  const content = await generateContent(prompt);

  const report = {
    ...reportData,
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