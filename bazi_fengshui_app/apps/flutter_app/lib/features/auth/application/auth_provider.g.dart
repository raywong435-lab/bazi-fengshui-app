// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'e3b22fd7863ea1be0b322870da43112c60f80087';

/// Provides the AuthRepository instance
///
/// Copied from [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$authStateChangesHash() => r'843eb1a621041def446e0ef856583a025a5a8e47';

/// Stream of authentication state changes
///
/// Copied from [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider = AutoDisposeStreamProvider<User?>.internal(
  authStateChanges,
  name: r'authStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateChangesRef = AutoDisposeStreamProviderRef<User?>;
String _$currentUserHash() => r'beedd437b6d28f4b92a31b760fefac8491066e22';

/// Current authenticated user (null if not signed in)
///
/// Copied from [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeProvider<User?>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRef = AutoDisposeProviderRef<User?>;
String _$signUpControllerHash() => r'93e000a15998b487a4b9f2393aa34bf11d0a8c44';

/// Sign up controller
///
/// Copied from [SignUpController].
@ProviderFor(SignUpController)
final signUpControllerProvider =
    AutoDisposeAsyncNotifierProvider<SignUpController, void>.internal(
  SignUpController.new,
  name: r'signUpControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signUpControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SignUpController = AutoDisposeAsyncNotifier<void>;
String _$signInControllerHash() => r'f8f04889b3ec5e4569b2b3204361e4dba01847ac';

/// Sign in controller
///
/// Copied from [SignInController].
@ProviderFor(SignInController)
final signInControllerProvider =
    AutoDisposeAsyncNotifierProvider<SignInController, void>.internal(
  SignInController.new,
  name: r'signInControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signInControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SignInController = AutoDisposeAsyncNotifier<void>;
String _$signOutControllerHash() => r'8a3aa72bcb6efa3ece924c4b92f85f76b25e18f2';

/// Sign out controller
///
/// Copied from [SignOutController].
@ProviderFor(SignOutController)
final signOutControllerProvider =
    AutoDisposeAsyncNotifierProvider<SignOutController, void>.internal(
  SignOutController.new,
  name: r'signOutControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signOutControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SignOutController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
