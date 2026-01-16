import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/firebase_providers.dart';
import 'models/chart_model.dart';

part 'charts_repository.g.dart';

/// Repository for chart-related data access
class ChartsRepository {
  ChartsRepository({required this.functions, FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFunctions functions;
  final FirebaseFirestore _firestore;

  Future<List<Chart>> fetchUserCharts() async {
    // TODO: Replace with Cloud Functions or Firestore integration.
    return <Chart>[];
  }

  Future<Chart> getChart({
    required String userId,
    required String chartId,
  }) async {
    try {
      final docSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('charts')
          .doc(chartId)
          .get();

      if (!docSnapshot.exists) {
        throw Exception('Chart not found with id: $chartId');
      }

      return Chart.fromFirestore(docSnapshot.id, docSnapshot.data()!);
    } on FirebaseException catch (e) {
      throw Exception('Failed to get chart: ${e.message}');
    }
  }
}

@riverpod
ChartsRepository chartsRepository(ChartsRepositoryRef ref) {
  final functions = ref.watch(firebaseFunctionsProvider);
  return ChartsRepository(
    functions: functions,
    firestore: FirebaseFirestore.instance,
  );
}
