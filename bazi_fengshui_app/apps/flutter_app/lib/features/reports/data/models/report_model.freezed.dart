// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OriginalChartAnalysis _$OriginalChartAnalysisFromJson(
    Map<String, dynamic> json) {
  return _OriginalChartAnalysis.fromJson(json);
}

/// @nodoc
mixin _$OriginalChartAnalysis {
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  /// Serializes this OriginalChartAnalysis to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OriginalChartAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OriginalChartAnalysisCopyWith<OriginalChartAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OriginalChartAnalysisCopyWith<$Res> {
  factory $OriginalChartAnalysisCopyWith(OriginalChartAnalysis value,
          $Res Function(OriginalChartAnalysis) then) =
      _$OriginalChartAnalysisCopyWithImpl<$Res, OriginalChartAnalysis>;
  @useResult
  $Res call({String title, String content});
}

/// @nodoc
class _$OriginalChartAnalysisCopyWithImpl<$Res,
        $Val extends OriginalChartAnalysis>
    implements $OriginalChartAnalysisCopyWith<$Res> {
  _$OriginalChartAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OriginalChartAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OriginalChartAnalysisImplCopyWith<$Res>
    implements $OriginalChartAnalysisCopyWith<$Res> {
  factory _$$OriginalChartAnalysisImplCopyWith(
          _$OriginalChartAnalysisImpl value,
          $Res Function(_$OriginalChartAnalysisImpl) then) =
      __$$OriginalChartAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String content});
}

/// @nodoc
class __$$OriginalChartAnalysisImplCopyWithImpl<$Res>
    extends _$OriginalChartAnalysisCopyWithImpl<$Res,
        _$OriginalChartAnalysisImpl>
    implements _$$OriginalChartAnalysisImplCopyWith<$Res> {
  __$$OriginalChartAnalysisImplCopyWithImpl(_$OriginalChartAnalysisImpl _value,
      $Res Function(_$OriginalChartAnalysisImpl) _then)
      : super(_value, _then);

  /// Create a copy of OriginalChartAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
  }) {
    return _then(_$OriginalChartAnalysisImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _$OriginalChartAnalysisImpl implements _OriginalChartAnalysis {
  const _$OriginalChartAnalysisImpl(
      {required this.title, required this.content});

  factory _$OriginalChartAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$OriginalChartAnalysisImplFromJson(json);

  @override
  final String title;
  @override
  final String content;

  @override
  String toString() {
    return 'OriginalChartAnalysis(title: $title, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OriginalChartAnalysisImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, content);

  /// Create a copy of OriginalChartAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OriginalChartAnalysisImplCopyWith<_$OriginalChartAnalysisImpl>
      get copyWith => __$$OriginalChartAnalysisImplCopyWithImpl<
          _$OriginalChartAnalysisImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OriginalChartAnalysisImplToJson(
      this,
    );
  }
}

abstract class _OriginalChartAnalysis implements OriginalChartAnalysis {
  const factory _OriginalChartAnalysis(
      {required final String title,
      required final String content}) = _$OriginalChartAnalysisImpl;

  factory _OriginalChartAnalysis.fromJson(Map<String, dynamic> json) =
      _$OriginalChartAnalysisImpl.fromJson;

  @override
  String get title;
  @override
  String get content;

  /// Create a copy of OriginalChartAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OriginalChartAnalysisImplCopyWith<_$OriginalChartAnalysisImpl>
      get copyWith => throw _privateConstructorUsedError;
}

KeyGods _$KeyGodsFromJson(Map<String, dynamic> json) {
  return _KeyGods.fromJson(json);
}

/// @nodoc
mixin _$KeyGods {
  String get title => throw _privateConstructorUsedError;
  List<String> get favorable => throw _privateConstructorUsedError;
  List<String> get unfavorable => throw _privateConstructorUsedError;

  /// Serializes this KeyGods to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KeyGods
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeyGodsCopyWith<KeyGods> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyGodsCopyWith<$Res> {
  factory $KeyGodsCopyWith(KeyGods value, $Res Function(KeyGods) then) =
      _$KeyGodsCopyWithImpl<$Res, KeyGods>;
  @useResult
  $Res call({String title, List<String> favorable, List<String> unfavorable});
}

/// @nodoc
class _$KeyGodsCopyWithImpl<$Res, $Val extends KeyGods>
    implements $KeyGodsCopyWith<$Res> {
  _$KeyGodsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeyGods
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? favorable = null,
    Object? unfavorable = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      favorable: null == favorable
          ? _value.favorable
          : favorable // ignore: cast_nullable_to_non_nullable
              as List<String>,
      unfavorable: null == unfavorable
          ? _value.unfavorable
          : unfavorable // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KeyGodsImplCopyWith<$Res> implements $KeyGodsCopyWith<$Res> {
  factory _$$KeyGodsImplCopyWith(
          _$KeyGodsImpl value, $Res Function(_$KeyGodsImpl) then) =
      __$$KeyGodsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, List<String> favorable, List<String> unfavorable});
}

/// @nodoc
class __$$KeyGodsImplCopyWithImpl<$Res>
    extends _$KeyGodsCopyWithImpl<$Res, _$KeyGodsImpl>
    implements _$$KeyGodsImplCopyWith<$Res> {
  __$$KeyGodsImplCopyWithImpl(
      _$KeyGodsImpl _value, $Res Function(_$KeyGodsImpl) _then)
      : super(_value, _then);

  /// Create a copy of KeyGods
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? favorable = null,
    Object? unfavorable = null,
  }) {
    return _then(_$KeyGodsImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      favorable: null == favorable
          ? _value._favorable
          : favorable // ignore: cast_nullable_to_non_nullable
              as List<String>,
      unfavorable: null == unfavorable
          ? _value._unfavorable
          : unfavorable // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _$KeyGodsImpl implements _KeyGods {
  const _$KeyGodsImpl(
      {required this.title,
      required final List<String> favorable,
      required final List<String> unfavorable})
      : _favorable = favorable,
        _unfavorable = unfavorable;

  factory _$KeyGodsImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeyGodsImplFromJson(json);

  @override
  final String title;
  final List<String> _favorable;
  @override
  List<String> get favorable {
    if (_favorable is EqualUnmodifiableListView) return _favorable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favorable);
  }

  final List<String> _unfavorable;
  @override
  List<String> get unfavorable {
    if (_unfavorable is EqualUnmodifiableListView) return _unfavorable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unfavorable);
  }

  @override
  String toString() {
    return 'KeyGods(title: $title, favorable: $favorable, unfavorable: $unfavorable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyGodsImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._favorable, _favorable) &&
            const DeepCollectionEquality()
                .equals(other._unfavorable, _unfavorable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_favorable),
      const DeepCollectionEquality().hash(_unfavorable));

  /// Create a copy of KeyGods
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyGodsImplCopyWith<_$KeyGodsImpl> get copyWith =>
      __$$KeyGodsImplCopyWithImpl<_$KeyGodsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeyGodsImplToJson(
      this,
    );
  }
}

abstract class _KeyGods implements KeyGods {
  const factory _KeyGods(
      {required final String title,
      required final List<String> favorable,
      required final List<String> unfavorable}) = _$KeyGodsImpl;

  factory _KeyGods.fromJson(Map<String, dynamic> json) = _$KeyGodsImpl.fromJson;

  @override
  String get title;
  @override
  List<String> get favorable;
  @override
  List<String> get unfavorable;

  /// Create a copy of KeyGods
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeyGodsImplCopyWith<_$KeyGodsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnnualFortune2026 _$AnnualFortune2026FromJson(Map<String, dynamic> json) {
  return _AnnualFortune2026.fromJson(json);
}

/// @nodoc
mixin _$AnnualFortune2026 {
  String get wealth => throw _privateConstructorUsedError;
  String get career => throw _privateConstructorUsedError;
  String get love => throw _privateConstructorUsedError;
  String get health => throw _privateConstructorUsedError;

  /// Serializes this AnnualFortune2026 to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnnualFortune2026
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnnualFortune2026CopyWith<AnnualFortune2026> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnnualFortune2026CopyWith<$Res> {
  factory $AnnualFortune2026CopyWith(
          AnnualFortune2026 value, $Res Function(AnnualFortune2026) then) =
      _$AnnualFortune2026CopyWithImpl<$Res, AnnualFortune2026>;
  @useResult
  $Res call({String wealth, String career, String love, String health});
}

/// @nodoc
class _$AnnualFortune2026CopyWithImpl<$Res, $Val extends AnnualFortune2026>
    implements $AnnualFortune2026CopyWith<$Res> {
  _$AnnualFortune2026CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnnualFortune2026
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wealth = null,
    Object? career = null,
    Object? love = null,
    Object? health = null,
  }) {
    return _then(_value.copyWith(
      wealth: null == wealth
          ? _value.wealth
          : wealth // ignore: cast_nullable_to_non_nullable
              as String,
      career: null == career
          ? _value.career
          : career // ignore: cast_nullable_to_non_nullable
              as String,
      love: null == love
          ? _value.love
          : love // ignore: cast_nullable_to_non_nullable
              as String,
      health: null == health
          ? _value.health
          : health // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnnualFortune2026ImplCopyWith<$Res>
    implements $AnnualFortune2026CopyWith<$Res> {
  factory _$$AnnualFortune2026ImplCopyWith(_$AnnualFortune2026Impl value,
          $Res Function(_$AnnualFortune2026Impl) then) =
      __$$AnnualFortune2026ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String wealth, String career, String love, String health});
}

/// @nodoc
class __$$AnnualFortune2026ImplCopyWithImpl<$Res>
    extends _$AnnualFortune2026CopyWithImpl<$Res, _$AnnualFortune2026Impl>
    implements _$$AnnualFortune2026ImplCopyWith<$Res> {
  __$$AnnualFortune2026ImplCopyWithImpl(_$AnnualFortune2026Impl _value,
      $Res Function(_$AnnualFortune2026Impl) _then)
      : super(_value, _then);

  /// Create a copy of AnnualFortune2026
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wealth = null,
    Object? career = null,
    Object? love = null,
    Object? health = null,
  }) {
    return _then(_$AnnualFortune2026Impl(
      wealth: null == wealth
          ? _value.wealth
          : wealth // ignore: cast_nullable_to_non_nullable
              as String,
      career: null == career
          ? _value.career
          : career // ignore: cast_nullable_to_non_nullable
              as String,
      love: null == love
          ? _value.love
          : love // ignore: cast_nullable_to_non_nullable
              as String,
      health: null == health
          ? _value.health
          : health // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _$AnnualFortune2026Impl implements _AnnualFortune2026 {
  const _$AnnualFortune2026Impl(
      {required this.wealth,
      required this.career,
      required this.love,
      required this.health});

  factory _$AnnualFortune2026Impl.fromJson(Map<String, dynamic> json) =>
      _$$AnnualFortune2026ImplFromJson(json);

  @override
  final String wealth;
  @override
  final String career;
  @override
  final String love;
  @override
  final String health;

  @override
  String toString() {
    return 'AnnualFortune2026(wealth: $wealth, career: $career, love: $love, health: $health)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnnualFortune2026Impl &&
            (identical(other.wealth, wealth) || other.wealth == wealth) &&
            (identical(other.career, career) || other.career == career) &&
            (identical(other.love, love) || other.love == love) &&
            (identical(other.health, health) || other.health == health));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, wealth, career, love, health);

  /// Create a copy of AnnualFortune2026
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnnualFortune2026ImplCopyWith<_$AnnualFortune2026Impl> get copyWith =>
      __$$AnnualFortune2026ImplCopyWithImpl<_$AnnualFortune2026Impl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnnualFortune2026ImplToJson(
      this,
    );
  }
}

abstract class _AnnualFortune2026 implements AnnualFortune2026 {
  const factory _AnnualFortune2026(
      {required final String wealth,
      required final String career,
      required final String love,
      required final String health}) = _$AnnualFortune2026Impl;

  factory _AnnualFortune2026.fromJson(Map<String, dynamic> json) =
      _$AnnualFortune2026Impl.fromJson;

  @override
  String get wealth;
  @override
  String get career;
  @override
  String get love;
  @override
  String get health;

  /// Create a copy of AnnualFortune2026
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnnualFortune2026ImplCopyWith<_$AnnualFortune2026Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

FullReport _$FullReportFromJson(Map<String, dynamic> json) {
  return _FullReport.fromJson(json);
}

/// @nodoc
mixin _$FullReport {
  OriginalChartAnalysis get originalChartAnalysis =>
      throw _privateConstructorUsedError;
  KeyGods get keyGods => throw _privateConstructorUsedError;
  AnnualFortune2026 get annualFortune2026 => throw _privateConstructorUsedError;

  /// Serializes this FullReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FullReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FullReportCopyWith<FullReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FullReportCopyWith<$Res> {
  factory $FullReportCopyWith(
          FullReport value, $Res Function(FullReport) then) =
      _$FullReportCopyWithImpl<$Res, FullReport>;
  @useResult
  $Res call(
      {OriginalChartAnalysis originalChartAnalysis,
      KeyGods keyGods,
      AnnualFortune2026 annualFortune2026});

  $OriginalChartAnalysisCopyWith<$Res> get originalChartAnalysis;
  $KeyGodsCopyWith<$Res> get keyGods;
  $AnnualFortune2026CopyWith<$Res> get annualFortune2026;
}

/// @nodoc
class _$FullReportCopyWithImpl<$Res, $Val extends FullReport>
    implements $FullReportCopyWith<$Res> {
  _$FullReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FullReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalChartAnalysis = null,
    Object? keyGods = null,
    Object? annualFortune2026 = null,
  }) {
    return _then(_value.copyWith(
      originalChartAnalysis: null == originalChartAnalysis
          ? _value.originalChartAnalysis
          : originalChartAnalysis // ignore: cast_nullable_to_non_nullable
              as OriginalChartAnalysis,
      keyGods: null == keyGods
          ? _value.keyGods
          : keyGods // ignore: cast_nullable_to_non_nullable
              as KeyGods,
      annualFortune2026: null == annualFortune2026
          ? _value.annualFortune2026
          : annualFortune2026 // ignore: cast_nullable_to_non_nullable
              as AnnualFortune2026,
    ) as $Val);
  }

  /// Create a copy of FullReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OriginalChartAnalysisCopyWith<$Res> get originalChartAnalysis {
    return $OriginalChartAnalysisCopyWith<$Res>(_value.originalChartAnalysis,
        (value) {
      return _then(_value.copyWith(originalChartAnalysis: value) as $Val);
    });
  }

  /// Create a copy of FullReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KeyGodsCopyWith<$Res> get keyGods {
    return $KeyGodsCopyWith<$Res>(_value.keyGods, (value) {
      return _then(_value.copyWith(keyGods: value) as $Val);
    });
  }

  /// Create a copy of FullReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnnualFortune2026CopyWith<$Res> get annualFortune2026 {
    return $AnnualFortune2026CopyWith<$Res>(_value.annualFortune2026, (value) {
      return _then(_value.copyWith(annualFortune2026: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FullReportImplCopyWith<$Res>
    implements $FullReportCopyWith<$Res> {
  factory _$$FullReportImplCopyWith(
          _$FullReportImpl value, $Res Function(_$FullReportImpl) then) =
      __$$FullReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OriginalChartAnalysis originalChartAnalysis,
      KeyGods keyGods,
      AnnualFortune2026 annualFortune2026});

  @override
  $OriginalChartAnalysisCopyWith<$Res> get originalChartAnalysis;
  @override
  $KeyGodsCopyWith<$Res> get keyGods;
  @override
  $AnnualFortune2026CopyWith<$Res> get annualFortune2026;
}

/// @nodoc
class __$$FullReportImplCopyWithImpl<$Res>
    extends _$FullReportCopyWithImpl<$Res, _$FullReportImpl>
    implements _$$FullReportImplCopyWith<$Res> {
  __$$FullReportImplCopyWithImpl(
      _$FullReportImpl _value, $Res Function(_$FullReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of FullReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalChartAnalysis = null,
    Object? keyGods = null,
    Object? annualFortune2026 = null,
  }) {
    return _then(_$FullReportImpl(
      originalChartAnalysis: null == originalChartAnalysis
          ? _value.originalChartAnalysis
          : originalChartAnalysis // ignore: cast_nullable_to_non_nullable
              as OriginalChartAnalysis,
      keyGods: null == keyGods
          ? _value.keyGods
          : keyGods // ignore: cast_nullable_to_non_nullable
              as KeyGods,
      annualFortune2026: null == annualFortune2026
          ? _value.annualFortune2026
          : annualFortune2026 // ignore: cast_nullable_to_non_nullable
              as AnnualFortune2026,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _$FullReportImpl implements _FullReport {
  const _$FullReportImpl(
      {required this.originalChartAnalysis,
      required this.keyGods,
      required this.annualFortune2026});

  factory _$FullReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$FullReportImplFromJson(json);

  @override
  final OriginalChartAnalysis originalChartAnalysis;
  @override
  final KeyGods keyGods;
  @override
  final AnnualFortune2026 annualFortune2026;

  @override
  String toString() {
    return 'FullReport(originalChartAnalysis: $originalChartAnalysis, keyGods: $keyGods, annualFortune2026: $annualFortune2026)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FullReportImpl &&
            (identical(other.originalChartAnalysis, originalChartAnalysis) ||
                other.originalChartAnalysis == originalChartAnalysis) &&
            (identical(other.keyGods, keyGods) || other.keyGods == keyGods) &&
            (identical(other.annualFortune2026, annualFortune2026) ||
                other.annualFortune2026 == annualFortune2026));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, originalChartAnalysis, keyGods, annualFortune2026);

  /// Create a copy of FullReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FullReportImplCopyWith<_$FullReportImpl> get copyWith =>
      __$$FullReportImplCopyWithImpl<_$FullReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FullReportImplToJson(
      this,
    );
  }
}

abstract class _FullReport implements FullReport {
  const factory _FullReport(
      {required final OriginalChartAnalysis originalChartAnalysis,
      required final KeyGods keyGods,
      required final AnnualFortune2026 annualFortune2026}) = _$FullReportImpl;

  factory _FullReport.fromJson(Map<String, dynamic> json) =
      _$FullReportImpl.fromJson;

  @override
  OriginalChartAnalysis get originalChartAnalysis;
  @override
  KeyGods get keyGods;
  @override
  AnnualFortune2026 get annualFortune2026;

  /// Create a copy of FullReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FullReportImplCopyWith<_$FullReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
