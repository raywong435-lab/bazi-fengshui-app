import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/birth_info.dart';
import '../providers/report_provider.dart';

class InputScreen extends ConsumerStatefulWidget {
  const InputScreen({super.key});

  @override
  ConsumerState<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends ConsumerState<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _birthDate;
  String _birthTime = '';
  String _birthPlace = '';

  @override
  Widget build(BuildContext context) {
    final reportState = ref.watch(reportProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Birth Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Birth Date'),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _birthDate = date;
                    });
                  }
                },
                validator: (value) {
                  if (_birthDate == null) return 'Please select birth date';
                  return null;
                },
                controller: TextEditingController(
                  text: _birthDate?.toString().split(' ')[0] ?? '',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Birth Time (HH:MM)'),
                onChanged: (value) => _birthTime = value,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter birth time';
                  final regex = RegExp(r'^\d{2}:\d{2}$');
                  if (!regex.hasMatch(value)) return 'Invalid time format';
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Birth Place'),
                onChanged: (value) => _birthPlace = value,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter birth place';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: reportState.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          final birthInfo = BirthInfo(
                            birthDate: _birthDate!,
                            birthTime: _birthTime,
                            birthPlace: _birthPlace,
                          );
                          await ref.read(reportProvider.notifier).generateReport(birthInfo);
                          if (mounted) {
                            Navigator.pushNamed(context, '/report');
                          }
                        }
                      },
                child: reportState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Generate Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}