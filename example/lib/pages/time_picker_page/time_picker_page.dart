import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import 'package:logger/logger.dart';

class TimePickerPage extends StatefulWidget {
  const TimePickerPage({super.key});

  @override
  State<TimePickerPage> createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ETimePicker 测试')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('size small'),
            const SizedBox(height: 16),
            ETimePicker(
              value: DateTime(2025, 5, 9, 2, 53, 0),
              onChange: (time) {
                setState(() {
                  _selectedTime = time;
                  Logger().d('time: $_selectedTime');
                });
              },
              placeholder: '请选择时间',
            ),
            const SizedBox(height: 24),
            const Text('size medium'),
            const SizedBox(height: 16),
            ETimePicker(
              size: ESizeItem.medium,
              value: DateTime(2025, 5, 9, 2, 53, 0),
            ),
            const SizedBox(height: 24),
            const Text('size large'),
            const SizedBox(height: 16),
            const ETimePicker(
              size: ESizeItem.large,
            ),
          ],
        ),
      ),
    );
  }
}
