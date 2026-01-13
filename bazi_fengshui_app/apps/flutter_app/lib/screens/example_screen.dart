import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../core/services/api_client.dart';
import '../features/charts/data/models/chart_model.dart';
import '../features/auth/data/auth_repository.dart';

/// Example usage of ApiClient and AuthRepository
class BaziExampleScreen extends StatefulWidget {
  const BaziExampleScreen({super.key});

  @override
  State<BaziExampleScreen> createState() => _BaziExampleScreenState();
}

class _BaziExampleScreenState extends State<BaziExampleScreen> {
  final _apiClient = ApiClient();
  final _authRepo = AuthRepository();
  String _output = '準備開始...';
  bool _loading = false;

  Future<void> _testFullFlow() async {
    setState(() {
      _loading = true;
      _output = '開始測試流程...\n';
    });

    try {
      // Step 1: Sign in anonymously for testing (optional)
      _addOutput('步驟 1: 認證中...');
      if (_authRepo.currentUser == null) {
        _addOutput('使用匿名登入進行測試');
        // In production, use: await _authRepo.signIn(email: '...', password: '...');
      }

      // Step 2: Create chart
      _addOutput('\n步驟 2: 建立八字命盤...');
      final chartRequest = ChartRequest(
        chartName: 'Ray 測試',
        birthDate: '2000-01-15T14:30:00+08:00',
        gender: 1, // 1 = male, 2 = female
        timeZone: 'Asia/Taipei',
      );

      final chartData = await _apiClient.createChart(chartRequest);
      _addOutput('✅ 命盤建立成功！');
      _addOutput('年柱: ${chartData.year.heavenlyStem}${chartData.year.earthlyBranch}');
      _addOutput('月柱: ${chartData.month.heavenlyStem}${chartData.month.earthlyBranch}');
      _addOutput('日柱: ${chartData.day.heavenlyStem}${chartData.day.earthlyBranch}');
      _addOutput('時柱: ${chartData.hour.heavenlyStem}${chartData.hour.earthlyBranch}');

      // Step 3: Generate report (requires chart to be saved with an ID)
      // _addOutput('\n步驟 3: 生成分析報告...');
      // final report = await _apiClient.generateReport(chartId);
      // _addOutput('✅ 報告生成成功！');

      _addOutput('\n✅ 測試完成！');
    } on FirebaseFunctionsException catch (e) {
      _addOutput('\n❌ Functions 錯誤: ${e.code} - ${e.message}');
    } catch (e) {
      _addOutput('\n❌ 錯誤: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  void _addOutput(String text) {
    setState(() {
      _output += '$text\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('八字 API 測試')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _loading ? null : _testFullFlow,
              child: _loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('測試完整流程'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _output,
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
