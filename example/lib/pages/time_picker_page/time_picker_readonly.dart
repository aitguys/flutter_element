import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class TimePickerReadonlyPreview extends StatelessWidget {
  const TimePickerReadonlyPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('time_picker_page', 'time_picker_readonly.dart'),
      title: '只读模式',
    );
  }
}

class TimePickerReadonlyView extends StatelessWidget {
  const TimePickerReadonlyView({super.key});

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
    builder: (context) => const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('readOnly'),
        SizedBox(height: 16),
        ETimePicker(
          readOnly: true,
        ),
      ],
    ),
  );
}
