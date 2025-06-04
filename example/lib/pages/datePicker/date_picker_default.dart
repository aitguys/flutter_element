import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DatePickerDefaultPreview extends StatelessWidget {
  const DatePickerDefaultPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('datePicker', 'date_picker_default.dart'),
      title: '默认值设置',
    );
  }
}

class DatePickerDefaultView extends StatelessWidget {
  const DatePickerDefaultView({super.key});

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
  return Wrap(
    spacing: 20,
    runSpacing: 20,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 240,
            child: EDatePicker(
              type: CalendarType.date,
              value: '2025-01-01',
              placeholder: '单个日期默认值',
              onSelect: (date) {
                debugPrint('onSelect 触发： Selected date: $date');
              },
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 240,
            child: EDatePicker(
              type: CalendarType.dates,
              value: '2025-01-01,2025-01-02',
              placeholder: '多个日期默认值',
              onSelect: (dates) {
                debugPrint('onSelect 触发： Selected dates: $dates');
              },
            ),
          ),
        ],
      ),
    ],
  );
}
