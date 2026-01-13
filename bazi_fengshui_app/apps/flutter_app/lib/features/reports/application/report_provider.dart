import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../shared/models/report_response.dart';
import '../../../shared/providers/debug_providers.dart';

part 'report_provider.g.dart';

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
      // 讀取 FirebaseFunctions 實例
      final functions = ref.read(firebaseFunctionsProvider);
      final callable = functions.httpsCallable('generateReport');

      final result = await callable.call<Map<String, dynamic>>({
        'chartId': chartId,
        'reportType': reportType,
        'forceRefresh': forceRefresh,
      });

      // 使用 Freezed 模型進行解析
      final response = FunctionResponse.fromJson(result.data);

      // 更新偵錯 Provider 的 metadata（供 DebugOverlay 顯示）
      ref.read(latestReportMetadataProvider.notifier).state = response.metadata;

      return response;
    });
  }
}
