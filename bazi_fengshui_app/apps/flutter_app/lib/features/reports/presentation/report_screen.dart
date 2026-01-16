import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bazi_fengshui_app/features/charts/data/models/chart_model.dart';
import 'package:bazi_fengshui_app/features/reports/data/models/report_model.dart';
import 'package:bazi_fengshui_app/features/reports/application/report_provider.dart';

// Define the color palette from the design
class AppColors {
  static const Color primaryBackground = Color(0xFFFAFAF8);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color primaryText = Color(0xFF2C2C2C);
  static const Color secondaryText = Color(0xFF4A4A4A);
  static const Color tertiaryText = Color(0xFF8A8A8A);
  static const Color accentJade = Color(0xFF7C9885);
  static const Color accentCinnabar = Color(0xFFC85A54);
  static const Color divider = Color(0xFFE0DDD8);
  static const Color favorableChipBg = Color(0xFFE8F5E9);
  static const Color favorableChipText = Color(0xFF2E7D32);
  static const Color unfavorableChipBg = Color(0xFFFFEBEE);
  static const Color unfavorableChipText = Color(0xFFC62828);
  static const Color goldAccent = Color(0xFFD4AF37);
  static const Color blueAccent = Color(0xFF5B7C99);
  static const Color roseAccent = Color(0xFFD4808D);
}

// Main Screen Widget
class ReportScreen extends ConsumerWidget {
  final String chartId;
  const ReportScreen({super.key, required this.chartId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(reportScreenDataProvider(chartId: chartId));

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '命理分析報告',
          style: GoogleFonts.notoSerifSc(
            color: AppColors.primaryText,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.secondaryText),
            onPressed: () { /* TODO: Implement share */ },
          ),
        ],
      ),
      body: reportAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.accentJade)),
        error: (err, stack) => Center(child: Text('加載報告失敗: $err', style: GoogleFonts.notoSansSc())),
        data: (data) => _ReportView(report: data.report, chart: data.chart),
      ),
    );
  }
}

// Main Scrollable View
class _ReportView extends StatelessWidget {
  final FullReport report;
  final ChartData chart;

  const _ReportView({required this.report, required this.chart});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          _BaziChartCard(chart: chart),
          const SizedBox(height: 20),
          _OriginalAnalysisCard(analysis: report.originalChartAnalysis),
          const SizedBox(height: 20),
          _KeyGodsCard(keyGods: report.keyGods),
          const SizedBox(height: 20),
          _AnnualFortuneCard(fortune: report.annualFortune2026),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// Card Widgets based on Claude's design

class _BaziChartCard extends StatelessWidget {
  final ChartData chart;
  const _BaziChartCard({required this.chart});

  @override
  Widget build(BuildContext context) {
    final pillars = [chart.year, chart.month, chart.day, chart.hour];
    final pillarNames = ['年柱', '月柱', '日柱', '時柱'];

    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.divider, width: 0.5),
      ),
      color: AppColors.cardBackground,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
            child: Row(
              children: [
                const Icon(Icons.apps_outlined, color: AppColors.accentJade, size: 20),
                const SizedBox(width: 8),
                Text(
                  '四柱八字',
                  style: GoogleFonts.notoSerifSc(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: AppColors.divider, height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                return Column(
                  children: [
                    Text(
                      pillarNames[index],
                      style: GoogleFonts.notoSansSc(fontSize: 12, color: AppColors.tertiaryText),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pillars[index].heavenlyStem,
                      style: GoogleFonts.notoSerifSc(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                    ),
                    Text(
                      pillars[index].earthlyBranch,
                      style: GoogleFonts.notoSerifSc(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _OriginalAnalysisCard extends StatelessWidget {
  final OriginalChartAnalysis analysis;
  const _OriginalAnalysisCard({required this.analysis});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              analysis.title,
              style: GoogleFonts.notoSerifSc(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 12),
            const Divider(color: AppColors.divider, height: 1),
            const SizedBox(height: 12),
            Text(
              analysis.content,
              style: GoogleFonts.notoSansSc(
                fontSize: 15,
                color: AppColors.secondaryText,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyGodsCard extends StatelessWidget {
  final KeyGods keyGods;
  const _KeyGodsCard({required this.keyGods});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              keyGods.title,
              style: GoogleFonts.notoSerifSc(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.primaryText),
            ),
            const SizedBox(height: 4),
            Text(
              '影響命運的核心元素',
              style: GoogleFonts.notoSansSc(fontSize: 12, color: AppColors.tertiaryText),
            ),
            const SizedBox(height: 16),
            const Divider(color: AppColors.divider, height: 1),
            const SizedBox(height: 16),
            _buildGodsSection('喜用神', keyGods.favorable, AppColors.accentJade, AppColors.favorableChipBg, AppColors.favorableChipText),
            const SizedBox(height: 20),
            _buildGodsSection('忌用神', keyGods.unfavorable, AppColors.accentCinnabar, AppColors.unfavorableChipBg, AppColors.unfavorableChipText),
          ],
        ),
      ),
    );
  }
  
  Widget _buildGodsSection(String title, List<String> elements, Color accentColor, Color chipBg, Color chipText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.notoSansSc(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primaryText),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: elements.map((element) {
                  return Chip(
                    label: Text(
                      element,
                      style: GoogleFonts.notoSansSc(fontSize: 14, fontWeight: FontWeight.w500, color: chipText),
                    ),
                    backgroundColor: chipBg,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide.none,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnnualFortuneCard extends StatelessWidget {
  final AnnualFortune2026 fortune;
  const _AnnualFortuneCard({required this.fortune});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.cardBackground,
      child: Column(
        children: [
          Padding(
             padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Text(
                  '2026 流年運勢',
                   style: GoogleFonts.notoSerifSc(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.primaryText),
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.divider, height: 1),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: Column(
              children: [
                _FortuneExpansionTile(icon: Icons.account_balance_wallet_outlined, title: '財運', content: fortune.wealth, color: AppColors.goldAccent),
                _FortuneExpansionTile(icon: Icons.work_outline, title: '事業', content: fortune.career, color: AppColors.blueAccent),
                _FortuneExpansionTile(icon: Icons.favorite_border, title: '愛情', content: fortune.love, color: AppColors.roseAccent),
                _FortuneExpansionTile(icon: Icons.spa_outlined, title: '健康', content: fortune.health, color: AppColors.accentJade),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FortuneExpansionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final Color color;

  const _FortuneExpansionTile({
    required this.icon,
    required this.title,
    required this.content,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: GoogleFonts.notoSansSc(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
      childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      expandedAlignment: Alignment.topLeft,
      children: [
        Text(
          content,
          style: GoogleFonts.notoSansSc(
            fontSize: 15,
            color: AppColors.secondaryText,
            height: 1.7,
          ),
        )
      ],
    );
  }
}
