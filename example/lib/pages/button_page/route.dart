import 'package:get/get.dart';
import 'index.dart';
import 'button_basic.dart';
import 'button_disable.dart';
import 'button_link.dart';
import 'button_badge.dart';
import 'button_custom_children.dart';
import 'button_custom_color.dart';
import 'button_icon.dart';
import 'button_loading.dart';
import 'button_size.dart';

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
}

final buttonRoutesPages = [
  GetPage(
    name: ButtonRoutes.button,
    page: () => const ButtonPreview(),
  ),
  GetPage(
    name: ButtonRoutes.buttonBasic,
    page: () => const ButtonBasicPreview(),
  ),
  GetPage(
    name: ButtonRoutes.buttonDisable,
    page: () => const ButtonDisablePreview(),
  ),
  GetPage(
    name: ButtonRoutes.buttonLink,
    page: () => const ButtonLinkPreview(),
  ),
  GetPage(
    name: ButtonRoutes.buttonIcon,
    page: () => const ButtonIconPreview(),
  ),
  GetPage(
    name: ButtonRoutes.buttonCustomColor,
    page: () => const ButtonCustomColorPreview(),
  ),
  GetPage(
    name: ButtonRoutes.buttonCustomChildren,
    page: () => const ButtonCustomChildrenPreview(),
  ),
  GetPage(
    name: ButtonRoutes.buttonLoading,
    page: () => const button_loading_preview(),
  ),
  GetPage(
    name: ButtonRoutes.buttonBadge,
    page: () => const button_badge_preview(),
  ),
  GetPage(
    name: ButtonRoutes.buttonSize,
    page: () => const ButtonSizePage(),
  ),
];
