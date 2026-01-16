/**
 * @deprecated Use /users/{userId}/entitlements/monthly instead.
 * This module is kept for backward compatibility but should not be used in new code.
 * See generateReport.ts for the canonical quota implementation.
 */
import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

const MONTHLY_QUOTA_LIMIT = 5; // 每月 AI 報告的免費額度

/**
 * 在傳入的 Transaction 中檢查並遞增使用者的月度配額計數。
 * - 若文件不存在或為跨月，會初始化為 1 並設定 lastResetMonth
 * - 若配額已用盡，會拋出 HttpsError('resource-exhausted')
 *
 * Firestore 資料模型:
 * 集合: userQuotas
 * 文件 ID: userId
 * 結構: { monthlyReportCount: number, lastResetMonth: number } (例如 202407)
 */
export async function checkAndDecrementQuota(
  transaction: admin.firestore.Transaction,
  userId: string
): Promise<void> {
  const db = admin.firestore();
  const userQuotaRef = db.collection('userQuotas').doc(userId);
  const now = new Date();
  const currentMonth = now.getFullYear() * 100 + (now.getMonth() + 1); // e.g., 202407

  const userQuotaDoc = await transaction.get(userQuotaRef);

  if (!userQuotaDoc.exists) {
    transaction.set(userQuotaRef, { monthlyReportCount: 1, lastResetMonth: currentMonth });
    return;
  }

  const quotaData = userQuotaDoc.data()!;
  const lastResetMonth = quotaData.lastResetMonth || 0;

  if (lastResetMonth < currentMonth) {
    // 跨月重置
    transaction.update(userQuotaRef, { monthlyReportCount: 1, lastResetMonth: currentMonth });
    return;
  }

  const monthlyCount = quotaData.monthlyReportCount || 0;
  if (monthlyCount >= MONTHLY_QUOTA_LIMIT) {
    throw new functions.https.HttpsError('resource-exhausted', '您本月的 AI 報告配額已用盡。');
  }

  // 安全地遞增計數
  transaction.update(userQuotaRef, { monthlyReportCount: admin.firestore.FieldValue.increment(1) });
}

export default checkAndDecrementQuota;
