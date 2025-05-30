import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DatePickerSizePreview extends StatelessWidget {
  const DatePickerSizePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('datePicker', 'date_picker_size.dart'),
      title: '不同尺寸',
    );
  }
}

class DatePickerSizeView extends StatelessWidget {
  const DatePickerSizeView({super.key});

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
      const Text('不同尺寸',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('小型日期选择器',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 8),
              SizedBox(
                width: 240,
                child: EDatePicker(
                  size: ESizeItem.small,
                  type: DatePickerType.date,
                  placeholder: '小型日期选择器',
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
              const Text('中型日期选择器',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 8),
              SizedBox(
                width: 240,
                child: EDatePicker(
                  size: ESizeItem.medium,
                  type: DatePickerType.date,
                  placeholder: '中型日期选择器',
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
              const Text('大型日期选择器',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 8),
              SizedBox(
                width: 240,
                child: EDatePicker(
                  size: ESizeItem.large,
                  type: DatePickerType.date,
                  placeholder: '大型日期选择器',
                  onChange: (date) {
                    debugPrint('Selected date: $date');
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