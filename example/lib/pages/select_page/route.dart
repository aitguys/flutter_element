import 'package:get/get.dart';
import 'index.dart';
import 'select_basic.dart';
import 'select_multiple.dart';
import 'select_disable.dart';
import 'select_clearable.dart';
import 'select_prefix_suffix.dart';
import 'select_option_disable.dart';
import 'select_header.dart';
import 'select_api.dart';

abstract class SelectRoutes {
  static const select = '/select';
  static const selectBasic = '/select/basic';
  static const selectMultiple = '/select/multiple';
  static const selectDisable = '/select/disable';
  static const selectClearable = '/select/clearable';
  static const selectPrefixSuffix = '/select/prefix-suffix';
  static const selectOptionDisable = '/select/option-disable';
  static const selectHeader = '/select/header';
  static const selectApi = '/select/api';
}

final selectRoutesPages = [
  GetPage(name: SelectRoutes.select, page: () => const SelectPreview()),
  GetPage(name: SelectRoutes.selectBasic, page: () => const SelectBasicView()),
  GetPage(
      name: SelectRoutes.selectMultiple,
      page: () => const SelectMultipleView()),
  GetPage(
      name: SelectRoutes.selectDisable, page: () => const SelectDisableView()),
  GetPage(
      name: SelectRoutes.selectClearable,
      page: () => const SelectClearableView()),
  GetPage(
      name: SelectRoutes.selectPrefixSuffix,
      page: () => const SelectPrefixSuffixView()),
  GetPage(
      name: SelectRoutes.selectOptionDisable,
      page: () => const SelectOptionDisableView()),
  GetPage(
      name: SelectRoutes.selectHeader, page: () => const SelectHeaderView()),
  GetPage(name: SelectRoutes.selectApi, page: () => const SelectApiView()),
];
