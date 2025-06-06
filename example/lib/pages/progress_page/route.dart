import 'package:get/get.dart';
import 'index.dart';
import 'progress_basic.dart';
import 'progress_text_inside.dart';
import 'progress_custom_color.dart';
import 'progress_circle.dart';
import 'progress_animated.dart';
import 'progress_striped.dart';

abstract class ProgressRoutes {
  static const progress = '/progress';
  static const progressBasic = '/progress/basic';
  static const progressTextInside = '/progress/text_inside';
  static const progressCustomColor = '/progress/custom_color';
  static const progressCircle = '/progress/circle';
  static const progressAnimated = '/progress/animated';
  static const progressStriped = '/progress/striped';
}

final progressRoutesPages = [
  GetPage(
    name: ProgressRoutes.progress,
    page: () => const ProgressPreview(),
  ),
  GetPage(
    name: ProgressRoutes.progressBasic,
    page: () => const ProgressBasicView(),
  ),
  GetPage(
    name: ProgressRoutes.progressTextInside,
    page: () => const ProgressTextInsideView(),
  ),
  GetPage(
    name: ProgressRoutes.progressCustomColor,
    page: () => const ProgressCustomColorView(),
  ),
  GetPage(
    name: ProgressRoutes.progressCircle,
    page: () => const ProgressCircleView(),
  ),
  GetPage(
    name: ProgressRoutes.progressAnimated,
    page: () => const ProgressAnimatedView(),
  ),
  GetPage(
    name: ProgressRoutes.progressStriped,
    page: () => const ProgressStripedView(),
  ),
];
