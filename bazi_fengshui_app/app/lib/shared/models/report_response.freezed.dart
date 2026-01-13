// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReportData {
  String get title => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)
        career,
    required TResult Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)
        wealth,
    required TResult Function(String title, String healthSummary) health,
    required TResult Function(String title, String relationshipAdvice)
        relationship,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)?
        career,
    TResult? Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)?
        wealth,
    TResult? Function(String title, String healthSummary)? health,
    TResult? Function(String title, String relationshipAdvice)? relationship,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)?
        career,
    TResult Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)?
        wealth,
    TResult Function(String title, String healthSummary)? health,
    TResult Function(String title, String relationshipAdvice)? relationship,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CareerReport value) career,
    required TResult Function(WealthReport value) wealth,
    required TResult Function(HealthReport value) health,
    required TResult Function(RelationshipReport value) relationship,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CareerReport value)? career,
    TResult? Function(WealthReport value)? wealth,
    TResult? Function(HealthReport value)? health,
    TResult? Function(RelationshipReport value)? relationship,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CareerReport value)? career,
    TResult Function(WealthReport value)? wealth,
    TResult Function(HealthReport value)? health,
    TResult Function(RelationshipReport value)? relationship,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportDataCopyWith<ReportData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportDataCopyWith<$Res> {
  factory $ReportDataCopyWith(
          ReportData value, $Res Function(ReportData) then) =
      _$ReportDataCopyWithImpl<$Res, ReportData>;
  @useResult
  $Res call({String title});
}

/// @nodoc
class _$ReportDataCopyWithImpl<$Res, $Val extends ReportData>
    implements $ReportDataCopyWith<$Res> {
  _$ReportDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CareerReportImplCopyWith<$Res>
    implements $ReportDataCopyWith<$Res> {
  factory _$$CareerReportImplCopyWith(
          _$CareerReportImpl value, $Res Function(_$CareerReportImpl) then) =
      __$$CareerReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      Map<String, dynamic> summary,
      List<Map<String, dynamic>> careerPathSuggestions});
}

/// @nodoc
class __$$CareerReportImplCopyWithImpl<$Res>
    extends _$ReportDataCopyWithImpl<$Res, _$CareerReportImpl>
    implements _$$CareerReportImplCopyWith<$Res> {
  __$$CareerReportImplCopyWithImpl(
      _$CareerReportImpl _value, $Res Function(_$CareerReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? summary = null,
    Object? careerPathSuggestions = null,
  }) {
    return _then(_$CareerReportImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value._summary
          : summary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      careerPathSuggestions: null == careerPathSuggestions
          ? _value._careerPathSuggestions
          : careerPathSuggestions // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc

class _$CareerReportImpl implements CareerReport {
  const _$CareerReportImpl(
      {required this.title,
      required final Map<String, dynamic> summary,
      required final List<Map<String, dynamic>> careerPathSuggestions})
      : _summary = summary,
        _careerPathSuggestions = careerPathSuggestions;

  @override
  final String title;
  final Map<String, dynamic> _summary;
  @override
  Map<String, dynamic> get summary {
    if (_summary is EqualUnmodifiableMapView) return _summary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_summary);
  }

  final List<Map<String, dynamic>> _careerPathSuggestions;
  @override
  List<Map<String, dynamic>> get careerPathSuggestions {
    if (_careerPathSuggestions is EqualUnmodifiableListView)
      return _careerPathSuggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_careerPathSuggestions);
  }

  @override
  String toString() {
    return 'ReportData.career(title: $title, summary: $summary, careerPathSuggestions: $careerPathSuggestions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CareerReportImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._summary, _summary) &&
            const DeepCollectionEquality()
                .equals(other._careerPathSuggestions, _careerPathSuggestions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_summary),
      const DeepCollectionEquality().hash(_careerPathSuggestions));

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CareerReportImplCopyWith<_$CareerReportImpl> get copyWith =>
      __$$CareerReportImplCopyWithImpl<_$CareerReportImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)
        career,
    required TResult Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)
        wealth,
    required TResult Function(String title, String healthSummary) health,
    required TResult Function(String title, String relationshipAdvice)
        relationship,
  }) {
    return career(title, summary, careerPathSuggestions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)?
        career,
    TResult? Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)?
        wealth,
    TResult? Function(String title, String healthSummary)? health,
    TResult? Function(String title, String relationshipAdvice)? relationship,
  }) {
    return career?.call(title, summary, careerPathSuggestions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)?
        career,
    TResult Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)?
        wealth,
    TResult Function(String title, String healthSummary)? health,
    TResult Function(String title, String relationshipAdvice)? relationship,
    required TResult orElse(),
  }) {
    if (career != null) {
      return career(title, summary, careerPathSuggestions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CareerReport value) career,
    required TResult Function(WealthReport value) wealth,
    required TResult Function(HealthReport value) health,
    required TResult Function(RelationshipReport value) relationship,
  }) {
    return career(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CareerReport value)? career,
    TResult? Function(WealthReport value)? wealth,
    TResult? Function(HealthReport value)? health,
    TResult? Function(RelationshipReport value)? relationship,
  }) {
    return career?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CareerReport value)? career,
    TResult Function(WealthReport value)? wealth,
    TResult Function(HealthReport value)? health,
    TResult Function(RelationshipReport value)? relationship,
    required TResult orElse(),
  }) {
    if (career != null) {
      return career(this);
    }
    return orElse();
  }
}

abstract class CareerReport implements ReportData {
  const factory CareerReport(
          {required final String title,
          required final Map<String, dynamic> summary,
          required final List<Map<String, dynamic>> careerPathSuggestions}) =
      _$CareerReportImpl;

  @override
  String get title;
  Map<String, dynamic> get summary;
  List<Map<String, dynamic>> get careerPathSuggestions;

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CareerReportImplCopyWith<_$CareerReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WealthReportImplCopyWith<$Res>
    implements $ReportDataCopyWith<$Res> {
  factory _$$WealthReportImplCopyWith(
          _$WealthReportImpl value, $Res Function(_$WealthReportImpl) then) =
      __$$WealthReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      double fiveYearProjection,
      List<String> investmentSuggestions});
}

/// @nodoc
class __$$WealthReportImplCopyWithImpl<$Res>
    extends _$ReportDataCopyWithImpl<$Res, _$WealthReportImpl>
    implements _$$WealthReportImplCopyWith<$Res> {
  __$$WealthReportImplCopyWithImpl(
      _$WealthReportImpl _value, $Res Function(_$WealthReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? fiveYearProjection = null,
    Object? investmentSuggestions = null,
  }) {
    return _then(_$WealthReportImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      fiveYearProjection: null == fiveYearProjection
          ? _value.fiveYearProjection
          : fiveYearProjection // ignore: cast_nullable_to_non_nullable
              as double,
      investmentSuggestions: null == investmentSuggestions
          ? _value._investmentSuggestions
          : investmentSuggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$WealthReportImpl implements WealthReport {
  const _$WealthReportImpl(
      {required this.title,
      required this.fiveYearProjection,
      required final List<String> investmentSuggestions})
      : _investmentSuggestions = investmentSuggestions;

  @override
  final String title;
  @override
  final double fiveYearProjection;
  final List<String> _investmentSuggestions;
  @override
  List<String> get investmentSuggestions {
    if (_investmentSuggestions is EqualUnmodifiableListView)
      return _investmentSuggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_investmentSuggestions);
  }

  @override
  String toString() {
    return 'ReportData.wealth(title: $title, fiveYearProjection: $fiveYearProjection, investmentSuggestions: $investmentSuggestions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WealthReportImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.fiveYearProjection, fiveYearProjection) ||
                other.fiveYearProjection == fiveYearProjection) &&
            const DeepCollectionEquality()
                .equals(other._investmentSuggestions, _investmentSuggestions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, fiveYearProjection,
      const DeepCollectionEquality().hash(_investmentSuggestions));

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WealthReportImplCopyWith<_$WealthReportImpl> get copyWith =>
      __$$WealthReportImplCopyWithImpl<_$WealthReportImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)
        career,
    required TResult Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)
        wealth,
    required TResult Function(String title, String healthSummary) health,
    required TResult Function(String title, String relationshipAdvice)
        relationship,
  }) {
    return wealth(title, fiveYearProjection, investmentSuggestions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)?
        career,
    TResult? Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)?
        wealth,
    TResult? Function(String title, String healthSummary)? health,
    TResult? Function(String title, String relationshipAdvice)? relationship,
  }) {
    return wealth?.call(title, fiveYearProjection, investmentSuggestions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)?
        career,
    TResult Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)?
        wealth,
    TResult Function(String title, String healthSummary)? health,
    TResult Function(String title, String relationshipAdvice)? relationship,
    required TResult orElse(),
  }) {
    if (wealth != null) {
      return wealth(title, fiveYearProjection, investmentSuggestions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CareerReport value) career,
    required TResult Function(WealthReport value) wealth,
    required TResult Function(HealthReport value) health,
    required TResult Function(RelationshipReport value) relationship,
  }) {
    return wealth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CareerReport value)? career,
    TResult? Function(WealthReport value)? wealth,
    TResult? Function(HealthReport value)? health,
    TResult? Function(RelationshipReport value)? relationship,
  }) {
    return wealth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CareerReport value)? career,
    TResult Function(WealthReport value)? wealth,
    TResult Function(HealthReport value)? health,
    TResult Function(RelationshipReport value)? relationship,
    required TResult orElse(),
  }) {
    if (wealth != null) {
      return wealth(this);
    }
    return orElse();
  }
}

abstract class WealthReport implements ReportData {
  const factory WealthReport(
      {required final String title,
      required final double fiveYearProjection,
      required final List<String> investmentSuggestions}) = _$WealthReportImpl;

  @override
  String get title;
  double get fiveYearProjection;
  List<String> get investmentSuggestions;

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WealthReportImplCopyWith<_$WealthReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HealthReportImplCopyWith<$Res>
    implements $ReportDataCopyWith<$Res> {
  factory _$$HealthReportImplCopyWith(
          _$HealthReportImpl value, $Res Function(_$HealthReportImpl) then) =
      __$$HealthReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String healthSummary});
}

/// @nodoc
class __$$HealthReportImplCopyWithImpl<$Res>
    extends _$ReportDataCopyWithImpl<$Res, _$HealthReportImpl>
    implements _$$HealthReportImplCopyWith<$Res> {
  __$$HealthReportImplCopyWithImpl(
      _$HealthReportImpl _value, $Res Function(_$HealthReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? healthSummary = null,
  }) {
    return _then(_$HealthReportImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      healthSummary: null == healthSummary
          ? _value.healthSummary
          : healthSummary // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HealthReportImpl implements HealthReport {
  const _$HealthReportImpl({required this.title, required this.healthSummary});

  @override
  final String title;
  @override
  final String healthSummary;

  @override
  String toString() {
    return 'ReportData.health(title: $title, healthSummary: $healthSummary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthReportImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.healthSummary, healthSummary) ||
                other.healthSummary == healthSummary));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, healthSummary);

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthReportImplCopyWith<_$HealthReportImpl> get copyWith =>
      __$$HealthReportImplCopyWithImpl<_$HealthReportImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)
        career,
    required TResult Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)
        wealth,
    required TResult Function(String title, String healthSummary) health,
    required TResult Function(String title, String relationshipAdvice)
        relationship,
  }) {
    return health(title, healthSummary);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)?
        career,
    TResult? Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)?
        wealth,
    TResult? Function(String title, String healthSummary)? health,
    TResult? Function(String title, String relationshipAdvice)? relationship,
  }) {
    return health?.call(title, healthSummary);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)?
        career,
    TResult Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)?
        wealth,
    TResult Function(String title, String healthSummary)? health,
    TResult Function(String title, String relationshipAdvice)? relationship,
    required TResult orElse(),
  }) {
    if (health != null) {
      return health(title, healthSummary);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CareerReport value) career,
    required TResult Function(WealthReport value) wealth,
    required TResult Function(HealthReport value) health,
    required TResult Function(RelationshipReport value) relationship,
  }) {
    return health(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CareerReport value)? career,
    TResult? Function(WealthReport value)? wealth,
    TResult? Function(HealthReport value)? health,
    TResult? Function(RelationshipReport value)? relationship,
  }) {
    return health?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CareerReport value)? career,
    TResult Function(WealthReport value)? wealth,
    TResult Function(HealthReport value)? health,
    TResult Function(RelationshipReport value)? relationship,
    required TResult orElse(),
  }) {
    if (health != null) {
      return health(this);
    }
    return orElse();
  }
}

abstract class HealthReport implements ReportData {
  const factory HealthReport(
      {required final String title,
      required final String healthSummary}) = _$HealthReportImpl;

  @override
  String get title;
  String get healthSummary;

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthReportImplCopyWith<_$HealthReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RelationshipReportImplCopyWith<$Res>
    implements $ReportDataCopyWith<$Res> {
  factory _$$RelationshipReportImplCopyWith(_$RelationshipReportImpl value,
          $Res Function(_$RelationshipReportImpl) then) =
      __$$RelationshipReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String relationshipAdvice});
}

/// @nodoc
class __$$RelationshipReportImplCopyWithImpl<$Res>
    extends _$ReportDataCopyWithImpl<$Res, _$RelationshipReportImpl>
    implements _$$RelationshipReportImplCopyWith<$Res> {
  __$$RelationshipReportImplCopyWithImpl(_$RelationshipReportImpl _value,
      $Res Function(_$RelationshipReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? relationshipAdvice = null,
  }) {
    return _then(_$RelationshipReportImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      relationshipAdvice: null == relationshipAdvice
          ? _value.relationshipAdvice
          : relationshipAdvice // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RelationshipReportImpl implements RelationshipReport {
  const _$RelationshipReportImpl(
      {required this.title, required this.relationshipAdvice});

  @override
  final String title;
  @override
  final String relationshipAdvice;

  @override
  String toString() {
    return 'ReportData.relationship(title: $title, relationshipAdvice: $relationshipAdvice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelationshipReportImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.relationshipAdvice, relationshipAdvice) ||
                other.relationshipAdvice == relationshipAdvice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, relationshipAdvice);

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RelationshipReportImplCopyWith<_$RelationshipReportImpl> get copyWith =>
      __$$RelationshipReportImplCopyWithImpl<_$RelationshipReportImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)
        career,
    required TResult Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)
        wealth,
    required TResult Function(String title, String healthSummary) health,
    required TResult Function(String title, String relationshipAdvice)
        relationship,
  }) {
    return relationship(title, relationshipAdvice);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)?
        career,
    TResult? Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)?
        wealth,
    TResult? Function(String title, String healthSummary)? health,
    TResult? Function(String title, String relationshipAdvice)? relationship,
  }) {
    return relationship?.call(title, relationshipAdvice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, Map<String, dynamic> summary,
            List<Map<String, dynamic>> careerPathSuggestions)?
        career,
    TResult Function(String title, double fiveYearProjection,
            List<String> investmentSuggestions)?
        wealth,
    TResult Function(String title, String healthSummary)? health,
    TResult Function(String title, String relationshipAdvice)? relationship,
    required TResult orElse(),
  }) {
    if (relationship != null) {
      return relationship(title, relationshipAdvice);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CareerReport value) career,
    required TResult Function(WealthReport value) wealth,
    required TResult Function(HealthReport value) health,
    required TResult Function(RelationshipReport value) relationship,
  }) {
    return relationship(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CareerReport value)? career,
    TResult? Function(WealthReport value)? wealth,
    TResult? Function(HealthReport value)? health,
    TResult? Function(RelationshipReport value)? relationship,
  }) {
    return relationship?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CareerReport value)? career,
    TResult Function(WealthReport value)? wealth,
    TResult Function(HealthReport value)? health,
    TResult Function(RelationshipReport value)? relationship,
    required TResult orElse(),
  }) {
    if (relationship != null) {
      return relationship(this);
    }
    return orElse();
  }
}

abstract class RelationshipReport implements ReportData {
  const factory RelationshipReport(
      {required final String title,
      required final String relationshipAdvice}) = _$RelationshipReportImpl;

  @override
  String get title;
  String get relationshipAdvice;

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RelationshipReportImplCopyWith<_$RelationshipReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReportMetadata _$ReportMetadataFromJson(Map<String, dynamic> json) {
  return _ReportMetadata.fromJson(json);
}

/// @nodoc
mixin _$ReportMetadata {
  String get source => throw _privateConstructorUsedError;
  String get promptVersion => throw _privateConstructorUsedError;
  String get deployTag => throw _privateConstructorUsedError;
  DateTime? get cacheTimestamp => throw _privateConstructorUsedError;

  /// Serializes this ReportMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportMetadataCopyWith<ReportMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportMetadataCopyWith<$Res> {
  factory $ReportMetadataCopyWith(
          ReportMetadata value, $Res Function(ReportMetadata) then) =
      _$ReportMetadataCopyWithImpl<$Res, ReportMetadata>;
  @useResult
  $Res call(
      {String source,
      String promptVersion,
      String deployTag,
      DateTime? cacheTimestamp});
}

/// @nodoc
class _$ReportMetadataCopyWithImpl<$Res, $Val extends ReportMetadata>
    implements $ReportMetadataCopyWith<$Res> {
  _$ReportMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? promptVersion = null,
    Object? deployTag = null,
    Object? cacheTimestamp = freezed,
  }) {
    return _then(_value.copyWith(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      promptVersion: null == promptVersion
          ? _value.promptVersion
          : promptVersion // ignore: cast_nullable_to_non_nullable
              as String,
      deployTag: null == deployTag
          ? _value.deployTag
          : deployTag // ignore: cast_nullable_to_non_nullable
              as String,
      cacheTimestamp: freezed == cacheTimestamp
          ? _value.cacheTimestamp
          : cacheTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportMetadataImplCopyWith<$Res>
    implements $ReportMetadataCopyWith<$Res> {
  factory _$$ReportMetadataImplCopyWith(_$ReportMetadataImpl value,
          $Res Function(_$ReportMetadataImpl) then) =
      __$$ReportMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String source,
      String promptVersion,
      String deployTag,
      DateTime? cacheTimestamp});
}

/// @nodoc
class __$$ReportMetadataImplCopyWithImpl<$Res>
    extends _$ReportMetadataCopyWithImpl<$Res, _$ReportMetadataImpl>
    implements _$$ReportMetadataImplCopyWith<$Res> {
  __$$ReportMetadataImplCopyWithImpl(
      _$ReportMetadataImpl _value, $Res Function(_$ReportMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReportMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? promptVersion = null,
    Object? deployTag = null,
    Object? cacheTimestamp = freezed,
  }) {
    return _then(_$ReportMetadataImpl(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      promptVersion: null == promptVersion
          ? _value.promptVersion
          : promptVersion // ignore: cast_nullable_to_non_nullable
              as String,
      deployTag: null == deployTag
          ? _value.deployTag
          : deployTag // ignore: cast_nullable_to_non_nullable
              as String,
      cacheTimestamp: freezed == cacheTimestamp
          ? _value.cacheTimestamp
          : cacheTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportMetadataImpl implements _ReportMetadata {
  const _$ReportMetadataImpl(
      {required this.source,
      required this.promptVersion,
      required this.deployTag,
      this.cacheTimestamp});

  factory _$ReportMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportMetadataImplFromJson(json);

  @override
  final String source;
  @override
  final String promptVersion;
  @override
  final String deployTag;
  @override
  final DateTime? cacheTimestamp;

  @override
  String toString() {
    return 'ReportMetadata(source: $source, promptVersion: $promptVersion, deployTag: $deployTag, cacheTimestamp: $cacheTimestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportMetadataImpl &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.promptVersion, promptVersion) ||
                other.promptVersion == promptVersion) &&
            (identical(other.deployTag, deployTag) ||
                other.deployTag == deployTag) &&
            (identical(other.cacheTimestamp, cacheTimestamp) ||
                other.cacheTimestamp == cacheTimestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, source, promptVersion, deployTag, cacheTimestamp);

  /// Create a copy of ReportMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportMetadataImplCopyWith<_$ReportMetadataImpl> get copyWith =>
      __$$ReportMetadataImplCopyWithImpl<_$ReportMetadataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportMetadataImplToJson(
      this,
    );
  }
}

abstract class _ReportMetadata implements ReportMetadata {
  const factory _ReportMetadata(
      {required final String source,
      required final String promptVersion,
      required final String deployTag,
      final DateTime? cacheTimestamp}) = _$ReportMetadataImpl;

  factory _ReportMetadata.fromJson(Map<String, dynamic> json) =
      _$ReportMetadataImpl.fromJson;

  @override
  String get source;
  @override
  String get promptVersion;
  @override
  String get deployTag;
  @override
  DateTime? get cacheTimestamp;

  /// Create a copy of ReportMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportMetadataImplCopyWith<_$ReportMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FunctionResponse _$FunctionResponseFromJson(Map<String, dynamic> json) {
  return _FunctionResponse.fromJson(json);
}

/// @nodoc
mixin _$FunctionResponse {
  @ReportDataJsonConverter()
  ReportData get report => throw _privateConstructorUsedError;
  ReportMetadata get metadata => throw _privateConstructorUsedError;

  /// Serializes this FunctionResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FunctionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FunctionResponseCopyWith<FunctionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FunctionResponseCopyWith<$Res> {
  factory $FunctionResponseCopyWith(
          FunctionResponse value, $Res Function(FunctionResponse) then) =
      _$FunctionResponseCopyWithImpl<$Res, FunctionResponse>;
  @useResult
  $Res call(
      {@ReportDataJsonConverter() ReportData report, ReportMetadata metadata});

  $ReportDataCopyWith<$Res> get report;
  $ReportMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class _$FunctionResponseCopyWithImpl<$Res, $Val extends FunctionResponse>
    implements $FunctionResponseCopyWith<$Res> {
  _$FunctionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FunctionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? report = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      report: null == report
          ? _value.report
          : report // ignore: cast_nullable_to_non_nullable
              as ReportData,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as ReportMetadata,
    ) as $Val);
  }

  /// Create a copy of FunctionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReportDataCopyWith<$Res> get report {
    return $ReportDataCopyWith<$Res>(_value.report, (value) {
      return _then(_value.copyWith(report: value) as $Val);
    });
  }

  /// Create a copy of FunctionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReportMetadataCopyWith<$Res> get metadata {
    return $ReportMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FunctionResponseImplCopyWith<$Res>
    implements $FunctionResponseCopyWith<$Res> {
  factory _$$FunctionResponseImplCopyWith(_$FunctionResponseImpl value,
          $Res Function(_$FunctionResponseImpl) then) =
      __$$FunctionResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ReportDataJsonConverter() ReportData report, ReportMetadata metadata});

  @override
  $ReportDataCopyWith<$Res> get report;
  @override
  $ReportMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class __$$FunctionResponseImplCopyWithImpl<$Res>
    extends _$FunctionResponseCopyWithImpl<$Res, _$FunctionResponseImpl>
    implements _$$FunctionResponseImplCopyWith<$Res> {
  __$$FunctionResponseImplCopyWithImpl(_$FunctionResponseImpl _value,
      $Res Function(_$FunctionResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of FunctionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? report = null,
    Object? metadata = null,
  }) {
    return _then(_$FunctionResponseImpl(
      report: null == report
          ? _value.report
          : report // ignore: cast_nullable_to_non_nullable
              as ReportData,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as ReportMetadata,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FunctionResponseImpl implements _FunctionResponse {
  const _$FunctionResponseImpl(
      {@ReportDataJsonConverter() required this.report,
      required this.metadata});

  factory _$FunctionResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FunctionResponseImplFromJson(json);

  @override
  @ReportDataJsonConverter()
  final ReportData report;
  @override
  final ReportMetadata metadata;

  @override
  String toString() {
    return 'FunctionResponse(report: $report, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FunctionResponseImpl &&
            (identical(other.report, report) || other.report == report) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, report, metadata);

  /// Create a copy of FunctionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FunctionResponseImplCopyWith<_$FunctionResponseImpl> get copyWith =>
      __$$FunctionResponseImplCopyWithImpl<_$FunctionResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FunctionResponseImplToJson(
      this,
    );
  }
}

abstract class _FunctionResponse implements FunctionResponse {
  const factory _FunctionResponse(
      {@ReportDataJsonConverter() required final ReportData report,
      required final ReportMetadata metadata}) = _$FunctionResponseImpl;

  factory _FunctionResponse.fromJson(Map<String, dynamic> json) =
      _$FunctionResponseImpl.fromJson;

  @override
  @ReportDataJsonConverter()
  ReportData get report;
  @override
  ReportMetadata get metadata;

  /// Create a copy of FunctionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FunctionResponseImplCopyWith<_$FunctionResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
