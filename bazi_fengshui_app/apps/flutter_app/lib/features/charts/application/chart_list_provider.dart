import 'package:riverpod_annotation/riverpod_annotation.dart';

// Import your Chart model and repository — adjust the paths to match your project structure
// import 'package:app/features/charts/domain/chart.dart';
// import 'package:app/features/charts/data/charts_repository.dart';

part 'chart_list_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Chart>> chartList(ChartListRef ref) async {
  final chartsRepository = ref.watch(chartsRepositoryProvider);
  return chartsRepository.fetchUserCharts();
}
