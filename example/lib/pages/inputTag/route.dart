import 'package:get/get.dart';
import 'index.dart';
import 'input_tag_custom_tag.dart';
import 'input_tag_prefix_suffix.dart';
import 'input_tag_max.dart';
import 'input_tag_delimiter.dart';
import 'input_tag_trigger.dart';
import 'input_tag_save_on_blur.dart';
import 'input_tag_clearable.dart';
import 'input_tag_disabled_readonly.dart';
import 'input_tag_size.dart';
import 'input_tag_custom_style.dart';
import 'input_tag_custom_color.dart';
import 'input_tag_api.dart';

abstract class InputTagRoutes {
  static const inputTag = '/inputTag';
  static const customTag = '/inputTag/custom-tag';
  static const prefixSuffix = '/inputTag/prefix-suffix';
  static const max = '/inputTag/max';
  static const delimiter = '/inputTag/delimiter';
  static const trigger = '/inputTag/trigger';
  static const saveOnBlur = '/inputTag/save-on-blur';
  static const clearable = '/inputTag/clearable';
  static const disabledReadOnly = '/inputTag/disabled-readonly';
  static const size = '/inputTag/size';
  static const customStyle = '/inputTag/custom-style';
  static const customColor = '/inputTag/custom-color';
  static const api = '/inputTag/api';
}

final inputTagRoutesPages = [
  GetPage(
    name: InputTagRoutes.inputTag,
    page: () => const InputTagPreview(),
  ),
  GetPage(
    name: InputTagRoutes.customTag,
    page: () => const InputTagCustomTagView(),
  ),
  GetPage(
    name: InputTagRoutes.prefixSuffix,
    page: () => const InputTagPrefixSuffixView(),
  ),
  GetPage(
    name: InputTagRoutes.max,
    page: () => const InputTagMaxView(),
  ),
  GetPage(
    name: InputTagRoutes.delimiter,
    page: () => const InputTagDelimiterView(),
  ),
  GetPage(
    name: InputTagRoutes.trigger,
    page: () => const InputTagTriggerView(),
  ),
  GetPage(
    name: InputTagRoutes.saveOnBlur,
    page: () => const InputTagSaveOnBlurView(),
  ),
  GetPage(
    name: InputTagRoutes.clearable,
    page: () => const InputTagClearableView(),
  ),
  GetPage(
    name: InputTagRoutes.disabledReadOnly,
    page: () => const InputTagDisabledReadOnlyView(),
  ),
  GetPage(
    name: InputTagRoutes.size,
    page: () => const InputTagSizeView(),
  ),
  GetPage(
    name: InputTagRoutes.customStyle,
    page: () => const InputTagCustomStyleView(),
  ),
  GetPage(
    name: InputTagRoutes.customColor,
    page: () => const InputTagCustomColorView(),
  ),
  GetPage(
    name: InputTagRoutes.api,
    page: () => const InputTagApiView(),
  ),
];
