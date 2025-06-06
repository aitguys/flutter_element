import 'package:get/get.dart';
import 'index.dart';
import 'avatar_basic.dart';
import 'avatar_size.dart';
import 'avatar_type.dart';
import 'avatar_fallback.dart';
import 'avatar_fit.dart';

abstract class AvatarRoutes {
  static const avatar = '/avatar';
  static const avatarBasic = '/avatar/basic';
  static const avatarSize = '/avatar/size';
  static const avatarType = '/avatar/type';
  static const avatarFallback = '/avatar/fallback';
  static const avatarFit = '/avatar/fit';
  static const avatarApi = '/avatar/api';
}

final avatarRoutesPages = [
  GetPage(
    name: AvatarRoutes.avatar,
    page: () => const AvatarPreview(),
  ),
  GetPage(
    name: AvatarRoutes.avatarBasic,
    page: () => const AvatarBasicView(),
  ),
  GetPage(
    name: AvatarRoutes.avatarSize,
    page: () => const AvatarSizeView(),
  ),
  GetPage(
    name: AvatarRoutes.avatarType,
    page: () => const AvatarTypeView(),
  ),
  GetPage(
    name: AvatarRoutes.avatarFallback,
    page: () => const AvatarFallbackView(),
  ),
  GetPage(
    name: AvatarRoutes.avatarFit,
    page: () => const AvatarFitView(),
  ),
];
