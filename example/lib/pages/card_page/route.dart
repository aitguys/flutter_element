import 'package:get/get.dart';
import 'index.dart';
import 'card_basic.dart';
import 'card_simple.dart';
import 'card_image.dart';
import 'card_shadow.dart';

abstract class CardRoutes {
  static const card = '/card';
  static const cardBasic = '/card/basic';
  static const cardSimple = '/card/simple';
  static const cardImage = '/card/image';
  static const cardShadow = '/card/shadow';
}

final cardRoutesPages = [
  GetPage(
    name: CardRoutes.card,
    page: () => const CardPreview(),
  ),
  GetPage(
    name: CardRoutes.cardBasic,
    page: () => const CardBasicView(),
  ),
  GetPage(
    name: CardRoutes.cardSimple,
    page: () => const CardSimpleView(),
  ),
  GetPage(
    name: CardRoutes.cardImage,
    page: () => const CardImageView(),
  ),
  GetPage(
    name: CardRoutes.cardShadow,
    page: () => const CardShadowView(),
  ),
];
