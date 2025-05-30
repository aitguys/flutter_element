import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DatePickerDisabledPreview extends StatelessWidget {
  const DatePickerDisabledPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('datePicker', 'date_picker_disabled.dart'),
      title: '禁用状态',
    );
  }
}

class DatePickerDisabledView extends StatelessWidget {
  const DatePickerDisabledView({super.key});

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
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('禁用状态',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 16),
      Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('禁用日期选择',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              SizedBox(height: 8),
              SizedBox(
                width: 240,
                child: EDatePicker(
                  type: DatePickerType.date,
                  disabled: true,
                  placeholder: '选择日期',
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('禁用日期范围选择',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              SizedBox(height: 8),
              SizedBox(
                width: 360,
                child: EDatePicker(
                  type: DatePickerType.daterange,
                  disabled: true,
                  placeholder: '选择日期范围',
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('禁用日期时间选择',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              SizedBox(height: 8),
              SizedBox(
                width: 240,
                child: EDatePicker(
                  type: DatePickerType.datetime,
                  disabled: true,
                  placeholder: '选择日期时间',
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
} 