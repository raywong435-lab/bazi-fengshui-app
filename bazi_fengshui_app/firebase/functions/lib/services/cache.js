"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getFromCache = getFromCache;
exports.setCache = setCache;
const admin = require("firebase-admin");
const db = admin.firestore();
async function getFromCache(userId, cacheKey) {
    const ref = db.collection('users').doc(userId).collection('reports').doc(cacheKey);
    const doc = await ref.get();
    return doc.exists ? doc.data() : null;
}
async function setCache(userId, cacheKey, payload) {
    const ref = db.collection('users').doc(userId).collection('reports').doc(cacheKey);
    await ref.set(payload, { merge: true });
}
exports.default = { getFromCache, setCache };
//# sourceMappingURL=cache.js.map