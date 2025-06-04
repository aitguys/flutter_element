import 'package:get/get.dart';
import 'index.dart';
import 'date_picker_basic.dart';
import 'date_picker_multiple.dart';
import 'date_picker_range.dart';
import 'date_picker_default.dart';
import 'date_picker_style.dart';
import 'date_picker_format.dart';
import 'date_picker_calendar.dart';
import 'date_picker_api.dart';

abstract class DatePickerRoutes {
  static const datePicker = '/datePicker';
  static const datePickerBasic = '/datePicker/basic';
  static const datePickerMultiple = '/datePicker/multiple';
  static const datePickerRange = '/datePicker/range';
  static const datePickerDefault = '/datePicker/default';
  static const datePickerStyle = '/datePicker/style';
  static const datePickerFormat = '/datePicker/format';
  static const datePickerCalendar = '/datePicker/calendar';
  static const datePickerApi = '/datePicker/api';
}

final datePickerRoutesPages = [
  GetPage(
    name: DatePickerRoutes.datePicker,
    page: () => const DatePickerPreview(),
  ),
  GetPage(
    name: DatePickerRoutes.datePickerBasic,
    page: () => const DatePickerBasicView(),
  ),
  GetPage(
    name: DatePickerRoutes.datePickerMultiple,
    page: () => const DatePickerMultipleView(),
  ),
  GetPage(
    name: DatePickerRoutes.datePickerRange,
    page: () => const DatePickerRangeView(),
  ),
  GetPage(
    name: DatePickerRoutes.datePickerDefault,
    page: () => const DatePickerDefaultView(),
  ),
  GetPage(
    name: DatePickerRoutes.datePickerStyle,
    page: () => const DatePickerStyleView(),
  ),
  GetPage(
    name: DatePickerRoutes.datePickerFormat,
    page: () => const DatePickerFormatView(),
  ),
  GetPage(
    name: DatePickerRoutes.datePickerCalendar,
    page: () => const DatePickerCalendarView(),
  ),
  GetPage(
    name: DatePickerRoutes.datePickerApi,
    page: () => const DatePickerApiView(),
  ),
];
