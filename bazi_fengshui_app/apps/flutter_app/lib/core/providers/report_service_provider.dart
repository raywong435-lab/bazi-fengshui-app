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
      final reportData = await apiClient.generateReport(
        chartId: chartId,
        reportType: 'full',
      );
      final reportPayload = reportData['report'] is Map
          ? Map<String, dynamic>.from(reportData['report'] as Map)
          : reportData;
      return FullReport.fromJson(reportPayload);
    });

    final report = state.requireValue;
    if (report == null) {
      throw StateError('Report generation returned no data.');
    }
    return report;
  }
}
