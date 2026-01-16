import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'api_provider.dart';
import '../../features/reports/data/models/report_model.dart';

part 'report_service_provider.g.dart';

/// Service for generating reports via Cloud Functions
@riverpod
class ReportService extends _$ReportService {
  @override
  FutureOr<FullReport?> build() {
    return null;
  }

  /// Generate a report for a chart
  Future<FullReport> generateReport(String chartId) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final apiClient = ref.read(apiClientProvider);
      final report = await apiClient.generateReport(chartId);
      return report;
    });

    return state.requireValue;
  }
}
