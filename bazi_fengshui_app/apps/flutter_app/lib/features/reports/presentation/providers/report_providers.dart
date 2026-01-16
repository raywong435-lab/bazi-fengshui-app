import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:bazi_fengshui_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:bazi_fengshui_app/features/reports/data/reports_repository.dart';

part 'report_providers.g.dart';

@riverpod
ReportsRepository reportsRepository(ReportsRepositoryRef ref) {
  final authState = ref.watch(authStateChangesProvider);
  final userId = authState.valueOrNull?.uid;
  return ReportsRepository(userId: userId);
}
