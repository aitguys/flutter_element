import 'package:get/get.dart';
import 'index.dart';
import 'rate_basic.dart';
import 'rate_colors.dart';
import 'rate_size.dart';
import 'rate_half.dart';
import 'rate_text.dart';
import 'rate_score.dart';

abstract class RateRoutes {
  static const rate = '/rate';
  static const rateBasic = '/rate/basic';
  static const rateColors = '/rate/colors';
  static const rateSize = '/rate/size';
  static const rateHalf = '/rate/half';
  static const rateText = '/rate/text';
  static const rateScore = '/rate/score';
}

final rateRoutesPages = [
  GetPage(
    name: RateRoutes.rate,
    page: () => const RatePreview(),
  ),
  GetPage(
    name: RateRoutes.rateBasic,
    page: () => const RateBasicView(),
  ),
  GetPage(
    name: RateRoutes.rateColors,
    page: () => const RateColorsView(),
  ),
  GetPage(
    name: RateRoutes.rateSize,
    page: () => const RateSizeView(),
  ),
  GetPage(
    name: RateRoutes.rateHalf,
    page: () => const RateHalfView(),
  ),
  GetPage(
    name: RateRoutes.rateText,
    page: () => const RateTextView(),
  ),
  GetPage(
    name: RateRoutes.rateScore,
    page: () => const RateScoreView(),
  ),
];
