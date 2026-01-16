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
    ref.listen<AsyncValue<ChartFormData>>(chartFormNotifierProvider, (prev, next) {
      if (next.hasError && !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Submit failed: ${next.error}')),
        );
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
      appBar: AppBar(title: const Text('Create Chart')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: formData.name,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (v) => (v == null || v.isEmpty) ? 'Please enter a name.' : null,
                      onChanged: formNotifier.updateName,
                    ),

                    const SizedBox(height: 12),

                    DropdownButtonFormField<String>(
                      initialValue: formData.gender,
                      items: const [
                        DropdownMenuItem(value: 'male', child: Text('Male')),
                        DropdownMenuItem(value: 'female', child: Text('Female')),
                      ],
                      onChanged: (v) => v != null ? formNotifier.updateGender(v) : null,
                      decoration: const InputDecoration(labelText: 'Gender'),
                    ),

                    const SizedBox(height: 12),

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
                        decoration: const InputDecoration(labelText: 'Birth date'),
                        child: Text(
                          formData.birthDate != null
                              ? DateFormat.yMMMMd().format(formData.birthDate!)
                              : 'Select birth date',
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

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
                        decoration: const InputDecoration(labelText: 'Birth time'),
                        child: Text(formData.birthTime),
                      ),
                    ),

                    const SizedBox(height: 12),

                    DropdownSearch<String>(
                      popupProps: const PopupProps.modalBottomSheet(showSearchBox: true),
                      items: formNotifier.allTimezones,
                      onChanged: (value) {
                        if (value != null) {
                          formNotifier.updateTimeZone(value);
                        }
                      },
                      selectedItem: formData.timeZone,
                      validator: (value) => value == null ? 'Please select a time zone.' : null,
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          formNotifier.submitChart();
                        }
                      },
                      child: const Text('Create Chart'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
