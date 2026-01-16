import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:bazi_fengshui_app/features/auth/application/auth_provider.dart';

import 'package:bazi_fengshui_app/screens/input_screen.dart';
import 'package:bazi_fengshui_app/features/reports/presentation/report_screen.dart';
import 'package:bazi_fengshui_app/core/screens/auth_screen.dart';

part 'app_router.g.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final authAsync = ref.watch(authStateChangesProvider);
  final isAuthenticated = authAsync.value != null;

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(
      ref.watch(authStateChangesProvider.stream),
    ),
    redirect: (context, state) {
      final isAuthRoute = state.matchedLocation == '/auth';

      if (!isAuthenticated && !isAuthRoute) {
        return '/auth';
      }

      if (isAuthenticated && isAuthRoute) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const InputScreen(),
      ),
      GoRoute(
        path: '/report',
        name: 'report',
        builder: (context, state) {
          final chartId = state.uri.queryParameters['chartId'];
          if (chartId == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Report Error')),
              body: const Center(
                child: Text('Missing chartId for report route.'),
              ),
            );
          }
          return ReportScreen(chartId: chartId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Routing Error')),
      body: Center(
        child: Text('No route for: ${state.matchedLocation}'),
      ),
    ),
  );
}
