"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.resetMonthlyQuota = void 0;
const functions = require("firebase-functions/v1");
const firebase_1 = require("../config/firebase");
const DEFAULT_MONTHLY_QUOTA = 10;
/**
 * Scheduled Cloud Function: resets all user monthly report quotas on the 1st of each month.
 * Runs at 00:00 Asia/Taipei time (cron: '0 0 1 * *').
 *
 * @async
 * @returns {Promise<null>} Completes after batch updating all users
 * @throws {Error} If batch write fails
 */
exports.resetMonthlyQuota = functions
    .region('asia-east1')
    .pubsub.schedule('0 0 1 * *')
    .timeZone('Asia/Taipei')
    .onRun(async () => {
    functions.logger.info('開始執行每月配額重設排程...');
    const db = (0, firebase_1.getDb)();
    const usersRef = db.collection('users');
    const snapshot = await usersRef.get();
    if (snapshot.empty) {
        functions.logger.info('沒有找到任何使用者，任務結束。');
        return null;
    }
    const MAX_WRITES_PER_BATCH = 499;
    let batch = db.batch();
    let writeCount = 0;
    const commitPromises = [];
    snapshot.forEach((doc) => {
        const userRef = doc.ref;
        const updateData = {
            monthlyReportCount: DEFAULT_MONTHLY_QUOTA,
            lastResetDate: firebase_1.admin.firestore.FieldValue.serverTimestamp(),
        };
        batch.update(userRef, updateData);
        writeCount++;
        if (writeCount === MAX_WRITES_PER_BATCH) {
            functions.logger.info(`提交 ${writeCount} 個用戶的更新...`);
            commitPromises.push(batch.commit());
            batch = db.batch();
            writeCount = 0;
        }
    });
    if (writeCount > 0) {
        functions.logger.info(`提交最後 ${writeCount} 個用戶的更新...`);
        commitPromises.push(batch.commit());
    }
    try {
        await Promise.all(commitPromises);
        functions.logger.info(`成功重設 ${snapshot.size} 位用戶的每月配額。`);
    }
    catch (error) {
        functions.logger.error('在批次更新用戶配額時發生錯誤:', error);
        throw error;
    }
    return null;
});
//# sourceMappingURL=resetMonthlyQuota.js.map