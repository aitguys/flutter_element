import 'package:get/get.dart';
import 'index.dart';
import 'tag_basic.dart';
import 'tag_removable.dart';
import 'tag_size.dart';
import 'tag_theme.dart';
import 'tag_custom_color.dart';
import 'tag_icon.dart';
import 'tag_custom_content.dart';
import 'tag_api.dart';

abstract class TagRoutes {
  static const tag = '/tag';
  static const tagBasic = '/tag/basic';
  static const tagRemovable = '/tag/removable';
  static const tagSize = '/tag/size';
  static const tagTheme = '/tag/theme';
  static const tagCustomColor = '/tag/custom-color';
  static const tagIcon = '/tag/icon';
  static const tagCustomContent = '/tag/custom-content';
  static const tagApi = '/tag/api';
}

final tagRoutesPages = [
  GetPage(
    name: TagRoutes.tag,
    page: () => const TagPreview(),
  ),
  GetPage(
    name: TagRoutes.tagBasic,
    page: () => const TagBasicView(),
  ),
  GetPage(
    name: TagRoutes.tagRemovable,
    page: () => const TagRemovableView(),
  ),
  GetPage(
    name: TagRoutes.tagSize,
    page: () => const TagSizeView(),
  ),
  GetPage(
    name: TagRoutes.tagTheme,
    page: () => const TagThemeView(),
  ),
  GetPage(
    name: TagRoutes.tagCustomColor,
    page: () => const TagCustomColorView(),
  ),
  GetPage(
    name: TagRoutes.tagIcon,
    page: () => const TagIconView(),
  ),
  GetPage(
    name: TagRoutes.tagCustomContent,
    page: () => const TagCustomContentView(),
  ),
  GetPage(
    name: TagRoutes.tagApi,
    page: () => const TagApiPreview(),
  ),
];
