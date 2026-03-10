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
          const Text(
            '日期范围选择 (daterange)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF606266),
            ),
          ),
          const SizedBox(height: 8),
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '日期选择 + 范围限制',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF606266),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 240,
            child: EDatePicker(
              type: DatePickerType.date,
              minDate: DateTime(2025, 1, 1),
              maxDate: DateTime(2025, 12, 31),
              placeholder: '限制在 2025 年内',
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
          const Text(
            '月份选择 + 范围限制',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF606266),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 240,
            child: EDatePicker(
              type: DatePickerType.month,
              minDate: DateTime(2025, 1, 1),
              maxDate: DateTime(2025, 12, 31),
              placeholder: '限制在 2025 年',
              onSelect: (date) {
                debugPrint('onSelect 触发： Selected month: $date');
              },
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '年份选择 + 范围限制',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF606266),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 240,
            child: EDatePicker(
              type: DatePickerType.year,
              minDate: DateTime(2020, 1, 1),
              maxDate: DateTime(2030, 12, 31),
              placeholder: '2020–2030 年',
              onSelect: (date) {
                debugPrint('onSelect 触发： Selected year: $date');
              },
            ),
          ),
        ],
      ),
    ],
  );
}
