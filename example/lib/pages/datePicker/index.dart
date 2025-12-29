import 'package:flutter/material.dart';
import 'date_picker_basic.dart';
// import 'date_picker_multiple.dart';
// import 'date_picker_default.dart';
// import 'date_picker_style.dart';
// import 'date_picker_format.dart';
// import 'date_picker_calendar.dart';
// import 'date_picker_api.dart';

class DatePickerPreview extends StatelessWidget {
  const DatePickerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                title: const Text('日期选择器'),
              ),
              const DatePickerBasicPreview(),
              // DatePickerMultiplePreview(),
              // DatePickerDefaultPreview(),
              // DatePickerStylePreview(),
              // DatePickerFormatPreview(),
              // DatePickerCalendarPreview(),
              // DatePickerApiPreview(),
            ],
          ),
        ),
      ),
    );
  }
}
