import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/api_provider.dart';
import '../../../shared/models/report_response.dart';
import '../../../shared/providers/debug_providers.dart';
import '../../auth/application/auth_provider.dart';
import '../../charts/data/charts_repository.dart';
import '../../charts/data/models/chart_model.dart';
import '../data/models/report_model.dart';

part 'report_provider.g.dart';

/// Data class combining chart and full report for ReportScreen
class ReportScreenData {
  final ChartData chart;
  final FullReport report;

  ReportScreenData({required this.chart, required this.report});
}

/// Provider for ReportScreen data (chart + aggregated report)
@riverpod
Future<ReportScreenData> reportScreenData(
  ReportScreenDataRef ref, {
  required String chartId,
}) async {
  // Get authenticated user
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    throw Exception('User must be authenticated to fetch report data');
  }
  final userId = user.uid;

  // Get dependencies
  final chartsRepository = ref.watch(chartsRepositoryProvider);
  final apiClient = ref.watch(apiClientProvider);

  // Define report types to fetch
  // Fetch chart data and full report in parallel
  final results = await Future.wait([
    chartsRepository.getChartData(userId: userId, chartId: chartId),
    apiClient.generateReport(chartId: chartId, reportType: 'full'),
  ]);

  final chart = results[0] as ChartData;
  final reportData = results[1] as Map<String, dynamic>;
  final reportPayload = reportData['report'] is Map
      ? Map<String, dynamic>.from(reportData['report'] as Map)
      : reportData;
  final fullReport = FullReport.fromJson(reportPayload);

  return ReportScreenData(chart: chart, report: fullReport);
}

@riverpod
class ReportNotifier extends _$ReportNotifier {
  @override
  Future<FunctionResponse?> build() {
    // 初始狀態為 null，不自動載入
    return Future.value(null);
  }

  Future<void> generateReport({
    required String chartId,
    required String reportType,
    bool forceRefresh = false,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // Get API client
      final apiClient = ref.read(apiClientProvider);

      // Call generateReport with reportType
      final result = await apiClient.generateReport(
        chartId: chartId,
        reportType: reportType,
      );

      // Parse response
      final response = FunctionResponse(
        report: const ReportDataJsonConverter().fromJson(result),
        metadata: ReportMetadata.fromJson(result['metadata'] as Map<String, dynamic>),
      );

      // 更新偵錯 Provider 的 metadata（供 DebugOverlay 顯示）
      ref.read(latestReportMetadataProvider.notifier).state = response.metadata;

      return response;
    });
  }
}
