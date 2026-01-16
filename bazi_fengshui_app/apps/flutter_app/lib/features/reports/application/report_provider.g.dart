// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reportScreenDataHash() => r'c577f65f5473ff4a30b88bf362a1cc0e2f1a6d64';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for ReportScreen data (chart + aggregated report)
///
/// Copied from [reportScreenData].
@ProviderFor(reportScreenData)
const reportScreenDataProvider = ReportScreenDataFamily();

/// Provider for ReportScreen data (chart + aggregated report)
///
/// Copied from [reportScreenData].
class ReportScreenDataFamily extends Family<AsyncValue<ReportScreenData>> {
  /// Provider for ReportScreen data (chart + aggregated report)
  ///
  /// Copied from [reportScreenData].
  const ReportScreenDataFamily();

  /// Provider for ReportScreen data (chart + aggregated report)
  ///
  /// Copied from [reportScreenData].
  ReportScreenDataProvider call({
    required String chartId,
  }) {
    return ReportScreenDataProvider(
      chartId: chartId,
    );
  }

  @override
  ReportScreenDataProvider getProviderOverride(
    covariant ReportScreenDataProvider provider,
  ) {
    return call(
      chartId: provider.chartId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'reportScreenDataProvider';
}

/// Provider for ReportScreen data (chart + aggregated report)
///
/// Copied from [reportScreenData].
class ReportScreenDataProvider
    extends AutoDisposeFutureProvider<ReportScreenData> {
  /// Provider for ReportScreen data (chart + aggregated report)
  ///
  /// Copied from [reportScreenData].
  ReportScreenDataProvider({
    required String chartId,
  }) : this._internal(
          (ref) => reportScreenData(
            ref as ReportScreenDataRef,
            chartId: chartId,
          ),
          from: reportScreenDataProvider,
          name: r'reportScreenDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reportScreenDataHash,
          dependencies: ReportScreenDataFamily._dependencies,
          allTransitiveDependencies:
              ReportScreenDataFamily._allTransitiveDependencies,
          chartId: chartId,
        );

  ReportScreenDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chartId,
  }) : super.internal();

  final String chartId;

  @override
  Override overrideWith(
    FutureOr<ReportScreenData> Function(ReportScreenDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReportScreenDataProvider._internal(
        (ref) => create(ref as ReportScreenDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chartId: chartId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ReportScreenData> createElement() {
    return _ReportScreenDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReportScreenDataProvider && other.chartId == chartId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chartId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReportScreenDataRef on AutoDisposeFutureProviderRef<ReportScreenData> {
  /// The parameter `chartId` of this provider.
  String get chartId;
}

class _ReportScreenDataProviderElement
    extends AutoDisposeFutureProviderElement<ReportScreenData>
    with ReportScreenDataRef {
  _ReportScreenDataProviderElement(super.provider);

  @override
  String get chartId => (origin as ReportScreenDataProvider).chartId;
}

String _$reportNotifierHash() => r'2913c24777d8ba093c4643869a2399b9fcbf6280';

/// See also [ReportNotifier].
@ProviderFor(ReportNotifier)
final reportNotifierProvider = AutoDisposeAsyncNotifierProvider<ReportNotifier,
    FunctionResponse?>.internal(
  ReportNotifier.new,
  name: r'reportNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reportNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReportNotifier = AutoDisposeAsyncNotifier<FunctionResponse?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
