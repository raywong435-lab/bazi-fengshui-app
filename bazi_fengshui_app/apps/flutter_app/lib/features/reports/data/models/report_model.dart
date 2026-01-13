import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

/// Analysis of original chart (原局分析)
@freezed
class OriginalChartAnalysis with _$OriginalChartAnalysis {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory OriginalChartAnalysis({
    required String strengthAnalysis,
    required KeyGods keyGods,
    required String shenSha,
  }) = _OriginalChartAnalysis;

  factory OriginalChartAnalysis.fromJson(Map<String, dynamic> json) =>
      _$OriginalChartAnalysisFromJson(json);
}

/// Key gods (用神) analysis
@freezed
class KeyGods with _$KeyGods {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory KeyGods({
    required String fuyi,
    required String tongguan,
    required String bingyao,
    required String tiaohou,
  }) = _KeyGods;

  factory KeyGods.fromJson(Map<String, dynamic> json) =>
      _$KeyGodsFromJson(json);
}

/// Annual fortune for 2026 (流年運勢)
@freezed
class AnnualFortune2026 with _$AnnualFortune2026 {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory AnnualFortune2026({
    required String career,
    required String wealth,
    required String health,
  }) = _AnnualFortune2026;

  factory AnnualFortune2026.fromJson(Map<String, dynamic> json) =>
      _$AnnualFortune2026FromJson(json);
}

/// Full report (完整報告)
@freezed
class FullReport with _$FullReport {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory FullReport({
    required OriginalChartAnalysis originalChartAnalysis,
    required AnnualFortune2026 annualFortune2026,
  }) = _FullReport;

  factory FullReport.fromJson(Map<String, dynamic> json) =>
      _$FullReportFromJson(json);
}