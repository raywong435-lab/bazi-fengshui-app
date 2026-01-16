import 'package:cloud_functions/cloud_functions.dart';
import '../../features/charts/data/models/chart_model.dart';

/// API client for Firebase Cloud Functions
class ApiClient {
  final FirebaseFunctions _functions;

  ApiClient({FirebaseFunctions? functions})
      : _functions = functions ?? FirebaseFunctions.instanceFor(region: 'asia-east1');

  /// Create a Bazi chart
  Future<ChartData> createChart(ChartRequest request) async {
    try {
      final callable = _functions.httpsCallable('createChart');
      final result = await callable.call<Map<String, dynamic>>({
        'chartName': request.chartName,
        'birthDate': request.birthDate,
        'gender': request.gender,
        if (request.timeZone != null) 'timeZone': request.timeZone,
      });

      return ChartData.fromJson(result.data);
    } on FirebaseFunctionsException catch (e) {
      throw _handleFunctionsError(e);
    } catch (e) {
      throw Exception('Failed to create chart: $e');
    }
  }

  /// Generate a report for a chart
  Future<Map<String, dynamic>> generateReport({
    required String chartId,
    required String reportType,
  }) async {
    try {
      final callable = _functions.httpsCallable('generateReport');
      final result = await callable.call<Map<String, dynamic>>({
        'chartId': chartId,
        'reportType': reportType,
      });

      return result.data;
    } on FirebaseFunctionsException catch (e) {
      throw _handleFunctionsError(e);
    } catch (e) {
      throw Exception('Failed to generate report: $e');
    }
  }

  /// Handle Firebase Functions errors
  Exception _handleFunctionsError(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'invalid-argument':
        return Exception('Invalid input: ${e.message}');
      case 'unauthenticated':
        return Exception('Please sign in to continue');
      case 'permission-denied':
        return Exception('Permission denied');
      case 'not-found':
        return Exception('Resource not found');
      case 'quota-exceeded':
        return Exception('Monthly quota exceeded');
      default:
        return Exception('Error: ${e.message}');
    }
  }
}