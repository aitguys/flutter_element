// 根据 backgroundColor 计算 active情况下 foregroundColor 和 hover情况下 foregroundColor

import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/color.dart';
import 'link_style.dart';

Color getLinkColor(ELinkType type) {
  switch (type) {
    case ELinkType.primary:
      return EColorTypes.primary;
    case ELinkType.success:
      return EColorTypes.success;
    case ELinkType.warning:
      return EColorTypes.warning;
    case ELinkType.danger:
      return EColorTypes.danger;
    case ELinkType.info:
      return EColorTypes.info;
    case ELinkType.defaultType:
      return EColorTypes.default_;
  }
}

// 文字颜色计算
Color calculateForegroundColor(
  Color backgroundColor, {
  bool isActive = false,
  bool isPlain = false,
  bool isDisabled = false,
}) {
  if (backgroundColor == EColorTypes.default_) {
    return EBasicColors.textGray;
  } else {
    if (isDisabled) {
      return backgroundColor.withValues(alpha: 0.5);
    }
    return backgroundColor;
  }
}
