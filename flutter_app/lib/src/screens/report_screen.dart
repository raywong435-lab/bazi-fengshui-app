import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/report_provider.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  bool _showDebug = false;

  @override
  Widget build(BuildContext context) {
    final reportState = ref.watch(reportProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Astrology Report'),
      ),
      body: reportState.when(
        data: (report) {
          if (report == null) {
            return const Center(child: Text('No report generated yet'));
          }
          return GestureDetector(
            onLongPress: () {
              setState(() {
                _showDebug = !_showDebug;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(report.content),
                    if (_showDebug) ...[
                      const SizedBox(height: 20),
                      const Text('Debug Info:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Deploy Tag: ${report.deployTag}'),
                      Text('Prompt Version: ${report.promptVersion}'),
                      Text('Source: ${report.source}'),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}