import 'package:get/get.dart';
import '../pages/segmented/segmented.dart';
import '../pages/table_page/table_page.dart';
import '../pages/tag_page/tag_page.dart';
import '../pages/timeline_page/timeline_page.dart';
import '../pages/statistic/statistic.dart';
import '../pages/home/home_page.dart';
import '../pages/tree/tree.dart';
import '../pages/button_page/index.dart';
import '../pages/button_page/button_basic.dart';
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
  static const HOME = '/';
  static const SEGMENTED = '/segmented';
  static const TABLE = '/table';
  static const TAG = '/tag';
  static const TIMELINE = '/timeline';
  static const TREE = '/tree';
  static const STATISTIC = '/statistic';
  static const BUTTON = '/button';
  static const BUTTON_BASIC = '/button/basic';
  static const LINK = '/link';
  static const SCROLLBAR = '/scrollbar';
  static const AUTOCOMPLETE = '/autocomplete';
  static const CHECKBOX = '/checkbox';
  static const COLOR_PICKER = '/color_picker';
  static const DATE_PICKER = '/date_picker';
  static const TIME_PICKER = '/time_picker';
  static const INPUT = '/input';
  static const INPUT_NUMBER = '/input_number';
  static const INPUT_TAG = '/input_tag';
  static const MENTION = '/mention';
  static const RADIO = '/radio';
  static const RATE = '/rate';
  static const SELECT = '/select';
  static const SLIDER = '/slider';
  static const AVATAR = '/avatar';
  static const CARD = '/card';
  static const CAROUSEL = '/carousel';
  static const COLLAPSE = '/collapse';
  static const DESCRIPTIONS = '/descriptions';
  static const EMPTY = '/empty';
  static const IMAGE = '/image';
  static const INFINITE_SCROLL = '/infinite_scroll';
  static const PAGINATION = '/pagination';
  static const PROGRESS = '/progress';
  static const RESULT = '/result';
  static const SKELETON = '/skeleton';
  static const STEPS = '/steps';
  static const TABS = '/tabs';
  static const ALERT = '/alert';
  static const DIALOG = '/dialog';
  static const DRAWER = '/drawer';
  static const MESSAGE = '/message';
  static const WATERMARK = '/watermark';
  static const NAV_ITEM = '/nav_item';
  static const BACK_TOP = '/back_top';
  static const WIDGET_PREVIEW = '/widget_preview';
}

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
    ),
    GetPage(
      name: Routes.SEGMENTED,
      page: () => const SegmentedPage(),
    ),
    GetPage(
      name: Routes.TABLE,
      page: () => const TablePage(),
    ),
    GetPage(
      name: Routes.TAG,
      page: () => const TagPage(),
    ),
    GetPage(
      name: Routes.TIMELINE,
      page: () => const TimelinePage(),
    ),
    GetPage(
      name: Routes.STATISTIC,
      page: () => const StatisticPage(),
    ),
    GetPage(
      name: Routes.TREE,
      page: () => const TreePage(),
    ),
    GetPage(
      name: Routes.BUTTON,
      page: () => const ButtonPreview(),
    ),
    GetPage(
      name: Routes.BUTTON_BASIC,
      page: () => const button_basic_preview(),
    ),
    GetPage(
      name: Routes.LINK,
      page: () => const LinkPage(),
    ),
    GetPage(
      name: Routes.SCROLLBAR,
      page: () => const ScrollbarPage(),
    ),
    GetPage(
      name: Routes.AUTOCOMPLETE,
      page: () => const AutocompletePage(),
    ),
    GetPage(
      name: Routes.CHECKBOX,
      page: () => const CheckboxPage(),
    ),
    GetPage(
      name: Routes.COLOR_PICKER,
      page: () => const ColorPickerPage(),
    ),
    GetPage(
      name: Routes.DATE_PICKER,
      page: () => const DatePickerPage(),
    ),
    GetPage(
      name: Routes.TIME_PICKER,
      page: () => const TimePickerPage(),
    ),
    GetPage(
      name: Routes.INPUT,
      page: () => const InputPage(),
    ),
    GetPage(
      name: Routes.INPUT_NUMBER,
      page: () => const InputNumberPage(),
    ),
    GetPage(
      name: Routes.INPUT_TAG,
      page: () => const InputTagPage(),
    ),
    GetPage(
      name: Routes.MENTION,
      page: () => const MentionPage(),
    ),
    GetPage(
      name: Routes.RADIO,
      page: () => const RadioPage(),
    ),
    GetPage(
      name: Routes.RATE,
      page: () => const RatePage(),
    ),
    GetPage(
      name: Routes.SELECT,
      page: () => const SelectPage(),
    ),
    GetPage(
      name: Routes.SLIDER,
      page: () => const SliderPage(),
    ),
    GetPage(
      name: Routes.AVATAR,
      page: () => const AvatarPage(),
    ),
    GetPage(
      name: Routes.CARD,
      page: () => const CardPage(),
    ),
    GetPage(
      name: Routes.CAROUSEL,
      page: () => const CarouselPage(),
    ),
    GetPage(
      name: Routes.COLLAPSE,
      page: () => const CollapsePage(),
    ),
    GetPage(
      name: Routes.DESCRIPTIONS,
      page: () => const DescriptionsPage(),
    ),
    GetPage(
      name: Routes.EMPTY,
      page: () => const EmptyPage(),
    ),
    GetPage(
      name: Routes.IMAGE,
      page: () => const ImagePage(),
    ),
    GetPage(
      name: Routes.INFINITE_SCROLL,
      page: () => const InfiniteScrollPage(),
    ),
    GetPage(
      name: Routes.PAGINATION,
      page: () => const PaginationPage(),
    ),
    GetPage(
      name: Routes.PROGRESS,
      page: () => const ProgressPage(),
    ),
    GetPage(
      name: Routes.RESULT,
      page: () => const ResultPage(),
    ),
    GetPage(
      name: Routes.SKELETON,
      page: () => const SkeletonPage(),
    ),
    GetPage(
      name: Routes.STEPS,
      page: () => const StepsPage(),
    ),
    GetPage(
      name: Routes.TABS,
      page: () => const TabsPage(),
    ),
    GetPage(
      name: Routes.ALERT,
      page: () => const AlertPage(),
    ),
    GetPage(
      name: Routes.DIALOG,
      page: () => const DialogPage(),
    ),
    GetPage(
      name: Routes.DRAWER,
      page: () => const DrawerPage(),
    ),
    GetPage(
      name: Routes.MESSAGE,
      page: () => const MessagePage(),
    ),
    GetPage(
      name: Routes.WATERMARK,
      page: () => const WatermarkPage(),
    ),
    GetPage(
      name: Routes.NAV_ITEM,
      page: () => const NavItemTestPage(),
    ),
    GetPage(
      name: Routes.WIDGET_PREVIEW,
      page: () => const WidgetPreviewTestPage(),
    ),
  ];
}
