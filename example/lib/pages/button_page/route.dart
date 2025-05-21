import 'package:get/get.dart';
import 'index.dart';
import 'button_basic.dart';
import 'button_disable.dart';
import 'button_link.dart';
import 'button_custom_children.dart';
import 'button_custom_color.dart';
import 'button_icon.dart';
import 'button_loading.dart';
import 'button_size.dart';
import 'button_api.dart';

abstract class ButtonRoutes {
  static const button = '/button';
  static const buttonBasic = '/button/basic';
  static const buttonDisable = '/button/disable';
  static const buttonLink = '/button/link';
  static const buttonIcon = '/button/icon';
  static const buttonCustomColor = '/button/custom-color';
  static const buttonCustomChildren = '/button/custom-children';
  static const buttonLoading = '/button/loading';
  static const buttonBadge = '/button/badge';
  static const buttonSize = '/button/size';
  static const buttonApi = '/button/api';
}

final buttonRoutesPages = [
  GetPage(
    name: ButtonRoutes.button,
    page: () => const ButtonPreview(),
  ),
  GetPage(
    name: ButtonRoutes.buttonBasic,
    page: () => const ButtonBasicView(),
  ),
  GetPage(
    name: ButtonRoutes.buttonDisable,
    page: () => const ButtonDisableView(),
  ),
  GetPage(
    name: ButtonRoutes.buttonLink,
    page: () => const ButtonLinkView(),
  ),
  GetPage(
    name: ButtonRoutes.buttonIcon,
    page: () => const ButtonIconView(),
  ),
  GetPage(
    name: ButtonRoutes.buttonCustomColor,
    page: () => const ButtonCustomColorView(),
  ),
  GetPage(
    name: ButtonRoutes.buttonCustomChildren,
    page: () => const ButtonCustomChildrenView(),
  ),
  GetPage(
    name: ButtonRoutes.buttonLoading,
    page: () => const ButtonLoadingView(),
  ),
  GetPage(
    name: ButtonRoutes.buttonSize,
    page: () => const ButtonSizeView(),
  ),
  GetPage(
    name: ButtonRoutes.buttonApi,
    page: () => const ButtonApiView(),
  ),
];
