import 'package:get/get.dart';
import 'index.dart';
import 'radio_basic.dart';
import 'radio_disable.dart';
import 'radio_group.dart';
import 'radio_size.dart';
import 'radio_border.dart';
import 'radio_api.dart';

abstract class RadioRoutes {
  static const radio = '/radio';
  static const radioBasic = '/radio/basic';
  static const radioDisable = '/radio/disable';
  static const radioGroup = '/radio/group';
  static const radioSize = '/radio/size';
  static const radioBorder = '/radio/border';
  static const radioApi = '/radio/api';
}

final radioRoutesPages = [
  GetPage(
    name: RadioRoutes.radio,
    page: () => const RadioPreview(),
  ),
  GetPage(
    name: RadioRoutes.radioBasic,
    page: () => const RadioBasicView(),
  ),
  GetPage(
    name: RadioRoutes.radioDisable,
    page: () => const RadioDisableView(),
  ),
  GetPage(
    name: RadioRoutes.radioGroup,
    page: () => const RadioGroupView(),
  ),
  GetPage(
    name: RadioRoutes.radioSize,
    page: () => const RadioSizeView(),
  ),
  GetPage(
    name: RadioRoutes.radioBorder,
    page: () => const RadioBorderView(),
  ),
  GetPage(
    name: RadioRoutes.radioApi,
    page: () => const RadioApiView(),
  ),
];
