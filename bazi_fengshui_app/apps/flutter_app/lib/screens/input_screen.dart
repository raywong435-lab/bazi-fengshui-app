import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/charts/application/chart_service_provider.dart';

class InputScreen extends ConsumerStatefulWidget {
  const InputScreen({super.key});

  @override
  ConsumerState<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends ConsumerState<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  DateTime? _birthDate;
  TimeOfDay? _birthTime;
  int _gender = 1; // 1 = male, 2 = female
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('輸入生辰資料'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '姓名',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) return '請輸入姓名';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Birth date field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '出生日期',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
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
                  if (_birthDate == null) return '請選擇出生日期';
                  return null;
                },
                controller: TextEditingController(
                  text: _birthDate?.toString().split(' ')[0] ?? '',
                ),
              ),
              const SizedBox(height: 16),
              
              // Birth time field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '出生時間',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.access_time),
                ),
                readOnly: true,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      _birthTime = time;
                    });
                  }
                },
                validator: (value) {
                  if (_birthTime == null) return '請選擇出生時間';
                  return null;
                },
                controller: TextEditingController(
                  text: _birthTime != null 
                      ? '${_birthTime!.hour.toString().padLeft(2, '0')}:${_birthTime!.minute.toString().padLeft(2, '0')}' 
                      : '',
                ),
              ),
              const SizedBox(height: 16),
              
              // Gender selection
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: '性別',
                  border: OutlineInputBorder(),
                ),
                initialValue: _gender,
                items: const [
                  DropdownMenuItem(value: 1, child: Text('男性')),
                  DropdownMenuItem(value: 2, child: Text('女性')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _gender = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              
              // Submit button
              ElevatedButton(
                onPressed: _isLoading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('生成八字命盤', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Combine date and time
      final birthDateTime = DateTime(
        _birthDate!.year,
        _birthDate!.month,
        _birthDate!.day,
        _birthTime!.hour,
        _birthTime!.minute,
      );

      // Create chart via API
      final chartData = await ref.read(chartServiceProvider.notifier).createChart(
            name: _name,
            birthDateTime: birthDateTime,
            gender: _gender,
            timeZone: 'Asia/Taipei',
          );

      if (!mounted) return;

      // Navigate to report screen (placeholder - actual report generation will be implemented)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('八字命盤生成成功！'),
          backgroundColor: Colors.green,
        ),
      );

      // TODO: Generate report and navigate to report screen
      // For now, just show success
      
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('錯誤: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}