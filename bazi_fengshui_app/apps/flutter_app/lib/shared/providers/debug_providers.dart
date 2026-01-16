import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/report_response.dart';

// 使用 StateProvider，因為它的狀態可以從外部直接修改
final latestReportMetadataProvider = StateProvider<ReportMetadata?>((ref) => null);
