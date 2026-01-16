import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/api_provider.dart';
import '../../../shared/models/report_response.dart';
import '../../../shared/providers/debug_providers.dart';
import '../../auth/application/auth_provider.dart';
import '../../charts/data/charts_repository.dart';
import '../../charts/data/models/chart_model.dart';

part 'report_provider.g.dart';

/// Data class combining chart and full report for ReportScreen
class ReportScreenData {
  final Chart chart;
  final FullReport report;

  ReportScreenData({required this.chart, required this.report});
}

/// Full report containing all report types
class FullReport {
  final CareerReport career;
  final WealthReport wealth;
  final HealthReport health;
  final RelationshipReport relationship;

  FullReport({
    required this.career,
    required this.wealth,
    required this.health,
    required this.relationship,
  });
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
  const reportTypes = ['career', 'wealth', 'health', 'relationship'];

  // Fetch all data in parallel
  final results = await Future.wait([
    // Fetch chart data
    chartsRepository.getChart(userId: userId, chartId: chartId),
    // Fetch all report types
    ...reportTypes.map((reportType) => apiClient.generateReport(
          chartId: chartId,
          reportType: reportType,
        )),
  ]);

  // Extract chart (first result)
  final chart = results[0] as Chart;

  // Extract and parse report parts (remaining results)
  final careerData = results[1] as Map<String, dynamic>;
  final wealthData = results[2] as Map<String, dynamic>;
  final healthData = results[3] as Map<String, dynamic>;
  final relationshipData = results[4] as Map<String, dynamic>;

  // Parse individual reports using the converter
  const converter = ReportDataJsonConverter();
  final careerReport = converter.fromJson(careerData) as CareerReport;
  final wealthReport = converter.fromJson(wealthData) as WealthReport;
  final healthReport = converter.fromJson(healthData) as HealthReport;
  final relationshipReport = converter.fromJson(relationshipData) as RelationshipReport;

  // Construct full report
  final fullReport = FullReport(
    career: careerReport,
    wealth: wealthReport,
    health: healthReport,
    relationship: relationshipReport,
  );

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
