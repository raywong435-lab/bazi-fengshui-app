import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_providers.g.dart';

@riverpod
FirebaseFunctions firebaseFunctions(FirebaseFunctionsRef ref) {
  // Configure region per environment if needed
  return FirebaseFunctions.instanceFor(region: 'asia-east1');
}
