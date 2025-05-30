import 'package:flutter/material.dart';
import 'date_picker_basic.dart';
import 'date_picker_size.dart';
import 'date_picker_format.dart';
import 'date_picker_disabled.dart';
// import 'date_picker_api.dart';

class DatePickerPreview extends StatelessWidget {
  const DatePickerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('日期选择器组件'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            DatePickerBasicPreview(),
            DatePickerSizePreview(),
            DatePickerFormatPreview(),
            DatePickerDisabledPreview(),
            // DatePickerApiPreview(),
          ],
        ),
      ),
    );
  }
} 