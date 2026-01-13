import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_model.freezed.dart';
part 'chart_model.g.dart';

/// Pillar data containing Heavenly Stem and Earthly Branch
@freezed
class PillarData with _$PillarData {
  @JsonSerializable(fieldRename: FieldRename.none)
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
  @JsonSerializable(fieldRename: FieldRename.none)
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
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory ChartRequest({
    required String chartName,
    required String birthDate, // ISO 8601 datetime string
    required int gender, // 1 = male, 2 = female
    String? timeZone,
  }) = _ChartRequest;

  factory ChartRequest.fromJson(Map<String, dynamic> json) =>
      _$ChartRequestFromJson(json);
}