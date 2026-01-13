// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_form_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChartFormData {
  String get name => throw _privateConstructorUsedError;
  DateTime? get birthDate => throw _privateConstructorUsedError;
  String get birthTime => throw _privateConstructorUsedError;
  String get timeZone => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;

  /// Create a copy of ChartFormData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartFormDataCopyWith<ChartFormData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartFormDataCopyWith<$Res> {
  factory $ChartFormDataCopyWith(
          ChartFormData value, $Res Function(ChartFormData) then) =
      _$ChartFormDataCopyWithImpl<$Res, ChartFormData>;
  @useResult
  $Res call(
      {String name,
      DateTime? birthDate,
      String birthTime,
      String timeZone,
      String gender});
}

/// @nodoc
class _$ChartFormDataCopyWithImpl<$Res, $Val extends ChartFormData>
    implements $ChartFormDataCopyWith<$Res> {
  _$ChartFormDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartFormData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? birthDate = freezed,
    Object? birthTime = null,
    Object? timeZone = null,
    Object? gender = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      birthTime: null == birthTime
          ? _value.birthTime
          : birthTime // ignore: cast_nullable_to_non_nullable
              as String,
      timeZone: null == timeZone
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChartFormDataImplCopyWith<$Res>
    implements $ChartFormDataCopyWith<$Res> {
  factory _$$ChartFormDataImplCopyWith(
          _$ChartFormDataImpl value, $Res Function(_$ChartFormDataImpl) then) =
      __$$ChartFormDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      DateTime? birthDate,
      String birthTime,
      String timeZone,
      String gender});
}

/// @nodoc
class __$$ChartFormDataImplCopyWithImpl<$Res>
    extends _$ChartFormDataCopyWithImpl<$Res, _$ChartFormDataImpl>
    implements _$$ChartFormDataImplCopyWith<$Res> {
  __$$ChartFormDataImplCopyWithImpl(
      _$ChartFormDataImpl _value, $Res Function(_$ChartFormDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChartFormData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? birthDate = freezed,
    Object? birthTime = null,
    Object? timeZone = null,
    Object? gender = null,
  }) {
    return _then(_$ChartFormDataImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      birthTime: null == birthTime
          ? _value.birthTime
          : birthTime // ignore: cast_nullable_to_non_nullable
              as String,
      timeZone: null == timeZone
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChartFormDataImpl
    with DiagnosticableTreeMixin
    implements _ChartFormData {
  const _$ChartFormDataImpl(
      {this.name = '',
      this.birthDate,
      this.birthTime = '00:00',
      this.timeZone = 'Asia/Shanghai',
      this.gender = 'male'});

  @override
  @JsonKey()
  final String name;
  @override
  final DateTime? birthDate;
  @override
  @JsonKey()
  final String birthTime;
  @override
  @JsonKey()
  final String timeZone;
  @override
  @JsonKey()
  final String gender;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChartFormData(name: $name, birthDate: $birthDate, birthTime: $birthTime, timeZone: $timeZone, gender: $gender)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChartFormData'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('birthDate', birthDate))
      ..add(DiagnosticsProperty('birthTime', birthTime))
      ..add(DiagnosticsProperty('timeZone', timeZone))
      ..add(DiagnosticsProperty('gender', gender));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartFormDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.birthTime, birthTime) ||
                other.birthTime == birthTime) &&
            (identical(other.timeZone, timeZone) ||
                other.timeZone == timeZone) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, birthDate, birthTime, timeZone, gender);

  /// Create a copy of ChartFormData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartFormDataImplCopyWith<_$ChartFormDataImpl> get copyWith =>
      __$$ChartFormDataImplCopyWithImpl<_$ChartFormDataImpl>(this, _$identity);
}

abstract class _ChartFormData implements ChartFormData {
  const factory _ChartFormData(
      {final String name,
      final DateTime? birthDate,
      final String birthTime,
      final String timeZone,
      final String gender}) = _$ChartFormDataImpl;

  @override
  String get name;
  @override
  DateTime? get birthDate;
  @override
  String get birthTime;
  @override
  String get timeZone;
  @override
  String get gender;

  /// Create a copy of ChartFormData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartFormDataImplCopyWith<_$ChartFormDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
