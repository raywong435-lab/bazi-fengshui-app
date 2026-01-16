import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/api_provider.dart';
import '../data/models/chart_model.dart';

part 'chart_service_provider.g.dart';

/// Service for creating charts via Cloud Functions
@riverpod
class ChartService extends _$ChartService {
  @override
  FutureOr<ChartData?> build() {
    return null;
  }

  /// Create a new chart with birth information
  Future<ChartData> createChart({
    required String name,
    required DateTime birthDateTime,
    required int gender, // 1 = male, 2 = female
    String? timeZone,
  }) async {
    state = const AsyncValue.loading();

    final result = await AsyncValue.guard(() async {
      final apiClient = ref.read(apiClientProvider);
      
      final request = ChartRequest(
        chartName: name,
        birthDate: birthDateTime.toIso8601String(),
        gender: gender,
        timeZone: timeZone ?? 'Asia/Taipei',
      );

      final chartData = await apiClient.createChart(request);
      return chartData;
    });

    state = result;
    final chartData = result.value;
    if (chartData == null) {
      throw StateError('Chart creation returned no data.');
    }
    return chartData;
  }
}
