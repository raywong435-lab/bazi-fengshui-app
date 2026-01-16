import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../application/chart_list_provider.dart';
import '../data/models/chart_model.dart';

final userChartsProvider = chartListProvider;

class ChartListPage extends ConsumerWidget {
  const ChartListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartsAsync = ref.watch(userChartsProvider);

    return Scaffold(
      backgroundColor: _ricePaper,
      appBar: AppBar(
        title: Text(
          '我的命盤',
          style: GoogleFonts.notoSerifSc(
            color: _inkBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: _jadeGreen.withOpacity(0.1),
          ),
        ),
      ),
      body: chartsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: _jadeGreen),
        ),
        error: (error, _) => Center(
          child: Text(
            error.toString(),
            style: GoogleFonts.notoSansSc(color: _inkBlack),
          ),
        ),
        data: (charts) {
          if (charts.isEmpty) {
            return const _EmptyStateView();
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 88),
            itemCount: charts.length,
            itemBuilder: (context, index) {
              final chart = charts[index];
              return _ChartListItem(
                chart: chart,
                onTap: () => context.go('/report?chartId=${chart.id}'),
                onDelete: () {},
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: '創建新命盤',
        backgroundColor: _jadeGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _EmptyStateView extends StatelessWidget {
  const _EmptyStateView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.library_books_outlined,
            size: 100,
            color: _bambooGreen.withOpacity(0.3),
          ),
          const SizedBox(height: 24),
          Text(
            '您還沒有任何命盤',
            style: GoogleFonts.notoSerifSc(fontSize: 20, color: _inkBlack),
          ),
          const SizedBox(height: 12),
          Text(
            '開始創建您的第一個八字命盤...',
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansSc(fontSize: 14, color: _inkBlack),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _jadeGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
            ),
            child: Text(
              '創建命盤',
              style: GoogleFonts.notoSansSc(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartListItem extends StatelessWidget {
  final Chart chart;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _ChartListItem({
    required this.chart,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final birthDateText =
        DateFormat('yyyy年M月d日 HH:mm', 'zh_CN').format(chart.birthDate);
    final createdAtText =
        DateFormat('yyyy-MM-dd', 'zh_CN').format(chart.createdAt);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      color: _cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chart.name,
                      style: GoogleFonts.notoSerifSc(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _inkBlack,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: _jadeGreen,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          birthDateText,
                          style: GoogleFonts.notoSansSc(
                            fontSize: 13,
                            color: _inkBlack,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '創建於 $createdAtText',
                      style: GoogleFonts.notoSansSc(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: _inkBlack.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _jadeGreen.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        chart.gender,
                        style: GoogleFonts.notoSansSc(
                          fontSize: 12,
                          color: _jadeGreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    IconButton(
                      onPressed: () => _showDeleteConfirmation(
                        context,
                        chart.name,
                      ),
                      icon: const Icon(Icons.delete_outline),
                      color: _cinnabarRed.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String name) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            '確認刪除',
            style: GoogleFonts.notoSerifSc(fontWeight: FontWeight.w600),
          ),
          content: Text(
            '確定要刪除「$name」的命盤嗎？此操作無法復原。',
            style: GoogleFonts.notoSansSc(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                '取消',
                style: GoogleFonts.notoSansSc(color: _inkBlack),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onDelete();
              },
              child: Text(
                '刪除',
                style: GoogleFonts.notoSansSc(color: _cinnabarRed),
              ),
            ),
          ],
        );
      },
    );
  }
}

const _ricePaper = Color(0xFFFAFAF8);
const _inkBlack = Color(0xFF1A1A1A);
const _jadeGreen = Color(0xFF2D5F4F);
const _bambooGreen = Color(0xFF6B8E6F);
const _cardColor = Color(0xFFFFFBF5);
const _cinnabarRed = Color(0xFFB5483A);
