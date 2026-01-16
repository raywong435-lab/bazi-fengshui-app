import * as admin from 'firebase-admin';

// Initialize Firebase Admin once for the entire application
if (!admin.apps.length) {
  admin.initializeApp();
}

// Lazy-load Firestore to avoid initialization issues during deployment analysis
let _db: FirebaseFirestore.Firestore | null = null;

export function getDb(): FirebaseFirestore.Firestore {
  if (!_db) {
    _db = admin.firestore();
  }
  return _db;
}

export { admin };
