import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory ChartData.fromFirestore(Map<String, dynamic> data) =>
      _chartDataFromFirestore(data);
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

  factory Chart.fromFirestore(String id, Map<String, dynamic> data) {
    return Chart(
      id: id,
      name: _readString(data, const ['name', 'chartName', 'chart_name'], fallback: 'Untitled'),
      createdAt: _readDateTime(data, const ['createdAt', 'created_at', 'created_at_utc']),
      timeZone: _readNullableString(data, const ['timeZone', 'timezone', 'tz']),
      gender: _readInt(data, const ['gender', 'sex']),
    );
  }
}

ChartData _chartDataFromFirestore(Map<String, dynamic> data) {
  final chartMap = _extractChartMap(data);
  return ChartData(
    year: _pillarFromMap(chartMap['year']),
    month: _pillarFromMap(chartMap['month']),
    day: _pillarFromMap(chartMap['day']),
    hour: _pillarFromMap(chartMap['hour']),
  );
}

Map<String, dynamic> _extractChartMap(Map<String, dynamic> data) {
  final chartData = data['chartData'] ?? data['chart'] ?? data['data'];
  if (chartData is Map) {
    return Map<String, dynamic>.from(chartData);
  }
  return data;
}

PillarData _pillarFromMap(dynamic raw) {
  if (raw is Map) {
    final map = Map<String, dynamic>.from(raw);
    final heavenlyStem = _readString(
      map,
      const ['heavenlyStem', 'heavenly_stem', 'stem'],
      fallback: '-',
    );
    final earthlyBranch = _readString(
      map,
      const ['earthlyBranch', 'earthly_branch', 'branch'],
      fallback: '-',
    );
    return PillarData(
      heavenlyStem: heavenlyStem,
      earthlyBranch: earthlyBranch,
    );
  }
  return const PillarData(heavenlyStem: '-', earthlyBranch: '-');
}

String _readString(Map<String, dynamic> data, List<String> keys, {required String fallback}) {
  for (final key in keys) {
    final value = data[key];
    if (value != null && value.toString().trim().isNotEmpty) {
      return value.toString();
    }
  }
  return fallback;
}

String? _readNullableString(Map<String, dynamic> data, List<String> keys) {
  for (final key in keys) {
    final value = data[key];
    if (value != null && value.toString().trim().isNotEmpty) {
      return value.toString();
    }
  }
  return null;
}

int? _readInt(Map<String, dynamic> data, List<String> keys) {
  for (final key in keys) {
    final value = data[key];
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) {
        return parsed;
      }
    }
  }
  return null;
}

DateTime _readDateTime(Map<String, dynamic> data, List<String> keys) {
  for (final key in keys) {
    final value = data[key];
    final parsed = _parseDateTime(value);
    if (parsed != null) {
      return parsed;
    }
  }
  return DateTime.fromMillisecondsSinceEpoch(0);
}

DateTime? _parseDateTime(dynamic value) {
  if (value is DateTime) {
    return value;
  }
  if (value is Timestamp) {
    return value.toDate();
  }
  if (value is int) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }
  if (value is num) {
    return DateTime.fromMillisecondsSinceEpoch(value.toInt());
  }
  if (value is String) {
    return DateTime.tryParse(value);
  }
  return null;
}
