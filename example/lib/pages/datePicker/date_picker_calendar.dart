import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DatePickerCalendarPreview extends StatelessWidget {
  const DatePickerCalendarPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('datePicker', 'date_picker_calendar.dart'),
      title: '日历组件',
    );
  }
}

class DatePickerCalendarView extends StatelessWidget {
  const DatePickerCalendarView({super.key});

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
          Calendar(
            initialDate: '2025-01-01',
            type: CalendarType.date,
            onSelect: (date) {
              debugPrint('onSelect 触发： Selected date: $date');
            },
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Calendar(
            initialDate: '2025-01-01',
            type: CalendarType.dates,
            onSelect: (date) {
              debugPrint('onSelect 触发： Selected date: $date');
            },
          ),
        ],
      ),
    ],
  );
}
