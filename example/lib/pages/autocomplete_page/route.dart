import 'package:get/get.dart';
import 'index.dart';
import 'autocomplete_basic.dart';
import 'autocomplete_color.dart';
import 'autocomplete_fix.dart';
import 'autocomplete_clearable.dart';
import 'autocomplete_disable.dart';
import 'autocomplete_default_color.dart';
import 'autocomplete_show_placeholder.dart';
import 'autocomplete_api.dart';

abstract class AutocompleteRoutes {
  static const autocomplete = '/autocomplete';
  static const inputBasic = '/input/basic';
  static const inputColor = '/input/color';
  static const inputFix = '/input/fix';
  static const inputClearable = '/input/clearable';
  static const inputDisable = '/input/disable';
  static const inputDefaultColor = '/input/defaultColor';
  static const inputShowPlaceholder = '/input/showPlaceholder';
  static const inputApi = '/input/api';
}

final autocompleteRoutesPages = [
  GetPage(
    name: AutocompleteRoutes.autocomplete,
    page: () => const AutocompletePreview(),
  ),
  GetPage(
    name: AutocompleteRoutes.inputBasic,
    page: () => const AutocompleteBasicView(),
  ),
  GetPage(
    name: AutocompleteRoutes.inputColor,
    page: () => const AutocompleteColorView(),
  ),
  GetPage(
    name: AutocompleteRoutes.inputFix,
    page: () => const AutocompleteFixView(),
  ),
  GetPage(
    name: AutocompleteRoutes.inputClearable,
    page: () => const AutocompleteClearableView(),
  ),
  GetPage(
    name: AutocompleteRoutes.inputDisable,
    page: () => const AutocompleteDisableView(),
  ),
  GetPage(
    name: AutocompleteRoutes.inputDefaultColor,
    page: () => const AutocompleteDefaultColorView(),
  ),
  GetPage(
    name: AutocompleteRoutes.inputShowPlaceholder,
    page: () => const AutocompleteShowPlaceholderView(),
  ),
  GetPage(
    name: AutocompleteRoutes.inputApi,
    page: () => const AutocompleteApiView(),
  ),
];
