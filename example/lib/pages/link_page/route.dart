import 'package:get/get.dart';
import 'index.dart';
import 'link_basic.dart';
import 'link_disabled.dart';
import 'link_icon.dart';
import 'link_underline.dart';
import 'link_href.dart';

abstract class LinkRoutes {
  static const link = '/link';
  static const linkBasic = '/link/basic';
  static const linkDisabled = '/link/disabled';
  static const linkIcon = '/link/icon';
  static const linkUnderline = '/link/underline';
  static const linkHref = '/link/href';
  static const linkApi = '/link/api';
}

final linkRoutesPages = [
  GetPage(
    name: LinkRoutes.link,
    page: () => const LinkPreview(),
  ),
  GetPage(
    name: LinkRoutes.linkBasic,
    page: () => const LinkBasicView(),
  ),
  GetPage(
    name: LinkRoutes.linkDisabled,
    page: () => const LinkDisabledView(),
  ),
  GetPage(
    name: LinkRoutes.linkIcon,
    page: () => const LinkIconView(),
  ),
  GetPage(
    name: LinkRoutes.linkUnderline,
    page: () => const LinkUnderlineView(),
  ),
  GetPage(
    name: LinkRoutes.linkHref,
    page: () => const LinkHrefView(),
  ),
];
