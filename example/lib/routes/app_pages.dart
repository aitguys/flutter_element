import 'package:get/get.dart';
import '../pages/button_page/route.dart';
import '../pages/segmented/segmented.dart';
import '../pages/table_page/table_page.dart';
import '../pages/tag_page/tag_page.dart';
import '../pages/timeline_page/timeline_page.dart';
import '../pages/statistic/statistic.dart';
import '../pages/home/home_page.dart';
import '../pages/tree/tree.dart';
import '../pages/link_page/link_page.dart';
import '../pages/scrollbar_page/scrollbar_page.dart';
import '../pages/autocomplete_page/autocomplete_page.dart';
import '../pages/checkbox_page/checkbox_page.dart';
import '../pages/color_picker_page/color_picker_page.dart';
import '../pages/datePicker/date_picker.dart';
import '../pages/time_picker_page/time_picker_page.dart';
import '../pages/input_page/input_page.dart';
import '../pages/input_number_page/input_number_page.dart';
import '../pages/inputTag/input_tag.dart';
import '../pages/mention_page/mention_page.dart';
import '../pages/radio_page/radio_page.dart';
import '../pages/rate_page/rate_page.dart';
import '../pages/select_page/select_page.dart';
import '../pages/slider_page/slider_page.dart';
import '../pages/avatar_page/avatar_page.dart';
import '../pages/card_page/card_page.dart';
import '../pages/carousel_page/carousel_page.dart';
import '../pages/collapse_page/collapse_page.dart';
import '../pages/descriptions_page/descriptions_page.dart';
import '../pages/empty_page/empty_page.dart';
import '../pages/image_page/image_page.dart';
import '../pages/infinite_scroll_page/infinite_scroll_page.dart';
import '../pages/pagination_page/pagination_page.dart';
import '../pages/progress_page/progress_page.dart';
import '../pages/result_page/result_page.dart';
import '../pages/skeleton_page/skeleton_page.dart';
import '../pages/steps_page/steps_page.dart';
import '../pages/tabs_page/tabs_page.dart';
import '../pages/alert_page/alert_page.dart';
import '../pages/dialog_page/dialog_page.dart';
import '../pages/drawer_page/drawer_page.dart';
import '../pages/message_page/message_page.dart';
import '../pages/watermark_page/watermark_page.dart';
import '../pages/nav_item/navItem_page.dart';
import '../pages/widgetPreview/widget_preview.dart';

abstract class Routes {
  static const home = '/';
  static const segmented = '/segmented';
  static const table = '/table';
  static const tag = '/tag';
  static const timeline = '/timeline';
  static const tree = '/tree';
  static const statistic = '/statistic';
  static const button = ButtonRoutes.button;
  static const buttonBasic = ButtonRoutes.buttonBasic;
  static const buttonIcon = ButtonRoutes.buttonIcon;
  static const buttonCustomColor = ButtonRoutes.buttonCustomColor;
  static const buttonCustomChildren = ButtonRoutes.buttonCustomChildren;
  static const buttonLoading = ButtonRoutes.buttonLoading;
  static const buttonBadge = ButtonRoutes.buttonBadge;
  static const buttonLink = ButtonRoutes.buttonLink;
  static const buttonSize = ButtonRoutes.buttonSize;
  static const link = '/link';
  static const scrollbar = '/scrollbar';
  static const autocomplete = '/autocomplete';
  static const checkbox = '/checkbox';
  static const colorPicker = '/color_picker';
  static const datePicker = '/date_picker';
  static const timePicker = '/time_picker';
  static const input = '/input';
  static const inputNumber = '/input_number';
  static const inputTag = '/input_tag';
  static const mention = '/mention';
  static const radio = '/radio';
  static const rate = '/rate';
  static const select = '/select';
  static const slider = '/slider';
  static const avatar = '/avatar';
  static const card = '/card';
  static const carousel = '/carousel';
  static const collapse = '/collapse';
  static const descriptions = '/descriptions';
  static const empty = '/empty';
  static const image = '/image';
  static const infiniteScroll = '/infinite_scroll';
  static const pagination = '/pagination';
  static const progress = '/progress';
  static const result = '/result';
  static const skeleton = '/skeleton';
  static const steps = '/steps';
  static const tabs = '/tabs';
  static const alert = '/alert';
  static const dialog = '/dialog';
  static const drawer = '/drawer';
  static const message = '/message';
  static const watermark = '/watermark';
  static const navItem = '/nav_item';
  static const backTop = '/back_top';
  static const widgetPreview = '/widget_preview';
}

class AppPages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: Routes.segmented,
      page: () => const SegmentedPage(),
    ),
    GetPage(
      name: Routes.table,
      page: () => const TablePage(),
    ),
    GetPage(
      name: Routes.tag,
      page: () => const TagPage(),
    ),
    GetPage(
      name: Routes.timeline,
      page: () => const TimelinePage(),
    ),
    GetPage(
      name: Routes.statistic,
      page: () => const StatisticPage(),
    ),
    GetPage(
      name: Routes.tree,
      page: () => const TreePage(),
    ),
    ...buttonRoutesPages,
    GetPage(
      name: Routes.link,
      page: () => const LinkPage(),
    ),
    GetPage(
      name: Routes.scrollbar,
      page: () => const ScrollbarPage(),
    ),
    GetPage(
      name: Routes.autocomplete,
      page: () => const AutocompletePage(),
    ),
    GetPage(
      name: Routes.checkbox,
      page: () => const CheckboxPage(),
    ),
    GetPage(
      name: Routes.colorPicker,
      page: () => const ColorPickerPage(),
    ),
    GetPage(
      name: Routes.datePicker,
      page: () => const DatePickerPage(),
    ),
    GetPage(
      name: Routes.timePicker,
      page: () => const TimePickerPage(),
    ),
    GetPage(
      name: Routes.input,
      page: () => const InputPage(),
    ),
    GetPage(
      name: Routes.inputNumber,
      page: () => const InputNumberPage(),
    ),
    GetPage(
      name: Routes.inputTag,
      page: () => const InputTagPage(),
    ),
    GetPage(
      name: Routes.mention,
      page: () => const MentionPage(),
    ),
    GetPage(
      name: Routes.radio,
      page: () => const RadioPage(),
    ),
    GetPage(
      name: Routes.rate,
      page: () => const RatePage(),
    ),
    GetPage(
      name: Routes.select,
      page: () => const SelectPage(),
    ),
    GetPage(
      name: Routes.slider,
      page: () => const SliderPage(),
    ),
    GetPage(
      name: Routes.avatar,
      page: () => const AvatarPage(),
    ),
    GetPage(
      name: Routes.card,
      page: () => const CardPage(),
    ),
    GetPage(
      name: Routes.carousel,
      page: () => const CarouselPage(),
    ),
    GetPage(
      name: Routes.collapse,
      page: () => const CollapsePage(),
    ),
    GetPage(
      name: Routes.descriptions,
      page: () => const DescriptionsPage(),
    ),
    GetPage(
      name: Routes.empty,
      page: () => const EmptyPage(),
    ),
    GetPage(
      name: Routes.image,
      page: () => const ImagePage(),
    ),
    GetPage(
      name: Routes.infiniteScroll,
      page: () => const InfiniteScrollPage(),
    ),
    GetPage(
      name: Routes.pagination,
      page: () => const PaginationPage(),
    ),
    GetPage(
      name: Routes.progress,
      page: () => const ProgressPage(),
    ),
    GetPage(
      name: Routes.result,
      page: () => const ResultPage(),
    ),
    GetPage(
      name: Routes.skeleton,
      page: () => const SkeletonPage(),
    ),
    GetPage(
      name: Routes.steps,
      page: () => const StepsPage(),
    ),
    GetPage(
      name: Routes.tabs,
      page: () => const TabsPage(),
    ),
    GetPage(
      name: Routes.alert,
      page: () => const AlertPage(),
    ),
    GetPage(
      name: Routes.dialog,
      page: () => const DialogPage(),
    ),
    GetPage(
      name: Routes.drawer,
      page: () => const DrawerPage(),
    ),
    GetPage(
      name: Routes.message,
      page: () => const MessagePage(),
    ),
    GetPage(
      name: Routes.watermark,
      page: () => const WatermarkPage(),
    ),
    GetPage(
      name: Routes.navItem,
      page: () => const NavItemTestPage(),
    ),
    GetPage(
      name: Routes.widgetPreview,
      page: () => const WidgetPreviewTestPage(),
    ),
  ];
}
