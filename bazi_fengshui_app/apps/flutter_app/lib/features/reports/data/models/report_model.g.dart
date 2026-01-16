// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OriginalChartAnalysisImpl _$$OriginalChartAnalysisImplFromJson(
        Map<String, dynamic> json) =>
    _$OriginalChartAnalysisImpl(
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$$OriginalChartAnalysisImplToJson(
        _$OriginalChartAnalysisImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };

_$KeyGodsImpl _$$KeyGodsImplFromJson(Map<String, dynamic> json) =>
    _$KeyGodsImpl(
      title: json['title'] as String,
      favorable:
          (json['favorable'] as List<dynamic>).map((e) => e as String).toList(),
      unfavorable: (json['unfavorable'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$KeyGodsImplToJson(_$KeyGodsImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'favorable': instance.favorable,
      'unfavorable': instance.unfavorable,
    };

_$AnnualFortune2026Impl _$$AnnualFortune2026ImplFromJson(
        Map<String, dynamic> json) =>
    _$AnnualFortune2026Impl(
      wealth: json['wealth'] as String,
      career: json['career'] as String,
      love: json['love'] as String,
      health: json['health'] as String,
    );

Map<String, dynamic> _$$AnnualFortune2026ImplToJson(
        _$AnnualFortune2026Impl instance) =>
    <String, dynamic>{
      'wealth': instance.wealth,
      'career': instance.career,
      'love': instance.love,
      'health': instance.health,
    };

_$FullReportImpl _$$FullReportImplFromJson(Map<String, dynamic> json) =>
    _$FullReportImpl(
      originalChartAnalysis: OriginalChartAnalysis.fromJson(
          json['originalChartAnalysis'] as Map<String, dynamic>),
      keyGods: KeyGods.fromJson(json['keyGods'] as Map<String, dynamic>),
      annualFortune2026: AnnualFortune2026.fromJson(
          json['annualFortune2026'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FullReportImplToJson(_$FullReportImpl instance) =>
    <String, dynamic>{
      'originalChartAnalysis': instance.originalChartAnalysis,
      'keyGods': instance.keyGods,
      'annualFortune2026': instance.annualFortune2026,
    };
