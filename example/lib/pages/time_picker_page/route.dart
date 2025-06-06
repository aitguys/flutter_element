import 'package:get/get.dart';
import 'index.dart';
import 'time_picker_basic.dart';
import 'time_picker_format.dart';
import 'time_picker_readonly.dart';

abstract class TimePickerRoutes {
  static const timePicker = '/time_picker';
  static const timePickerBasic = '/time_picker/basic';
  static const timePickerFormat = '/time_picker/format';
  static const timePickerReadonly = '/time_picker/readonly';
  static const timePickerApi = '/time_picker/api';
}

final timePickerRoutesPages = [
  GetPage(
    name: TimePickerRoutes.timePicker,
    page: () => const TimePickerPreview(),
  ),
  GetPage(
    name: TimePickerRoutes.timePickerBasic,
    page: () => const TimePickerBasicView(),
  ),
  GetPage(
    name: TimePickerRoutes.timePickerFormat,
    page: () => const TimePickerFormatView(),
  ),
  GetPage(
    name: TimePickerRoutes.timePickerReadonly,
    page: () => const TimePickerReadonlyView(),
  ),
];
