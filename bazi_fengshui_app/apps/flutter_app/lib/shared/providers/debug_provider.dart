import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/report_response.dart';

// Holds the latest FunctionResponse for debug overlay to display.
final latestReportProvider = StateProvider<FunctionResponse?>((ref) => null);
