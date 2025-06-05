import 'package:get/get.dart';
import 'index.dart';
import 'color_picker_alpha.dart';
import 'color_picker_predefine.dart';
import 'color_picker_size.dart';
import 'color_picker_disabled.dart';

abstract class ColorPickerRoutes {
  static const colorPicker = '/color_picker';
  static const colorPickerAlpha = '/color_picker/alpha';
  static const colorPickerPredefine = '/color_picker/predefine';
  static const colorPickerSize = '/color_picker/size';
  static const colorPickerDisabled = '/color_picker/disabled';
}

final colorPickerRoutesPages = [
  GetPage(
    name: ColorPickerRoutes.colorPicker,
    page: () => const ColorPickerPreview(),
  ),
  GetPage(
    name: ColorPickerRoutes.colorPickerAlpha,
    page: () => const ColorPickerAlphaView(),
  ),
  GetPage(
    name: ColorPickerRoutes.colorPickerPredefine,
    page: () => const ColorPickerPredefineView(),
  ),
  GetPage(
    name: ColorPickerRoutes.colorPickerSize,
    page: () => const ColorPickerSizeView(),
  ),
  GetPage(
    name: ColorPickerRoutes.colorPickerDisabled,
    page: () => const ColorPickerDisabledView(),
  ),
];
