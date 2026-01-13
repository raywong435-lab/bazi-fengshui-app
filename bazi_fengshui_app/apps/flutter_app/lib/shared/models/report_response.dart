import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_response.freezed.dart';
part 'report_response.g.dart';

// === Freezed Union Type for different report structures ===
@freezed
class ReportData with _$ReportData {
  const factory ReportData.career({
    required String title,
    required Map<String, dynamic> summary,
    required List<Map<String, dynamic>> careerPathSuggestions,
  }) = CareerReport;

  const factory ReportData.wealth({
    required String title,
    required double fiveYearProjection,
    required List<String> investmentSuggestions,
  }) = WealthReport;

  const factory ReportData.health({
    required String title,
    required String healthSummary,
  }) = HealthReport;

  const factory ReportData.relationship({
    required String title,
    required String relationshipAdvice,
  }) = RelationshipReport;
}

// JSON converter to serialize/deserialize `ReportData` without requiring
// Freezed/json_serializable to generate union JSON for every variant.
class ReportDataJsonConverter implements JsonConverter<ReportData, Map<String, dynamic>> {
  const ReportDataJsonConverter();

  @override
  ReportData fromJson(Map<String, dynamic> json) {
    final type = json['reportType'] as String?;
    switch (type) {
      case 'career':
        return ReportData.career(
          title: json['title'] as String,
          summary: Map<String, dynamic>.from(json['summary'] as Map),
          careerPathSuggestions: (json['career_path_suggestions'] as List?)
                  ?.map((e) => Map<String, dynamic>.from(e as Map))
                  .toList() ??
              [],
        );
      case 'wealth':
        return ReportData.wealth(
          title: json['title'] as String,
          fiveYearProjection: (json['five_year_projection'] as num).toDouble(),
          investmentSuggestions: (json['investment_suggestions'] as List?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
        );
      case 'health':
        return ReportData.health(
          title: json['title'] as String,
          healthSummary: json['health_summary'] as String,
        );
      case 'relationship':
        return ReportData.relationship(
          title: json['title'] as String,
          relationshipAdvice: json['relationship_advice'] as String,
        );
      default:
        throw Exception('Unknown reportType: $type');
    }
  }

  @override
  Map<String, dynamic> toJson(ReportData object) => object.map(
        career: (c) => {
          'reportType': 'career',
          'title': c.title,
          'summary': c.summary,
          'career_path_suggestions': c.careerPathSuggestions,
        },
        wealth: (w) => {
          'reportType': 'wealth',
          'title': w.title,
          'five_year_projection': w.fiveYearProjection,
          'investment_suggestions': w.investmentSuggestions,
        },
        health: (h) => {
          'reportType': 'health',
          'title': h.title,
          'health_summary': h.healthSummary,
        },
        relationship: (r) => {
          'reportType': 'relationship',
          'title': r.title,
          'relationship_advice': r.relationshipAdvice,
        },
      );
}

// === 元數據與完整回應模型 ===
@freezed
class ReportMetadata with _$ReportMetadata {
  const factory ReportMetadata({
    required String source,
    required String promptVersion,
    required String deployTag,
    DateTime? cacheTimestamp,
  }) = _ReportMetadata;

  factory ReportMetadata.fromJson(Map<String, dynamic> json) =>
      _$ReportMetadataFromJson(json);
}

@freezed
class FunctionResponse with _$FunctionResponse {
  const factory FunctionResponse({
    @ReportDataJsonConverter() required ReportData report,
    required ReportMetadata metadata,
  }) = _FunctionResponse;

  factory FunctionResponse.fromJson(Map<String, dynamic> json) =>
      _$FunctionResponseFromJson(json);
}
