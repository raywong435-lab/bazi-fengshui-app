import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../application/chart_form_provider.dart';

class CreateChartPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  CreateChartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 使用 ref.listen 處理一次性事件，如顯示 SnackBar 或導航
    ref.listen<AsyncValue<ChartFormData>>(chartFormNotifierProvider, (prev, next) {
      if (next.hasError && !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('提交失敗: ${next.error}')));
      }
      if (!next.hasError && prev is AsyncLoading) {
        Navigator.of(context).pop();
      }
    });

    final formState = ref.watch(chartFormNotifierProvider);
    final formNotifier = ref.read(chartFormNotifierProvider.notifier);
    final formData = formState.value ?? const ChartFormData();
    final isLoading = formState.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('建立命盤')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // 名稱欄位
                    TextFormField(
                      initialValue: formData.name,
                      decoration: const InputDecoration(labelText: '姓名'),
                      validator: (v) => (v == null || v.isEmpty) ? '請輸入姓名' : null,
                      onChanged: formNotifier.updateName,
                    ),

                    const SizedBox(height: 12),

                    // 性別
                    DropdownButtonFormField<String>(
                      initialValue: formData.gender,
                      items: const [
                        DropdownMenuItem(value: 'male', child: Text('男')),
                        DropdownMenuItem(value: 'female', child: Text('女')),
                      ],
                      onChanged: (v) => v != null ? formNotifier.updateGender(v) : null,
                      decoration: const InputDecoration(labelText: '性別'),
                    ),

                    const SizedBox(height: 12),

                    // 出生日期
                    InkWell(
                      onTap: () async {
                        final now = DateTime.now();
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: formData.birthDate ?? now,
                          firstDate: DateTime(1900),
                          lastDate: now,
                        );
                        if (picked != null) formNotifier.updateBirthDate(picked);
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(labelText: '出生日期'),
                        child: Text(formData.birthDate != null ? DateFormat.yMMMMd().format(formData.birthDate!) : '選擇日期'),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 出生時間
                    InkWell(
                      onTap: () async {
                        final initial = TimeOfDay.fromDateTime(DateTime.now());
                        final picked = await showTimePicker(context: context, initialTime: initial);
                        if (picked != null) {
                          final hh = picked.hour.toString().padLeft(2, '0');
                          final mm = picked.minute.toString().padLeft(2, '0');
                          formNotifier.updateBirthTime('$hh:$mm');
                        }
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(labelText: '出生時間'),
                        child: Text(formData.birthTime),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 使用 dropdown_search 優化時區選擇
                    DropdownSearch<String>(
                      popupProps: const PopupProps.modalBottomSheet(showSearchBox: true),
                      items: formNotifier.allTimezones,
                      onChanged: formNotifier.updateTimeZone,
                      selectedItem: formData.timeZone,
                      validator: (value) => value == null ? '請選擇時區' : null,
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          formNotifier.submitChart();
                        }
                      },
                      child: const Text('建立命盤'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
