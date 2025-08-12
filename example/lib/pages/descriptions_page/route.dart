import 'package:get/get.dart';
import 'index.dart';
import 'descriptions_basic.dart';
import 'descriptions_border.dart';

abstract class DescriptionsRoutes {
  static const descriptions = '/descriptions';
  static const descriptionsBasic = '/descriptions/basic';
  static const descriptionsBorder = '/descriptions/border';
  static const descriptionsColumn = '/descriptions/column';
  static const descriptionsSize = '/descriptions/size';
  static const descriptionsApi = '/descriptions/api';
}

final descriptionsRoutesPages = [
  GetPage(
    name: DescriptionsRoutes.descriptions,
    page: () => const DescriptionsPreview(),
  ),
  GetPage(
    name: DescriptionsRoutes.descriptionsBasic,
    page: () => const DescriptionsBasicView(),
  ),
  GetPage(
    name: DescriptionsRoutes.descriptionsBorder,
    page: () => const DescriptionsBorderView(),
  ),
];
