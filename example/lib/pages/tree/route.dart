import 'package:get/get.dart';
import 'index.dart';
import 'tree_basic.dart';
import 'tree_checkbox.dart';
import 'tree_default.dart';
import 'tree_disabled.dart';
import 'tree_icon.dart';
import 'tree_draggable.dart';

abstract class TreeRoutes {
  static const tree = '/tree';
  static const treeBasic = '/tree/basic';
  static const treeCheckbox = '/tree/checkbox';
  static const treeDefault = '/tree/default';
  static const treeDisabled = '/tree/disabled';
  static const treeIcon = '/tree/icon';
  static const treeDraggable = '/tree/draggable';
  static const treeApi = '/tree/api';
}

final treeRoutesPages = [
  GetPage(
    name: TreeRoutes.tree,
    page: () => const TreePreview(),
  ),
  GetPage(
    name: TreeRoutes.treeBasic,
    page: () => const TreeBasicView(),
  ),
  GetPage(
    name: TreeRoutes.treeCheckbox,
    page: () => const TreeCheckboxView(),
  ),
  GetPage(
    name: TreeRoutes.treeDefault,
    page: () => const TreeDefaultView(),
  ),
  GetPage(
    name: TreeRoutes.treeDisabled,
    page: () => const TreeDisabledView(),
  ),
  GetPage(
    name: TreeRoutes.treeIcon,
    page: () => const TreeIconView(),
  ),
  GetPage(
    name: TreeRoutes.treeDraggable,
    page: () => const TreeDraggableView(),
  ),
];
