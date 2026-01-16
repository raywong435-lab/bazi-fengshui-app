import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_types.freezed.dart';
part 'chart_types.g.dart';

/// 八字圖表結構
@freezed
class ChartData with _$ChartData {
  const factory ChartData({
    required PillarData year,
    required PillarData month,
    required PillarData day,
    required PillarData hour,
  }) = _ChartData;

  factory ChartData.fromJson(Map<String, dynamic> json) =>
      _$ChartDataFromJson(json);
}

/// 天干地支柱
@freezed
class PillarData with _$PillarData {
  const factory PillarData({
    required String heavenlyStem,
    required String earthlyBranch,
  }) = _PillarData;

  factory PillarData.fromJson(Map<String, dynamic> json) =>
      _$PillarDataFromJson(json);
}
