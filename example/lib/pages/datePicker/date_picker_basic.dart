import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          const Text(
            '日期选择 (date)',
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
              textController: TextEditingController(
                  text: DateFormat('MM/dd/yyyy').format(DateTime.now())),
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
          const Text(
            '月份选择 (month)',
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
              placeholder: '选择月份',
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
            '年份选择 (year)',
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
              placeholder: '选择年份',
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
