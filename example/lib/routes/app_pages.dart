import 'package:get/get.dart';
import '../pages/button_page/route.dart';
import '../pages/input_page/route.dart';
import '../pages/message_page/route.dart';
import '../pages/alert_page/route.dart';
import '../pages/autocomplete_page/route.dart';
import '../pages/input_number_page/route.dart';
import '../pages/inputTag/route.dart';
import '../pages/segmented/segmented.dart';
import '../pages/table_page/table_page.dart';
import '../pages/tag_page/tag_page.dart';
import '../pages/timeline_page/timeline_page.dart';
import '../pages/statistic/statistic.dart';
import '../pages/home/home_page.dart';
import '../pages/tree/tree.dart';
import '../pages/link_page/link_page.dart';
import '../pages/scrollbar_page/scrollbar_page.dart';
import '../pages/checkbox_page/route.dart';
import '../pages/color_picker_page/route.dart';

// import '../pages/datePicker/date_picker.dart';
import '../pages/datePicker/route.dart';
import '../pages/time_picker_page/time_picker_page.dart';
import '../pages/mention_page/mention_page.dart';
// import '../pages/radio_page/radio_page.dart';
import '../pages/radio_page/route.dart';
import '../pages/rate_page/route.dart';
import '../pages/select_page/route.dart';
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
import '../pages/dialog_page/route.dart';
import '../pages/drawer_page/drawer_page.dart';
import '../pages/message_page/message_page.dart';
import '../pages/watermark_page/watermark_page.dart';
import '../pages/nav_item/nav_item_page.dart';
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
  static const input = InputRoutes.input;
  static const inputBasic = InputRoutes.inputBasic;
  static const autocomplete = AutocompleteRoutes.autocomplete;
  static const inputPassword = InputRoutes.inputPassword;
  static const message = MessageRoutes.message;
  static const messageBasic = MessageRoutes.messageBasic;
  static const messageSize = MessageRoutes.messageSize;
  static const messageRound = MessageRoutes.messageRound;
  static const messageDuration = MessageRoutes.messageDuration;
  static const messageIcon = MessageRoutes.messageIcon;
  static const messageShowClose = MessageRoutes.messageShowClose;
  static const messageApi = MessageRoutes.messageApi;
  static const alert = AlertRoutes.alert;
  static const alertBasic = AlertRoutes.alertBasic;
  static const alertTheme = AlertRoutes.alertTheme;
  static const alertClose = AlertRoutes.alertClose;
  static const alertDescription = AlertRoutes.alertDescription;
  static const alertCenter = AlertRoutes.alertCenter;
  static const alertApi = AlertRoutes.alertApi;
  static const link = '/link';
  static const scrollbar = '/scrollbar';
  static const checkbox = CheckboxRoutes.checkbox;
  static const checkboxBasic = CheckboxRoutes.checkboxBasic;
  static const checkboxTheme = CheckboxRoutes.checkboxTheme;
  static const checkboxSize = CheckboxRoutes.checkboxSize;
  static const checkboxDisable = CheckboxRoutes.checkboxDisable;
  static const checkboxGroup = CheckboxRoutes.checkboxGroup;
  static const checkboxBorder = CheckboxRoutes.checkboxBorder;
  static const checkboxSelectAll = CheckboxRoutes.checkboxSelectAll;
  static const colorPicker = ColorPickerRoutes.colorPicker;
  static const colorPickerAlpha = ColorPickerRoutes.colorPickerAlpha;
  static const colorPickerPredefine = ColorPickerRoutes.colorPickerPredefine;
  static const colorPickerSize = ColorPickerRoutes.colorPickerSize;
  static const colorPickerDisabled = ColorPickerRoutes.colorPickerDisabled;
  static const datePicker = '/datePicker';
  static const timePicker = '/time_picker';

  static const inputNumber = InputNumberRoutes.inputNumber;
  static const inputNumberBasic = InputNumberRoutes.inputNumberBasic;
  static const inputNumberControls = InputNumberRoutes.inputNumberControls;
  static const inputNumberClearable = InputNumberRoutes.inputNumberClearable;
  static const inputNumberPrefixSuffix =
      InputNumberRoutes.inputNumberPrefixSuffix;
  static const inputNumberCustomIcons =
      InputNumberRoutes.inputNumberCustomIcons;
  static const inputNumberDisabled = InputNumberRoutes.inputNumberDisabled;
  static const inputNumberSize = InputNumberRoutes.inputNumberSize;
  static const inputNumberPosition = InputNumberRoutes.inputNumberPosition;
  static const inputNumberStyle = InputNumberRoutes.inputNumberStyle;
  static const inputNumberApi = InputNumberRoutes.inputNumberApi;
  static const inputTag = InputTagRoutes.inputTag;
  static const inputTagCustomTag = InputTagRoutes.customTag;
  static const inputTagPrefixSuffix = InputTagRoutes.prefixSuffix;
  static const inputTagMax = InputTagRoutes.max;
  static const inputTagDelimiter = InputTagRoutes.delimiter;
  static const inputTagTrigger = InputTagRoutes.trigger;
  static const inputTagSaveOnBlur = InputTagRoutes.saveOnBlur;
  static const inputTagClearable = InputTagRoutes.clearable;
  static const inputTagDisabledReadOnly = InputTagRoutes.disabledReadOnly;
  static const inputTagSize = InputTagRoutes.size;
  static const inputTagCustomStyle = InputTagRoutes.customStyle;
  static const inputTagCustomColor = InputTagRoutes.customColor;

  static const mention = '/mention';
  static const radio = '/radio';
  static const rate = RateRoutes.rate;
  static const rateBasic = RateRoutes.rateBasic;
  static const rateColors = RateRoutes.rateColors;
  static const rateSize = RateRoutes.rateSize;
  static const rateHalf = RateRoutes.rateHalf;
  static const rateText = RateRoutes.rateText;
  static const rateScore = RateRoutes.rateScore;
  static const select = SelectRoutes.select;
  static const selectBasic = SelectRoutes.selectBasic;
  static const selectMultiple = SelectRoutes.selectMultiple;
  static const selectDisable = SelectRoutes.selectDisable;
  static const selectClearable = SelectRoutes.selectClearable;
  static const selectPrefixSuffix = SelectRoutes.selectPrefixSuffix;
  static const selectOptionDisable = SelectRoutes.selectOptionDisable;
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
  static const dialog = DialogRoutes.dialog;
  static const dialogBasic = DialogRoutes.dialogBasic;
  static const dialogCustomContent = DialogRoutes.dialogCustomContent;
  static const dialogComponent = DialogRoutes.dialogComponent;
  static const dialogDraggable = DialogRoutes.dialogDraggable;
  static const drawer = '/drawer';
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
    ...autocompleteRoutesPages,
    ...inputRoutesPages,
    ...inputNumberRoutesPages,
    ...messageRoutesPages,
    ...alertRoutesPages,
    ...radioRoutesPages,
    ...datePickerRoutesPages,
    ...checkboxRoutesPages,
    ...inputTagRoutesPages,
    ...inputNumberRoutesPages,
    ...rateRoutesPages,
    ...selectRoutesPages,
    ...colorPickerRoutesPages,
    GetPage(
      name: Routes.link,
      page: () => const LinkPage(),
    ),
    GetPage(
      name: Routes.scrollbar,
      page: () => const ScrollbarPage(),
    ),

    // GetPage(
    //   name: Routes.datePicker,
    //   page: () => const DatePickerPage(),
    // ),
    GetPage(
      name: Routes.timePicker,
      page: () => const TimePickerPage(),
    ),
    // GetPage(
    //   name: Routes.inputNumber,
    //   page: () => const InputNumberPage(),
    // ),

    GetPage(
      name: Routes.mention,
      page: () => const MentionPage(),
    ),
    // GetPage(
    //   name: Routes.radio,
    //   page: () => const RadioPage(),
    // ),

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
    ...dialogRoutesPages,
    ...rateRoutesPages,
    ...selectRoutesPages,
    ...colorPickerRoutesPages,
  ];
}
