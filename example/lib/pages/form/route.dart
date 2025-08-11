import 'package:get/get.dart';
import 'index.dart';

abstract class FormRoutes {
  static const form = '/form';
}

final formRoutesPages = [
  GetPage(
    name: FormRoutes.form,
    page: () => const FormPreview(),
  ),
];
