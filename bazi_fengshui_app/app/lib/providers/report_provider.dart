import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/birth_info.dart';
import '../data/models/report.dart';
import '../data/services/firebase_service.dart';

final reportProvider = StateNotifierProvider<ReportNotifier, AsyncValue<Report?>>((ref) {
  return ReportNotifier();
});

class ReportNotifier extends StateNotifier<AsyncValue<Report?>> {
  ReportNotifier() : super(const AsyncValue.data(null));

  Future<void> generateReport(BirthInfo birthInfo) async {
    state = const AsyncValue.loading();
    try {
      final reportData = await FirebaseService.generateReport(birthInfo);
      final report = Report.fromJson(reportData);
      state = AsyncValue.data(report);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}