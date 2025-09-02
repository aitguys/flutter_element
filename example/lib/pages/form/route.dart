import 'package:get/get.dart';
import 'index.dart';
import 'form_basic.dart';

abstract class FormRoutes {
  static const form = '/form';
  static const formBasic = '/form/basic';
}

final formRoutesPages = [
  GetPage(
    name: FormRoutes.form,
    page: () => const FormPreview(),
  ),
  GetPage(
    name: FormRoutes.formBasic,
    page: () => const FormBasicView(),
  ),
];
