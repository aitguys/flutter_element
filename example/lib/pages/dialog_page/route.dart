import 'package:get/get.dart';
import 'index.dart';
import 'dialog_basic.dart';
import 'dialog_custom_content.dart';
import 'dialog_component.dart';
import 'dialog_draggable.dart';

abstract class DialogRoutes {
  static const dialog = '/dialog';
  static const dialogBasic = '/dialog/basic';
  static const dialogCustomContent = '/dialog/custom-content';
  static const dialogComponent = '/dialog/component';
  static const dialogDraggable = '/dialog/draggable';
}

final dialogRoutesPages = [
  GetPage(
    name: DialogRoutes.dialog,
    page: () => const DialogPreview(),
  ),
  GetPage(
    name: DialogRoutes.dialogBasic,
    page: () => const DialogBasicView(),
  ),
  GetPage(
    name: DialogRoutes.dialogCustomContent,
    page: () => const DialogCustomContentView(),
  ),
  GetPage(
    name: DialogRoutes.dialogComponent,
    page: () => const DialogComponentView(),
  ),
  GetPage(
    name: DialogRoutes.dialogDraggable,
    page: () => const DialogDraggableView(),
  ),
];
