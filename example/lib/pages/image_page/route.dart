import 'package:get/get.dart';
import 'index.dart';
import 'image_basic.dart';
import 'image_fit.dart';
import 'image_radius.dart';
import 'image_placeholder.dart';
import 'image_preview.dart';

abstract class ImageRoutes {
  static const image = '/image';
  static const imageBasic = '/image/basic';
  static const imageFit = '/image/fit';
  static const imageRadius = '/image/radius';
  static const imagePlaceholder = '/image/placeholder';
  static const imagePreview = '/image/preview';
  static const imageApi = '/image/api';
}

final imageRoutesPages = [
  GetPage(
    name: ImageRoutes.image,
    page: () => const ImagePreview(),
  ),
  GetPage(
    name: ImageRoutes.imageBasic,
    page: () => const ImageBasicView(),
  ),
  GetPage(
    name: ImageRoutes.imageFit,
    page: () => const ImageFitView(),
  ),
  GetPage(
    name: ImageRoutes.imageRadius,
    page: () => const ImageRadiusView(),
  ),
  GetPage(
    name: ImageRoutes.imagePlaceholder,
    page: () => const ImagePlaceholderView(),
  ),
  GetPage(
    name: ImageRoutes.imagePreview,
    page: () => const ImagePreviewView(),
  ),
];
