// 根据 backgroundColor 计算 active情况下 foregroundColor 和 hover情况下 foregroundColor

import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/color.dart';
import 'button_style.dart';

Color getButtonColor(EButtonType type) {
  // 根据 type 和主题生成样式
  switch (type) {
    case EButtonType.Primary:
      return EColors.Primary;
    // 其他类型...
    case EButtonType.Success:
      return EColors.Success;
    case EButtonType.Warning:
      return EColors.Warning;
    case EButtonType.Danger:
      return EColors.Danger;
    case EButtonType.Info:
      return EColors.Info;
    case EButtonType.Default:
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
  }
  if (isPlain) {
    if (isActive) {
      return Colors.white;
    }
    return backgroundColor;
  } else {
    return Colors.white;
  }
}

// 背景色计算
Color calculatePlainBackgroundColor(
  Color backgroundColor, {
  bool isActive = false,
  bool isDisabled = false,
  bool isPlain = false,
}) {
  if (isDisabled) {
    return backgroundColor.withOpacity(0.4);
  }
  if (isPlain) {
    if (isDisabled) {
      return backgroundColor.withOpacity(0.1);
    }
    if (isActive) {
      return backgroundColor.withOpacity(0.8);
    }
    return backgroundColor.withOpacity(0.1);
  } else {
    if (isDisabled) {
      return backgroundColor.withOpacity(0.4);
    }
    if (isActive) {
      return backgroundColor.withOpacity(0.8);
    }
    return backgroundColor;
  }
}

Color calculateBorderColor(
  Color backgroundColor, {
  bool isActive = false,
  bool isDisabled = false,
  bool isPlain = false,
}) {
  if (backgroundColor == EColors.Default) {
    return EColors.BorderGray;
  }
  if (isDisabled) {
    return backgroundColor.withOpacity(0.4);
  }
  if (isPlain) {
    return backgroundColor;
  }
  return backgroundColor;
}
