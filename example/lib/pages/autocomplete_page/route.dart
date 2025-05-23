import 'package:get/get.dart';
import 'index.dart';
import 'autocomplete_basic.dart';

abstract class AutoCompleteRoutes {
  static const autoComplete = '/autoComplete';
  static const autoCompleteBasic = '/autoComplete/basic';
}

final autoCompleteRoutesPages = [
  GetPage(
    name: AutoCompleteRoutes.autoComplete,
    page: () => const AutoCompletePreview(),
  ),
  GetPage(
    name: AutoCompleteRoutes.autoCompleteBasic,
    page: () => const AutoCompleteBasicView(),
  ),
];
