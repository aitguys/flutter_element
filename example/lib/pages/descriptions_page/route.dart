import 'package:get/get.dart';
import 'index.dart';
import 'descriptions_basic.dart';
import 'descriptions_border.dart';
import 'descriptions_column.dart';
import 'descriptions_size.dart';

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
  GetPage(
    name: DescriptionsRoutes.descriptionsColumn,
    page: () => const DescriptionsColumnView(),
  ),
  GetPage(
    name: DescriptionsRoutes.descriptionsSize,
    page: () => const DescriptionsSizeView(),
  ),
];
