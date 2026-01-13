import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../../application/report_provider.dart';
import '../../../shared/models/report_response.dart';

class ReportPage extends ConsumerWidget {
  final String chartId;
  final String reportType;

  const ReportPage({super.key, required this.chartId, required this.reportType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 使用 .family 傳遞參數
    final reportState = ref.watch(reportNotifierProvider(reportType, chartId));

    return Scaffold(
      appBar: AppBar(title: const Text('AI 分析報告')),
      body: reportState.when(
        data: (response) {
          // 使用 map 來取得具體 variant 物件以傳入對應的 View
          return response.report.map(
            career: (career) => CareerReportView(data: career),
            wealth: (wealth) => WealthReportView(data: wealth),
            health: (health) => HealthReportView(data: health),
            relationship: (rel) => RelationshipReportView(data: rel),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) {
          // 處理來自後端的特定錯誤，例如配額用盡
          if (err is FirebaseFunctionsException && err.code == 'resource-exhausted') {
            return Center(child: Text('錯誤：${err.message}'));
          }
          return Center(child: Text('載入報告失敗: $err'));
        },
      ),
    );
  }
}

// --- 專門用於渲染事業報告的 Widget ---
class CareerReportView extends StatelessWidget {
  final CareerReport data;
  const CareerReportView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Text(data.title, style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 8),
          Text(data.summary['overall_potential'] ?? '', style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 12),
          Text('Career Path Suggestions', style: Theme.of(context).textTheme.subtitle1),
          ...data.careerPathSuggestions.map((p) => ListTile(
                title: Text(p['path_name'] ?? ''),
                subtitle: Text(p['reason'] ?? ''),
                trailing: Text((p['suitability_score'] ?? '').toString()),
              )),
        ],
      ),
    );
  }
}

class WealthReportView extends StatelessWidget {
  final WealthReport data;
  const WealthReportView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.title, style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 8),
          Text('5-Year Projection: ${data.fiveYearProjection}', style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 12),
          Text('Investment Suggestions', style: Theme.of(context).textTheme.subtitle1),
          ...data.investmentSuggestions.map((s) => ListTile(title: Text(s))),
        ],
      ),
    );
  }
}

class HealthReportView extends StatelessWidget {
  final HealthReport data;
  const HealthReportView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.title, style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 8),
          Text(data.healthSummary),
        ],
      ),
    );
  }
}

class RelationshipReportView extends StatelessWidget {
  final RelationshipReport data;
  const RelationshipReportView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.title, style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 8),
          Text(data.relationshipAdvice),
        ],
      ),
    );
  }
}
