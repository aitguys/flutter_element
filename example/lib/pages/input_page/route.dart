import 'package:flutter_element_example/pages/input_page/input_password.dart';
import 'package:get/get.dart';
import 'index.dart';
import 'input_basic.dart';
import 'input_color.dart';
import 'input_fix.dart';
import 'input_clearable.dart';
import 'input_disable.dart';
import 'input_default_color.dart';
import 'input_show_placeholder.dart';
import 'input_api.dart';

abstract class InputRoutes {
  static const input = '/input';
  static const inputBasic = '/input/basic';
  static const inputColor = '/input/color';
  static const inputFix = '/input/fix';
  static const inputClearable = '/input/clearable';
  static const inputDisable = '/input/disable';
  static const inputDefaultColor = '/input/defaultColor';
  static const inputShowPlaceholder = '/input/showPlaceholder';
  static const inputApi = '/input/api';
  static const inputPassword = '/input/password';
}

final inputRoutesPages = [
  GetPage(
    name: InputRoutes.input,
    page: () => const InputPreview(),
  ),
  GetPage(
    name: InputRoutes.inputBasic,
    page: () => const InputBasicView(),
  ),
  GetPage(
    name: InputRoutes.inputColor,
    page: () => const InputColorView(),
  ),
  GetPage(
    name: InputRoutes.inputFix,
    page: () => const InputFixView(),
  ),
  GetPage(
    name: InputRoutes.inputClearable,
    page: () => const InputClearableView(),
  ),
  GetPage(
    name: InputRoutes.inputDisable,
    page: () => const InputDisableView(),
  ),
  GetPage(
    name: InputRoutes.inputDefaultColor,
    page: () => const InputDefaultColorView(),
  ),
  GetPage(
    name: InputRoutes.inputShowPlaceholder,
    page: () => const InputShowPlaceholderView(),
  ),
  GetPage(
    name: InputRoutes.inputApi,
    page: () => const InputApiView(),
  ),
    GetPage(
    name: InputRoutes.inputPassword,
    page: () => const InputPasswordView(),
  ),
];
