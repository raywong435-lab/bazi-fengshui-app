// features/reports/presentation/providers/report_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:bazi_fengshui_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:bazi_fengshui_app/features/reports/data/reports_repository.dart';

part 'report_providers.g.dart';

// reportRepositoryProvider 依賴於 authStateChangesProvider
@riverpod
ReportsRepository reportsRepository(ReportsRepositoryRef ref) {
  // 監聽認證狀態
  final authState = ref.watch(authStateChangesProvider);
  // 當用戶登入時，傳入 userId，否則傳入 null
  final userId = authState.valueOrNull?.uid;
  return ReportsRepository(userId: userId);
}