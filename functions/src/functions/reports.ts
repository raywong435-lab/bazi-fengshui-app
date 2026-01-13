// Placeholder for report generation logic
export const generateReportLogic = (birthInfo: any, chartData: any) => {
  // Implement report generation
  return { content: 'placeholder report' };
};

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { generateFullReport } from "../services/geminiClient";
import { FullReport } from "../types/zodSchemas";

const db = admin.firestore();
// 关键：在代码中定义 Prompt 版本。当优化 Prompt 或 Schema 时，递增此版本号即可自动让旧快取失效。
const promptVersion = "career-v1.4";

export const generateCareerReport = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "The function must be called while authenticated.");
  }
  const uid = context.auth.uid;
  const { chartId, baziData, reportType } = data;
  if (!baziData || !chartId || !reportType) {
    throw new functions.https.HttpsError("invalid-argument", "必须提供完整的图表ID、八字数据和报告类型。");
  }

  // 1. [关键] 设计稳定且唯一的快取文件 ID
  const cacheId = `${chartId}_${reportType}`;
  const cacheRef = db.collection("reports").doc(cacheId);

  // 2. [关键] 检查 Firestore 智慧快取
  const cacheDoc = await cacheRef.get();
  if (cacheDoc.exists) {
    const cachedReport = cacheDoc.data() as any;
    // 检查快取中的 promptVersion 是否与当前代码版本匹配
    if (cachedReport.metadata?.promptVersion === promptVersion) {
      console.log(`快取命中 (Cache Hit): ${cacheId}, 版本: ${promptVersion}`);
      // 快取命中，标记来源为 "cache" 并直接返回
      return {
        ...cachedReport,
        metadata: { ...cachedReport.metadata, source: "cache" },
      };
    }
    console.log(`快取失效 (Stale Cache): ${cacheId}, 旧版本: ${cachedReport.metadata?.promptVersion}, 新版本: ${promptVersion}`);
  } else {
    console.log(`快取未命中 (Cache Miss): ${cacheId}`);
  }

  // --- 快取未命中或失效，继续执行 ---

  // 3. [关键] 执行 Firestore 事务，安全地检查和更新配额
  await db.runTransaction(async (transaction) => {
    const userRef = db.doc(`users/${uid}`);
    const userDoc = await transaction.get(userRef);
    if (!userDoc.exists) { throw new functions.https.HttpsError("not-found", "找不到用户资料。"); }

    const userData = userDoc.data()!;
    let { quotaCount = 0, quotaLastReset } = userData;
    const MONTHLY_QUOTA_LIMIT = 5;

    const now = new Date();
    const lastResetDate = quotaLastReset ? quotaLastReset.toDate() : new Date(0);

    if (lastResetDate.getFullYear() < now.getFullYear() || lastResetDate.getMonth() < now.getMonth()) {
      quotaCount = 0; // 跨月重置
    }

    if (quotaCount >= MONTHLY_QUOTA_LIMIT) {
      throw new functions.https.HttpsError("permission-denied", `本月报告生成次数已达 ${MONTHLY_QUOTA_LIMIT} 次上限。`);
    }

    transaction.update(userRef, {
      quotaCount: admin.firestore.FieldValue.increment(1),
      quotaLastReset: admin.firestore.Timestamp.fromDate(now),
    });
  });

  // --- 配额检查通过，继续执行报告生成逻辑 ---

  // 4. 调用 Gemini 客户端生成报告
  const validatedReport: FullReport = await generateFullReport(baziData);

  // 5. 封装元数据 (Metadata)
  const deployTag = process.env.DEPLOY_TAG || "local";
  const metadata = {
    deployTag,
    promptVersion,
    source: "gemini", // 标记来源为新生成
    timestamp: new Date().toISOString(),
    chartId,
    reportType,
  };

  const reportToCache = { metadata, report: validatedReport };

  // 6. [关键] 将新生成的报告写入 Firestore 快取
  await cacheRef.set(reportToCache);
  console.log(`写入新快取: ${cacheId}`);

  // 7. 返回给客户端
  return reportToCache;
});