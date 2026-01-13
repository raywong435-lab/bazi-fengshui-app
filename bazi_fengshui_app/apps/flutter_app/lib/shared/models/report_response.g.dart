// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportMetadataImpl _$$ReportMetadataImplFromJson(Map<String, dynamic> json) =>
    _$ReportMetadataImpl(
      source: json['source'] as String,
      promptVersion: json['promptVersion'] as String,
      deployTag: json['deployTag'] as String,
      cacheTimestamp: json['cacheTimestamp'] == null
          ? null
          : DateTime.parse(json['cacheTimestamp'] as String),
    );

Map<String, dynamic> _$$ReportMetadataImplToJson(
        _$ReportMetadataImpl instance) =>
    <String, dynamic>{
      'source': instance.source,
      'promptVersion': instance.promptVersion,
      'deployTag': instance.deployTag,
      'cacheTimestamp': instance.cacheTimestamp?.toIso8601String(),
    };

_$FunctionResponseImpl _$$FunctionResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$FunctionResponseImpl(
      report: const ReportDataJsonConverter()
          .fromJson(json['report'] as Map<String, dynamic>),
      metadata:
          ReportMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FunctionResponseImplToJson(
        _$FunctionResponseImpl instance) =>
    <String, dynamic>{
      'report': const ReportDataJsonConverter().toJson(instance.report),
      'metadata': instance.metadata,
    };
