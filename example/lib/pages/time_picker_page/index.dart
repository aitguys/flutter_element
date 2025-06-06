import 'package:flutter/material.dart';
import 'time_picker_basic.dart';
import 'time_picker_format.dart';
import 'time_picker_readonly.dart';

class TimePickerPreview extends StatelessWidget {
  const TimePickerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TimePickerBasicPreview(),
        TimePickerFormatPreview(),
        TimePickerReadonlyPreview(),
      ],
    );
  }
}
