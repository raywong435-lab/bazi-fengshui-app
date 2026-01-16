import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_model.freezed.dart';
part 'chart_model.g.dart';

/// Pillar data containing Heavenly Stem and Earthly Branch
@freezed
class PillarData with _$PillarData {
  const factory PillarData({
    required String heavenlyStem,
    required String earthlyBranch,
  }) = _PillarData;

  factory PillarData.fromJson(Map<String, dynamic> json) =>
      _$PillarDataFromJson(json);
}

/// Complete chart data with Four Pillars (年月日時)
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

/// Chart creation request
@freezed
class ChartRequest with _$ChartRequest {
  const factory ChartRequest({
    required String chartName,
    required String birthDate, // ISO 8601 datetime string
    required int gender, // 1 = male, 2 = female
    String? timeZone,
  }) = _ChartRequest;

  factory ChartRequest.fromJson(Map<String, dynamic> json) =>
      _$ChartRequestFromJson(json);
}

/// Lightweight chart summary for list views
@freezed
class Chart with _$Chart {
  const factory Chart({
    required String id,
    required String name,
    required DateTime createdAt,
    String? timeZone,
    int? gender,
  }) = _Chart;

  factory Chart.fromJson(Map<String, dynamic> json) => _$ChartFromJson(json);
}
