import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import 'package:logger/logger.dart';
import '../../const/index.dart';

class TimePickerBasicPreview extends StatelessWidget {
  const TimePickerBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('time_picker_page', 'time_picker_basic.dart'),
      title: '基础用法',
    );
  }
}

class TimePickerBasicView extends StatelessWidget {
  const TimePickerBasicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _viewerContent(),
        ),
      ),
    );
  }
}

Widget _viewerContent() {
  return Builder(
    builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('size small'),
        const SizedBox(height: 16),
        ETimePicker(
          value: DateTime(2025, 5, 9, 2, 53, 0),
          onChange: (time) {
            Logger().d('time: $time');
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
  );
}
