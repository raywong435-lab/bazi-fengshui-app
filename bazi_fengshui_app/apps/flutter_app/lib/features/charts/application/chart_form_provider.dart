import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/providers/firebase_providers.dart';
import 'chart_list_provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/foundation.dart';

// Adjust imports to your project structure
// import 'package:app/features/charts/data/charts_repository.dart';
// import 'package:app/features/charts/domain/chart.dart';
// import 'package:app/features/charts/application/chart_list_provider.dart';

part 'chart_form_provider.freezed.dart';
part 'chart_form_provider.g.dart';

@freezed
class ChartFormData with _$ChartFormData {
  const factory ChartFormData({
    @Default('') String name,
    DateTime? birthDate,
    @Default('00:00') String birthTime,
    @Default('Asia/Shanghai') String timeZone,
    @Default('male') String gender,
  }) = _ChartFormData;

  // No JSON serialization needed for this in-file model
}

@riverpod
class ChartFormNotifier extends _$ChartFormNotifier {
  @override
  FutureOr<ChartFormData> build() {
    // Initialize time zone database once
    tz.initializeTimeZones();
    return const ChartFormData();
  }

  void updateName(String name) {
    final current = state.value ?? const ChartFormData();
    state = AsyncValue.data(current.copyWith(name: name));
  }

  void updateBirthDate(DateTime date) {
    final current = state.value ?? const ChartFormData();
    state = AsyncValue.data(current.copyWith(birthDate: date));
  }

  void updateBirthTime(String time) {
    final current = state.value ?? const ChartFormData();
    state = AsyncValue.data(current.copyWith(birthTime: time));
  }

  void updateTimeZone(String tzName) {
    final current = state.value ?? const ChartFormData();
    state = AsyncValue.data(current.copyWith(timeZone: tzName));
  }

  void updateGender(String gender) {
    final current = state.value ?? const ChartFormData();
    state = AsyncValue.data(current.copyWith(gender: gender));
  }

  void reset() {
    state = const AsyncValue.data(ChartFormData());
  }

  Future<void> submitChart() async {
    // Validate form data exists
    final current = state.value ?? const ChartFormData();
    if (current.name.isEmpty || current.birthDate == null) {
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // Read Firebase Functions provider
      final functions = ref.read(firebaseFunctionsProvider);
      final callable = functions.httpsCallable('createChart');

      // Compose payload
      final birthDate = current.birthDate!;
      // birthTime stored as 'HH:mm'
      final parts = current.birthTime.split(':');
      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0;
      final fullDateTime = DateTime(birthDate.year, birthDate.month, birthDate.day, hour, minute);

      await callable.call({
        'name': current.name,
        'gender': current.gender,
        'birthDate': fullDateTime.toIso8601String(),
        'timeZone': current.timeZone,
      });

      // Invalidate chart list provider to refresh UI
      ref.invalidate(chartListProvider);

      return current;
    });
  }

  List<String> get allTimezones => tz.timeZoneDatabase.locations.keys.toList();
}
