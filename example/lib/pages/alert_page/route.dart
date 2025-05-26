import 'package:get/get.dart';
import 'index.dart';
import 'alert_basic.dart';
import 'alert_theme.dart';
import 'alert_close.dart';
import 'alert_description.dart';
import 'alert_center.dart';
import 'alert_api.dart';

abstract class AlertRoutes {
  static const alert = '/alert';
  static const alertBasic = '/alert/basic';
  static const alertTheme = '/alert/theme';
  static const alertClose = '/alert/close';
  static const alertDescription = '/alert/description';
  static const alertCenter = '/alert/center';
  static const alertApi = '/alert/api';
}

final alertRoutesPages = [
  GetPage(
    name: AlertRoutes.alert,
    page: () => const AlertPreview(),
  ),
  GetPage(
    name: AlertRoutes.alertBasic,
    page: () => const AlertBasicView(),
  ),
  GetPage(
    name: AlertRoutes.alertTheme,
    page: () => const AlertThemeView(),
  ),
  GetPage(
    name: AlertRoutes.alertClose,
    page: () => const AlertCloseView(),
  ),
  GetPage(
    name: AlertRoutes.alertDescription,
    page: () => const AlertDescriptionView(),
  ),
  GetPage(
    name: AlertRoutes.alertCenter,
    page: () => const AlertCenterView(),
  ),
  GetPage(
    name: AlertRoutes.alertApi,
    page: () => const AlertApiView(),
  ),
];
