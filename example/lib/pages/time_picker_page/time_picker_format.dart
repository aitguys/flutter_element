import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class TimePickerFormatPreview extends StatelessWidget {
  const TimePickerFormatPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('time_picker_page', 'time_picker_format.dart'),
      title: '24小时制',
    );
  }
}

class TimePickerFormatView extends StatelessWidget {
  const TimePickerFormatView({super.key});

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
        const Text('24小时制'),
        const SizedBox(height: 16),
        const ETimePicker(
          use24HourFormat: false,
        ),
      ],
    ),
  );
}
