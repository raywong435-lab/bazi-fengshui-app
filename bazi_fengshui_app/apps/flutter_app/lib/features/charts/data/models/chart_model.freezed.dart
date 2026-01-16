// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PillarData _$PillarDataFromJson(Map<String, dynamic> json) {
  return _PillarData.fromJson(json);
}

/// @nodoc
mixin _$PillarData {
  String get heavenlyStem => throw _privateConstructorUsedError;
  String get earthlyBranch => throw _privateConstructorUsedError;

  /// Serializes this PillarData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PillarData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PillarDataCopyWith<PillarData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PillarDataCopyWith<$Res> {
  factory $PillarDataCopyWith(
          PillarData value, $Res Function(PillarData) then) =
      _$PillarDataCopyWithImpl<$Res, PillarData>;
  @useResult
  $Res call({String heavenlyStem, String earthlyBranch});
}

/// @nodoc
class _$PillarDataCopyWithImpl<$Res, $Val extends PillarData>
    implements $PillarDataCopyWith<$Res> {
  _$PillarDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PillarData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? heavenlyStem = null,
    Object? earthlyBranch = null,
  }) {
    return _then(_value.copyWith(
      heavenlyStem: null == heavenlyStem
          ? _value.heavenlyStem
          : heavenlyStem // ignore: cast_nullable_to_non_nullable
              as String,
      earthlyBranch: null == earthlyBranch
          ? _value.earthlyBranch
          : earthlyBranch // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PillarDataImplCopyWith<$Res>
    implements $PillarDataCopyWith<$Res> {
  factory _$$PillarDataImplCopyWith(
          _$PillarDataImpl value, $Res Function(_$PillarDataImpl) then) =
      __$$PillarDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String heavenlyStem, String earthlyBranch});
}

/// @nodoc
class __$$PillarDataImplCopyWithImpl<$Res>
    extends _$PillarDataCopyWithImpl<$Res, _$PillarDataImpl>
    implements _$$PillarDataImplCopyWith<$Res> {
  __$$PillarDataImplCopyWithImpl(
      _$PillarDataImpl _value, $Res Function(_$PillarDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of PillarData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? heavenlyStem = null,
    Object? earthlyBranch = null,
  }) {
    return _then(_$PillarDataImpl(
      heavenlyStem: null == heavenlyStem
          ? _value.heavenlyStem
          : heavenlyStem // ignore: cast_nullable_to_non_nullable
              as String,
      earthlyBranch: null == earthlyBranch
          ? _value.earthlyBranch
          : earthlyBranch // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PillarDataImpl implements _PillarData {
  const _$PillarDataImpl(
      {required this.heavenlyStem, required this.earthlyBranch});

  factory _$PillarDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PillarDataImplFromJson(json);

  @override
  final String heavenlyStem;
  @override
  final String earthlyBranch;

  @override
  String toString() {
    return 'PillarData(heavenlyStem: $heavenlyStem, earthlyBranch: $earthlyBranch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PillarDataImpl &&
            (identical(other.heavenlyStem, heavenlyStem) ||
                other.heavenlyStem == heavenlyStem) &&
            (identical(other.earthlyBranch, earthlyBranch) ||
                other.earthlyBranch == earthlyBranch));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, heavenlyStem, earthlyBranch);

  /// Create a copy of PillarData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PillarDataImplCopyWith<_$PillarDataImpl> get copyWith =>
      __$$PillarDataImplCopyWithImpl<_$PillarDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PillarDataImplToJson(
      this,
    );
  }
}

abstract class _PillarData implements PillarData {
  const factory _PillarData(
      {required final String heavenlyStem,
      required final String earthlyBranch}) = _$PillarDataImpl;

  factory _PillarData.fromJson(Map<String, dynamic> json) =
      _$PillarDataImpl.fromJson;

  @override
  String get heavenlyStem;
  @override
  String get earthlyBranch;

  /// Create a copy of PillarData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PillarDataImplCopyWith<_$PillarDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChartData _$ChartDataFromJson(Map<String, dynamic> json) {
  return _ChartData.fromJson(json);
}

/// @nodoc
mixin _$ChartData {
  PillarData get year => throw _privateConstructorUsedError;
  PillarData get month => throw _privateConstructorUsedError;
  PillarData get day => throw _privateConstructorUsedError;
  PillarData get hour => throw _privateConstructorUsedError;

  /// Serializes this ChartData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChartData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartDataCopyWith<ChartData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartDataCopyWith<$Res> {
  factory $ChartDataCopyWith(ChartData value, $Res Function(ChartData) then) =
      _$ChartDataCopyWithImpl<$Res, ChartData>;
  @useResult
  $Res call(
      {PillarData year, PillarData month, PillarData day, PillarData hour});

  $PillarDataCopyWith<$Res> get year;
  $PillarDataCopyWith<$Res> get month;
  $PillarDataCopyWith<$Res> get day;
  $PillarDataCopyWith<$Res> get hour;
}

/// @nodoc
class _$ChartDataCopyWithImpl<$Res, $Val extends ChartData>
    implements $ChartDataCopyWith<$Res> {
  _$ChartDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? day = null,
    Object? hour = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as PillarData,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as PillarData,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as PillarData,
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as PillarData,
    ) as $Val);
  }

  /// Create a copy of ChartData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PillarDataCopyWith<$Res> get year {
    return $PillarDataCopyWith<$Res>(_value.year, (value) {
      return _then(_value.copyWith(year: value) as $Val);
    });
  }

  /// Create a copy of ChartData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PillarDataCopyWith<$Res> get month {
    return $PillarDataCopyWith<$Res>(_value.month, (value) {
      return _then(_value.copyWith(month: value) as $Val);
    });
  }

  /// Create a copy of ChartData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PillarDataCopyWith<$Res> get day {
    return $PillarDataCopyWith<$Res>(_value.day, (value) {
      return _then(_value.copyWith(day: value) as $Val);
    });
  }

  /// Create a copy of ChartData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PillarDataCopyWith<$Res> get hour {
    return $PillarDataCopyWith<$Res>(_value.hour, (value) {
      return _then(_value.copyWith(hour: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChartDataImplCopyWith<$Res>
    implements $ChartDataCopyWith<$Res> {
  factory _$$ChartDataImplCopyWith(
          _$ChartDataImpl value, $Res Function(_$ChartDataImpl) then) =
      __$$ChartDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PillarData year, PillarData month, PillarData day, PillarData hour});

  @override
  $PillarDataCopyWith<$Res> get year;
  @override
  $PillarDataCopyWith<$Res> get month;
  @override
  $PillarDataCopyWith<$Res> get day;
  @override
  $PillarDataCopyWith<$Res> get hour;
}

/// @nodoc
class __$$ChartDataImplCopyWithImpl<$Res>
    extends _$ChartDataCopyWithImpl<$Res, _$ChartDataImpl>
    implements _$$ChartDataImplCopyWith<$Res> {
  __$$ChartDataImplCopyWithImpl(
      _$ChartDataImpl _value, $Res Function(_$ChartDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChartData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? day = null,
    Object? hour = null,
  }) {
    return _then(_$ChartDataImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as PillarData,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as PillarData,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as PillarData,
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as PillarData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChartDataImpl implements _ChartData {
  const _$ChartDataImpl(
      {required this.year,
      required this.month,
      required this.day,
      required this.hour});

  factory _$ChartDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChartDataImplFromJson(json);

  @override
  final PillarData year;
  @override
  final PillarData month;
  @override
  final PillarData day;
  @override
  final PillarData hour;

  @override
  String toString() {
    return 'ChartData(year: $year, month: $month, day: $day, hour: $hour)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartDataImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.hour, hour) || other.hour == hour));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, year, month, day, hour);

  /// Create a copy of ChartData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartDataImplCopyWith<_$ChartDataImpl> get copyWith =>
      __$$ChartDataImplCopyWithImpl<_$ChartDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChartDataImplToJson(
      this,
    );
  }
}

abstract class _ChartData implements ChartData {
  const factory _ChartData(
      {required final PillarData year,
      required final PillarData month,
      required final PillarData day,
      required final PillarData hour}) = _$ChartDataImpl;

  factory _ChartData.fromJson(Map<String, dynamic> json) =
      _$ChartDataImpl.fromJson;

  @override
  PillarData get year;
  @override
  PillarData get month;
  @override
  PillarData get day;
  @override
  PillarData get hour;

  /// Create a copy of ChartData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartDataImplCopyWith<_$ChartDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChartRequest _$ChartRequestFromJson(Map<String, dynamic> json) {
  return _ChartRequest.fromJson(json);
}

/// @nodoc
mixin _$ChartRequest {
  String get chartName => throw _privateConstructorUsedError;
  String get birthDate =>
      throw _privateConstructorUsedError; // ISO 8601 datetime string
  int get gender => throw _privateConstructorUsedError; // 1 = male, 2 = female
  String? get timeZone => throw _privateConstructorUsedError;

  /// Serializes this ChartRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChartRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartRequestCopyWith<ChartRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartRequestCopyWith<$Res> {
  factory $ChartRequestCopyWith(
          ChartRequest value, $Res Function(ChartRequest) then) =
      _$ChartRequestCopyWithImpl<$Res, ChartRequest>;
  @useResult
  $Res call({String chartName, String birthDate, int gender, String? timeZone});
}

/// @nodoc
class _$ChartRequestCopyWithImpl<$Res, $Val extends ChartRequest>
    implements $ChartRequestCopyWith<$Res> {
  _$ChartRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chartName = null,
    Object? birthDate = null,
    Object? gender = null,
    Object? timeZone = freezed,
  }) {
    return _then(_value.copyWith(
      chartName: null == chartName
          ? _value.chartName
          : chartName // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int,
      timeZone: freezed == timeZone
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChartRequestImplCopyWith<$Res>
    implements $ChartRequestCopyWith<$Res> {
  factory _$$ChartRequestImplCopyWith(
          _$ChartRequestImpl value, $Res Function(_$ChartRequestImpl) then) =
      __$$ChartRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String chartName, String birthDate, int gender, String? timeZone});
}

/// @nodoc
class __$$ChartRequestImplCopyWithImpl<$Res>
    extends _$ChartRequestCopyWithImpl<$Res, _$ChartRequestImpl>
    implements _$$ChartRequestImplCopyWith<$Res> {
  __$$ChartRequestImplCopyWithImpl(
      _$ChartRequestImpl _value, $Res Function(_$ChartRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChartRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chartName = null,
    Object? birthDate = null,
    Object? gender = null,
    Object? timeZone = freezed,
  }) {
    return _then(_$ChartRequestImpl(
      chartName: null == chartName
          ? _value.chartName
          : chartName // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int,
      timeZone: freezed == timeZone
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChartRequestImpl implements _ChartRequest {
  const _$ChartRequestImpl(
      {required this.chartName,
      required this.birthDate,
      required this.gender,
      this.timeZone});

  factory _$ChartRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChartRequestImplFromJson(json);

  @override
  final String chartName;
  @override
  final String birthDate;
// ISO 8601 datetime string
  @override
  final int gender;
// 1 = male, 2 = female
  @override
  final String? timeZone;

  @override
  String toString() {
    return 'ChartRequest(chartName: $chartName, birthDate: $birthDate, gender: $gender, timeZone: $timeZone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartRequestImpl &&
            (identical(other.chartName, chartName) ||
                other.chartName == chartName) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.timeZone, timeZone) ||
                other.timeZone == timeZone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, chartName, birthDate, gender, timeZone);

  /// Create a copy of ChartRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartRequestImplCopyWith<_$ChartRequestImpl> get copyWith =>
      __$$ChartRequestImplCopyWithImpl<_$ChartRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChartRequestImplToJson(
      this,
    );
  }
}

abstract class _ChartRequest implements ChartRequest {
  const factory _ChartRequest(
      {required final String chartName,
      required final String birthDate,
      required final int gender,
      final String? timeZone}) = _$ChartRequestImpl;

  factory _ChartRequest.fromJson(Map<String, dynamic> json) =
      _$ChartRequestImpl.fromJson;

  @override
  String get chartName;
  @override
  String get birthDate; // ISO 8601 datetime string
  @override
  int get gender; // 1 = male, 2 = female
  @override
  String? get timeZone;

  /// Create a copy of ChartRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartRequestImplCopyWith<_$ChartRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Chart _$ChartFromJson(Map<String, dynamic> json) {
  return _Chart.fromJson(json);
}

/// @nodoc
mixin _$Chart {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get timeZone => throw _privateConstructorUsedError;
  int? get gender => throw _privateConstructorUsedError;

  /// Serializes this Chart to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Chart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartCopyWith<Chart> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartCopyWith<$Res> {
  factory $ChartCopyWith(Chart value, $Res Function(Chart) then) =
      _$ChartCopyWithImpl<$Res, Chart>;
  @useResult
  $Res call(
      {String id,
      String name,
      DateTime createdAt,
      String? timeZone,
      int? gender});
}

/// @nodoc
class _$ChartCopyWithImpl<$Res, $Val extends Chart>
    implements $ChartCopyWith<$Res> {
  _$ChartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Chart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? timeZone = freezed,
    Object? gender = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeZone: freezed == timeZone
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChartImplCopyWith<$Res> implements $ChartCopyWith<$Res> {
  factory _$$ChartImplCopyWith(
          _$ChartImpl value, $Res Function(_$ChartImpl) then) =
      __$$ChartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      DateTime createdAt,
      String? timeZone,
      int? gender});
}

/// @nodoc
class __$$ChartImplCopyWithImpl<$Res>
    extends _$ChartCopyWithImpl<$Res, _$ChartImpl>
    implements _$$ChartImplCopyWith<$Res> {
  __$$ChartImplCopyWithImpl(
      _$ChartImpl _value, $Res Function(_$ChartImpl) _then)
      : super(_value, _then);

  /// Create a copy of Chart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? timeZone = freezed,
    Object? gender = freezed,
  }) {
    return _then(_$ChartImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeZone: freezed == timeZone
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChartImpl implements _Chart {
  const _$ChartImpl(
      {required this.id,
      required this.name,
      required this.createdAt,
      this.timeZone,
      this.gender});

  factory _$ChartImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChartImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final DateTime createdAt;
  @override
  final String? timeZone;
  @override
  final int? gender;

  @override
  String toString() {
    return 'Chart(id: $id, name: $name, createdAt: $createdAt, timeZone: $timeZone, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.timeZone, timeZone) ||
                other.timeZone == timeZone) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, createdAt, timeZone, gender);

  /// Create a copy of Chart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartImplCopyWith<_$ChartImpl> get copyWith =>
      __$$ChartImplCopyWithImpl<_$ChartImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChartImplToJson(
      this,
    );
  }
}

abstract class _Chart implements Chart {
  const factory _Chart(
      {required final String id,
      required final String name,
      required final DateTime createdAt,
      final String? timeZone,
      final int? gender}) = _$ChartImpl;

  factory _Chart.fromJson(Map<String, dynamic> json) = _$ChartImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  DateTime get createdAt;
  @override
  String? get timeZone;
  @override
  int? get gender;

  /// Create a copy of Chart
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartImplCopyWith<_$ChartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
