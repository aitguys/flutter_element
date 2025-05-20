// 根据 backgroundColor 计算 active情况下 foregroundColor 和 hover情况下 foregroundColor

import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/color.dart';
import 'link_style.dart';

Color getLinkColor(ELinkType type) {
  switch (type) {
    case ELinkType.Primary:
      return EColorTypes.primary;
    case ELinkType.Success:
      return EColorTypes.success;
    case ELinkType.Warning:
      return EColorTypes.warning;
    case ELinkType.Danger:
      return EColorTypes.danger;
    case ELinkType.Info:
      return EColorTypes.info;
    case ELinkType.Default:
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
      return backgroundColor.withOpacity(0.5);
    }
    return backgroundColor;
  }
}
