import 'package:firebase_auth/firebase_auth.dart';

/// Authentication repository for Firebase Auth
class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  /// Current user stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Current user
  User? get currentUser => _auth.currentUser;

  /// Sign up with email and password
  Future<User?> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (displayName != null && credential.user != null) {
        await credential.user!.updateDisplayName(displayName);
        await credential.user!.reload();
      }

      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Sign in with email and password
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Send password reset email
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Handle Firebase Auth errors
  Exception _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return Exception('密碼強度不足，請使用更複雜的密碼');
      case 'email-already-in-use':
        return Exception('此電子郵件已被使用');
      case 'user-not-found':
        return Exception('找不到此用戶');
      case 'wrong-password':
        return Exception('密碼錯誤');
      case 'invalid-email':
        return Exception('無效的電子郵件地址');
      case 'user-disabled':
        return Exception('此帳戶已被停用');
      case 'too-many-requests':
        return Exception('請求過於頻繁，請稍後再試');
      default:
        return Exception('認證錯誤: ${e.message}');
    }
  }
}