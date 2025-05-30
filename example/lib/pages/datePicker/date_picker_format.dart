import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DatePickerFormatPreview extends StatelessWidget {
  const DatePickerFormatPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('datePicker', 'date_picker_format.dart'),
      title: '自定义格式',
    );
  }
}

class DatePickerFormatView extends StatelessWidget {
  const DatePickerFormatView({super.key});

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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('自定义格式',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('自定义日期格式',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 8),
              SizedBox(
                width: 240,
                child: EDatePicker(
                  type: DatePickerType.date,
                  format: 'yyyy年MM月dd日',
                  placeholder: '选择日期',
                  onChange: (date) {
                    debugPrint('Selected date: $date');
                  },
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('自定义日期时间格式',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 8),
              SizedBox(
                width: 240,
                child: EDatePicker(
                  type: DatePickerType.datetime,
                  format: 'yyyy年MM月dd日 HH:mm:ss',
                  placeholder: '选择日期时间',
                  onChange: (date) {
                    debugPrint('Selected datetime: $date');
                  },
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('自定义日期范围格式',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 8),
              SizedBox(
                width: 360,
                child: EDatePicker(
                  type: DatePickerType.daterange,
                  format: 'yyyy/MM/dd',
                  placeholder: '选择日期范围',
                  onChange: (dates) {
                    if (dates is List<DateTime>) {
                      debugPrint('Selected range: ${dates[0]} to ${dates[1]}');
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
} 