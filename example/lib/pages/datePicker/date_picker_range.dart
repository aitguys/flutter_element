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
              type: DatePickerType.dates,
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
              type: DatePickerType.months,
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
              type: DatePickerType.years,
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('日期范围选择'),
          SizedBox(
            width: 320,
            child: EDatePicker(
              type: DatePickerType.daterange,
              placeholder: '选择日期范围',
              onValueChange: (value) {
                debugPrint('onValueChange 触发： $value');
              },
            ),
          ),
        ],
      ),
    ],
  );
}
