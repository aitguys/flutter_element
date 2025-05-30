import 'package:get/get.dart';
import 'index.dart';
import 'date_picker_basic.dart';
import 'date_picker_size.dart';
import 'date_picker_format.dart';
import 'date_picker_disabled.dart';
import 'date_picker_api.dart';

abstract class DatePickerRoutes {
  static const datePicker = '/datePicker';
  static const datePickerBasic = '/datePicker/basic';
  static const datePickerRange = '/datePicker/range';
  static const datePickerDatetime = '/datePicker/datetime';
  static const datePickerSize = '/datePicker/size';
  static const datePickerFormat = '/datePicker/format';
  static const datePickerDisabled = '/datePicker/disabled';
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
    name: DatePickerRoutes.datePickerSize,
    page: () => const DatePickerSizeView(),
  ),
  GetPage(
    name: DatePickerRoutes.datePickerFormat,
    page: () => const DatePickerFormatView(),
  ),
  GetPage(
    name: DatePickerRoutes.datePickerDisabled,
    page: () => const DatePickerDisabledView(),
  ),
  GetPage(
    name: DatePickerRoutes.datePickerApi,
    page: () => const DatePickerApiView(),
  ),
]; 