import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DatePickerRangePreview extends StatelessWidget {
  const DatePickerRangePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('datePicker', 'date_picker_range.dart'),
      title: '日期范围限制',
    );
  }
}

class DatePickerRangeView extends StatelessWidget {
  const DatePickerRangeView({super.key});

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
              type: CalendarType.dates,
              minDate: DateTime(2025, 1, 1),
              maxDate: DateTime(2025, 12, 31),
              placeholder: '日期范围限制',
              onSelect: (dates) {
                debugPrint('onSelect 触发： Selected dates: $dates');
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
              type: CalendarType.months,
              minDate: DateTime(2025, 1, 1),
              maxDate: DateTime(2025, 12, 31),
              placeholder: '月份范围限制',
              onSelect: (dates) {
                debugPrint('onSelect 触发： Selected dates: $dates');
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
              type: CalendarType.years,
              minDate: DateTime(2025, 1, 1),
              maxDate: DateTime(2025, 12, 31),
              placeholder: '年份范围限制',
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
