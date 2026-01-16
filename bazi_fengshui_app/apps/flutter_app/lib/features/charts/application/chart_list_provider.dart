import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/charts_repository.dart';
import '../data/models/chart_model.dart';

part 'chart_list_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Chart>> chartList(ChartListRef ref) async {
  final chartsRepository = ref.watch(chartsRepositoryProvider);
  return chartsRepository.fetchUserCharts();
}
