import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class DatePickerPage extends StatelessWidget {
  const DatePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Picker Examples'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础日期选择 large',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            EDatePicker(
              size: ESizeItem.large,
              type: DatePickerType.date,
              value: DateTime.now(),
              onChange: (date) {
                print('Selected date: $date');
              },
            ),
            const Text('基础日期选择 medium',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            EDatePicker(
              size: ESizeItem.medium,
              type: DatePickerType.date,
              value: DateTime.now(),
              onChange: (date) {
                print('Selected date: $date');
              },
            ),
            const Text('基础日期选择 small',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            EDatePicker(
              size: ESizeItem.small,
              type: DatePickerType.date,
              value: DateTime.now(),
              onChange: (date) {
                print('Selected date: $date');
              },
            ),
            const Text('基础日期(s)选择 small',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            EDatePicker(
              size: ESizeItem.small,
              type: DatePickerType.dates,
              value: DateTime.now(),
              onChange: (date) {
                print('Selected date: $date');
              },
            ),
            const Text('基础年选择 small',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            EDatePicker(
              size: ESizeItem.small,
              type: DatePickerType.year,
              value: DateTime.now(),
              onChange: (date) {
                print('Selected date: $date');
              },
            ),
            const Text('基础年(s)选择 small',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            EDatePicker(
              size: ESizeItem.small,
              type: DatePickerType.years,
              value: DateTime.now(),
              onChange: (date) {
                print('Selected date: $date');
              },
            ),
            const Text('基础月份选择 small',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            EDatePicker(
              size: ESizeItem.small,
              type: DatePickerType.month,
              value: DateTime.now(),
              onChange: (date) {
                print('Selected date: $date');
              },
            ),
            const Text('基础月份s选择 small',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            EDatePicker(
              size: ESizeItem.small,
              type: DatePickerType.months,
              value: DateTime.now(),
              onChange: (date) {
                print('Selected date: $date');
              },
            ),
            const Text('显示times small',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            EDatePicker(
              size: ESizeItem.small,
              type: DatePickerType.date,
              showtimeSelect: true,
              value: DateTime.now(),
              onChange: (date) {
                print('Selected date: $date');
              },
            ),
            // EDatePicker(
            //   size: ESizeItem.small,
            //   value: DateTime.now(),
            //   onChange: (date) {
            //     print('Selected date: $date');
            //   },
            // ),
            // EDatePicker(
            //   size: ESizeItem.small,
            //   value: DateTime.now(),
            //   onChange: (date) {
            //     print('Selected date: $date');
            //   },
            // ),
            // EDatePicker(
            //   size: ESizeItem.small,
            //   value: DateTime.now(),
            //   onChange: (date) {
            //     print('Selected date: $date');
            //   },
            // ),
            // EDatePicker(
            //   size: ESizeItem.small,
            //   value: DateTime.now(),
            //   onChange: (date) {
            //     print('Selected date: $date');
            //   },
            // ),
            // EDatePicker(
            //   size: ESizeItem.small,
            //   value: DateTime.now(),
            //   onChange: (date) {
            //     print('Selected date: $date');
            //   },
            // ),
            // EDatePicker(
            //   size: ESizeItem.small,
            //   value: DateTime.now(),
            //   onChange: (date) {
            //     print('Selected date: $date');
            //   },
            // ),
            // const SizedBox(height: 16),
            // EDatePicker(
            //   size: ESizeItem.medium,
            //   onChange: (date) {
            //     print('Selected date: $date');
            //   },
            // ),
            // const SizedBox(height: 16),
            // EDatePicker(
            //   size: ESizeItem.large,
            //   value: DateTime.now(),
            //   onChange: (date) {
            //     print('Selected date: $date');
            //   },
            // ),
            // const SizedBox(height: 32),
            // const Text('Date Range Picker',
            //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // const SizedBox(height: 16),
            // EDatePicker(
            //   range: true,
            //   rangeValue: [
            //     DateTime.now(),
            //     DateTime.now().add(const Duration(days: 7))
            //   ],
            //   onRangeChange: (range) {
            //     print('Selected range: $range');
            //   },
            // ),
            // const SizedBox(height: 32),
            // const Text('Disabled Date Picker',
            //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // const SizedBox(height: 16),
            // const EDatePicker(
            //   disabled: true,
            //   value: null,
            // ),
          ],
        ),
      ),
    );
  }
}
