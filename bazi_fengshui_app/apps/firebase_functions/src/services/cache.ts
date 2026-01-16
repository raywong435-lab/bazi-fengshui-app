import * as admin from 'firebase-admin';

const db = admin.firestore();

export async function getFromCache(userId: string, cacheKey: string): Promise<any | null> {
  const ref = db.collection('users').doc(userId).collection('reports').doc(cacheKey);
  const doc = await ref.get();
  return doc.exists ? doc.data() : null;
}

export async function setCache(userId: string, cacheKey: string, payload: any): Promise<void> {
  const ref = db.collection('users').doc(userId).collection('reports').doc(cacheKey);
  await ref.set(payload, { merge: true });
}

export default { getFromCache, setCache };
