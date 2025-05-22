import 'package:get/get.dart';
import 'index.dart';
import 'input_basic.dart';

abstract class InputRoutes {
  static const input = '/input';
  static const inputBasic = '/input/basic';
}

final inputRoutesPages = [
  GetPage(
    name: InputRoutes.input,
    page: () => const InputPreview(),
  ),
  GetPage(
    name: InputRoutes.inputBasic,
    page: () => const InputBasicView(),
  ),
];
