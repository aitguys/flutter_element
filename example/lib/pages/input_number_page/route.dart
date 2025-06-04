import 'package:get/get.dart';
import 'index.dart';
import 'input_number_basic.dart';
import 'input_number_controls.dart';
import 'input_number_clearable.dart';
import 'input_number_prefix_suffix.dart';
import 'input_number_custom_icons.dart';
import 'input_number_disabled.dart';
import 'input_number_size.dart';
import 'input_number_position.dart';
import 'input_number_style.dart';
import 'input_number_api.dart';

abstract class InputNumberRoutes {
  static const inputNumber = '/inputNumber';
  static const inputNumberBasic = '/inputNumber/basic';
  static const inputNumberControls = '/inputNumber/controls';
  static const inputNumberClearable = '/inputNumber/clearable';
  static const inputNumberPrefixSuffix = '/inputNumber/prefix-suffix';
  static const inputNumberCustomIcons = '/inputNumber/custom-icons';
  static const inputNumberDisabled = '/inputNumber/disabled';
  static const inputNumberSize = '/inputNumber/size';
  static const inputNumberPosition = '/inputNumber/position';
  static const inputNumberStyle = '/inputNumber/style';
  static const inputNumberApi = '/inputNumber/api';
}

final inputNumberRoutesPages = [
  GetPage(
    name: InputNumberRoutes.inputNumber,
    page: () => const InputNumberPreview(),
  ),
  GetPage(
    name: InputNumberRoutes.inputNumberBasic,
    page: () => const InputNumberBasicView(),
  ),
  GetPage(
    name: InputNumberRoutes.inputNumberControls,
    page: () => const InputNumberControlsView(),
  ),
  GetPage(
    name: InputNumberRoutes.inputNumberClearable,
    page: () => const InputNumberClearableView(),
  ),
  GetPage(
    name: InputNumberRoutes.inputNumberPrefixSuffix,
    page: () => const InputNumberPrefixSuffixView(),
  ),
  GetPage(
    name: InputNumberRoutes.inputNumberCustomIcons,
    page: () => const InputNumberCustomIconsView(),
  ),
  GetPage(
    name: InputNumberRoutes.inputNumberDisabled,
    page: () => const InputNumberDisabledView(),
  ),
  GetPage(
    name: InputNumberRoutes.inputNumberSize,
    page: () => const InputNumberSizeView(),
  ),
  GetPage(
    name: InputNumberRoutes.inputNumberPosition,
    page: () => const InputNumberPositionView(),
  ),
  GetPage(
    name: InputNumberRoutes.inputNumberStyle,
    page: () => const InputNumberStyleView(),
  ),
  GetPage(
    name: InputNumberRoutes.inputNumberApi,
    page: () => const InputNumberApiView(),
  ),
];
