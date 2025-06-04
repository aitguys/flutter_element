import 'package:get/get.dart';
import 'index.dart';
import 'checkbox_basic.dart';
import 'checkbox_theme.dart';
import 'checkbox_size.dart';
import 'checkbox_disable.dart';
import 'checkbox_group.dart';
import 'checkbox_border.dart';
import 'checkbox_select_all.dart';

abstract class CheckboxRoutes {
  static const checkbox = '/checkbox';
  static const checkboxBasic = '/checkbox/basic';
  static const checkboxTheme = '/checkbox/theme';
  static const checkboxSize = '/checkbox/size';
  static const checkboxDisable = '/checkbox/disable';
  static const checkboxGroup = '/checkbox/group';
  static const checkboxBorder = '/checkbox/border';
  static const checkboxSelectAll = '/checkbox/select-all';
}

final checkboxRoutesPages = [
  GetPage(
    name: CheckboxRoutes.checkbox,
    page: () => const CheckboxPreview(),
  ),
  GetPage(
    name: CheckboxRoutes.checkboxBasic,
    page: () => const CheckboxBasicView(),
  ),
  GetPage(
    name: CheckboxRoutes.checkboxTheme,
    page: () => const CheckboxThemeView(),
  ),
  GetPage(
    name: CheckboxRoutes.checkboxSize,
    page: () => const CheckboxSizeView(),
  ),
  GetPage(
    name: CheckboxRoutes.checkboxDisable,
    page: () => const CheckboxDisableView(),
  ),
  GetPage(
    name: CheckboxRoutes.checkboxGroup,
    page: () => const CheckboxGroupView(),
  ),
  GetPage(
    name: CheckboxRoutes.checkboxBorder,
    page: () => const CheckboxBorderView(),
  ),
  GetPage(
    name: CheckboxRoutes.checkboxSelectAll,
    page: () => const CheckboxSelectAllView(),
  ),
];
