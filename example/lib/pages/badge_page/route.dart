import 'package:get/get.dart';
import 'badge_page.dart';

abstract class BadgeRoutes {
  static const badge = '/badge';
}

final badgeRoutesPages = [
  GetPage(
    name: BadgeRoutes.badge,
    page: () => const BadgePage(),
  ),
];
