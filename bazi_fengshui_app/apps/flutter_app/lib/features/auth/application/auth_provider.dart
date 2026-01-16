import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/auth_repository.dart';

part 'auth_provider.g.dart';

/// Provides the AuthRepository instance
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository();
}

/// Stream of authentication state changes
@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
}

/// Current authenticated user (null if not signed in)
@riverpod
User? currentUser(CurrentUserRef ref) {
  final authState = ref.watch(authStateChangesProvider);
  return authState.when(
    data: (user) => user,
    loading: () => null,
    error: (_, __) => null,
  );
}

/// Sign up controller
@riverpod
class SignUpController extends _$SignUpController {
  @override
  FutureOr<void> build() {}

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.signUp(
        email: email,
        password: password,
        displayName: displayName,
      );
    });
  }
}

/// Sign in controller
@riverpod
class SignInController extends _$SignInController {
  @override
  FutureOr<void> build() {}

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.signIn(
        email: email,
        password: password,
      );
    });
  }
}

/// Sign out controller
@riverpod
class SignOutController extends _$SignOutController {
  @override
  FutureOr<void> build() {}

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.signOut();
    });
  }
}
