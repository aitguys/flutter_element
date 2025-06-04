import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DatePickerBasicPreview extends StatelessWidget {
  const DatePickerBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('datePicker', 'date_picker_basic.dart'),
      title: '基础用法',
    );
  }
}

class DatePickerBasicView extends StatelessWidget {
  const DatePickerBasicView({super.key});

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
              placeholder: '选择日期',
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
              type: CalendarType.month,
              placeholder: '选择月份',
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
              type: CalendarType.year,
              placeholder: '选择年份',
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
              type: CalendarType.date,
              placeholder: '周视图选择',
              weekDate: true,
              onSelect: (date) {
                debugPrint('onSelect 触发： Selected date: $date');
              },
            ),
          ),
        ],
      ),
    ],
  );
}
