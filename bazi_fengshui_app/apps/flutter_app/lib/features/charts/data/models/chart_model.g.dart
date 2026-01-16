// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PillarDataImpl _$$PillarDataImplFromJson(Map<String, dynamic> json) =>
    _$PillarDataImpl(
      heavenlyStem: json['heavenlyStem'] as String,
      earthlyBranch: json['earthlyBranch'] as String,
    );

Map<String, dynamic> _$$PillarDataImplToJson(_$PillarDataImpl instance) =>
    <String, dynamic>{
      'heavenlyStem': instance.heavenlyStem,
      'earthlyBranch': instance.earthlyBranch,
    };

_$ChartDataImpl _$$ChartDataImplFromJson(Map<String, dynamic> json) =>
    _$ChartDataImpl(
      year: PillarData.fromJson(json['year'] as Map<String, dynamic>),
      month: PillarData.fromJson(json['month'] as Map<String, dynamic>),
      day: PillarData.fromJson(json['day'] as Map<String, dynamic>),
      hour: PillarData.fromJson(json['hour'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChartDataImplToJson(_$ChartDataImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'hour': instance.hour,
    };

_$ChartRequestImpl _$$ChartRequestImplFromJson(Map<String, dynamic> json) =>
    _$ChartRequestImpl(
      chartName: json['chartName'] as String,
      birthDate: json['birthDate'] as String,
      gender: (json['gender'] as num).toInt(),
      timeZone: json['timeZone'] as String?,
    );

Map<String, dynamic> _$$ChartRequestImplToJson(_$ChartRequestImpl instance) =>
    <String, dynamic>{
      'chartName': instance.chartName,
      'birthDate': instance.birthDate,
      'gender': instance.gender,
      'timeZone': instance.timeZone,
    };

_$ChartImpl _$$ChartImplFromJson(Map<String, dynamic> json) => _$ChartImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      timeZone: json['timeZone'] as String?,
      gender: (json['gender'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ChartImplToJson(_$ChartImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'timeZone': instance.timeZone,
      'gender': instance.gender,
    };
