import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DatePickerMultiplePreview extends StatelessWidget {
  const DatePickerMultiplePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('datePicker', 'date_picker_multiple.dart'),
      title: '多选用法',
    );
  }
}

class DatePickerMultipleView extends StatelessWidget {
  const DatePickerMultipleView({super.key});

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
              placeholder: '选择多个日期',
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
              placeholder: '选择多个月份',
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
              placeholder: '选择多个年份',
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
