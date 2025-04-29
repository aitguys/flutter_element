// 根据 backgroundColor 计算 active情况下 foregroundColor 和 hover情况下 foregroundColor

import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/color.dart';
import 'link_style.dart';

Color getLinkColor(ELinkType type) {
  switch (type) {
    case ELinkType.Primary:
      return EColors.Primary;
    case ELinkType.Success:
      return EColors.Success;
    case ELinkType.Warning:
      return EColors.Warning;
    case ELinkType.Danger:
      return EColors.Danger;
    case ELinkType.Info:
      return EColors.Info;
    case ELinkType.Default:
      return EColors.Default;
  }
}

// 文字颜色计算
Color calculateForegroundColor(
  Color backgroundColor, {
  bool isActive = false,
  bool isPlain = false,
  bool isDisabled = false,
}) {
  if (backgroundColor == EColors.Default) {
    return EColors.TextGray;
  } else {
    if (isDisabled) {
      return backgroundColor.withOpacity(0.5);
    }
    return backgroundColor;
  }
}
