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
  static const autocompleteBasic = '/autocomplete/basic';
  static const autocompleteColor = '/autocomplete/color';
  static const autocompleteFix = '/autocomplete/fix';
  static const autocompleteClearable = '/autocomplete/clearable';
  static const autocompleteDisable = '/autocomplete/disable';
  static const autocompleteDefaultColor = '/autocomplete/defaultColor';
  static const autocompleteShowPlaceholder = '/autocomplete/showPlaceholder';
  static const autocompleteApi = '/autocomplete/api';
}

final autocompleteRoutesPages = [
  GetPage(
    name: AutocompleteRoutes.autocomplete,
    page: () => const AutocompletePreview(),
  ),
  GetPage(
    name: AutocompleteRoutes.autocompleteBasic,
    page: () => const AutocompleteBasicView(),
  ),
  GetPage(
    name: AutocompleteRoutes.autocompleteColor,
    page: () => const AutocompleteColorView(),
  ),
  GetPage(
    name: AutocompleteRoutes.autocompleteFix,
    page: () => const AutocompleteFixView(),
  ),
  GetPage(
    name: AutocompleteRoutes.autocompleteClearable,
    page: () => const AutocompleteClearableView(),
  ),
  GetPage(
    name: AutocompleteRoutes.autocompleteDisable,
    page: () => const AutocompleteDisableView(),
  ),
  GetPage(
    name: AutocompleteRoutes.autocompleteDefaultColor,
    page: () => const AutocompleteDefaultColorView(),
  ),
  GetPage(
    name: AutocompleteRoutes.autocompleteShowPlaceholder,
    page: () => const AutocompleteShowPlaceholderView(),
  ),
  GetPage(
    name: AutocompleteRoutes.autocompleteApi,
    page: () => const AutocompleteApiView(),
  ),
];
