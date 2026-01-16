import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/api_client.dart';
import 'firebase_providers.dart';

part 'api_provider.g.dart';

/// Provides the ApiClient instance
@riverpod
ApiClient apiClient(ApiClientRef ref) {
  final functions = ref.watch(firebaseFunctionsProvider);
  return ApiClient(functions: functions);
}
