import 'package:cloud_functions/cloud_functions.dart';
import '../models/birth_info.dart';

class FirebaseService {
  static final functions = FirebaseFunctions.instance;

  static Future<Map<String, dynamic>> generateReport(BirthInfo birthInfo) async {
    final callable = functions.httpsCallable('generateReport');
    final result = await callable.call(birthInfo.toJson());
    return result.data as Map<String, dynamic>;
  }
}