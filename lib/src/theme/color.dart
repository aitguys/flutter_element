import 'package:flutter/material.dart';

enum EColorType { primary, success, warning, danger, info, default_ }

enum EThemeType { light, dark }

// Element Plus color type
class EColorTypes {
  // Primary color - Blue
  static const Color primary = Color(0xFF409EFF);

  // Success color - Green
  static const Color success = Color(0xFF67C23A);

  // Warning color - Yellow/Orange
  static const Color warning = Color(0xFFE6A23C);

  // Danger color - Red
  static const Color danger = Color(0xFFF56C6C);

  // Info color - Gray blue
  static const Color info = Color(0xFF909399);

  // Default color - Transparent
  static const Color default_ = Colors.white;
}

class EBasicColors {
  // 基础颜色
  static const Color baseColor = Color(0xFF409EFF);
  // Border color - Gray
  static const Color borderGray = Color.fromRGBO(221, 223, 230, 1);
  // Text color - Gray
  static const Color textGray = Color.fromRGBO(97, 98, 102, 1);
}

//  根据背景色以及状态动态计算 文字、图标等内容的颜色
Color calculateContentColor(
  Color backgroundColor, {
  bool isActive = false,
  bool isPlain = false,
  bool isDisabled = false,
  bool isLink = false,
}) {
  late Color contentColor = backgroundColor;

  if (isPlain || isLink) {
    if (backgroundColor == EColorTypes.default_) {
      contentColor = EBasicColors.textGray;
    } else {
      contentColor = backgroundColor;
    }
  } else {
    if (backgroundColor == EColorTypes.default_) {
      contentColor = EBasicColors.textGray;
    } else {
      contentColor = Colors.white;
    }
  }

  if (isDisabled) {
    return contentColor.withOpacity(0.4);
  }

  if (isActive && !isDisabled) {
    if (isPlain || isLink) {
      if (backgroundColor == EColorTypes.default_) {
        contentColor = EBasicColors.textGray;
      } else {
        if (isPlain) {
          contentColor = Colors.white;
        } else {
          contentColor = contentColor.withValues(alpha: 0.8);
        }
      }
    } else {
      if (backgroundColor == EColorTypes.default_) {
        contentColor = EBasicColors.baseColor;
      } else {
        contentColor = Colors.white;
      }
    }
  }
  return contentColor;
}

// 根据背景色以及状态动态计算 背景色
Color calculateBackgroundColor(
  Color backgroundColor, {
  bool isActive = false,
  bool isDisabled = false,
  bool isPlain = false,
}) {
  late Color backColor = backgroundColor;
  if (isPlain) {
    if (isDisabled) {
      return backgroundColor.withValues(alpha: 0.1);
    }
    if (isActive) {
      return backgroundColor.withValues(alpha: 0.8);
    }
    return backgroundColor.withValues(alpha: 0.1);
  } else {
    if (isDisabled) {
      return backgroundColor.withValues(alpha: 0.4);
    }
    if (isActive) {
      return backgroundColor.withValues(alpha: 0.8);
    }
    return backgroundColor;
  }
}

// 根据背景色以及状态动态计算 边框色
Color calculateBorderColor(
  Color backgroundColor, {
  bool isActive = false,
  bool isDisabled = false,
  bool isPlain = false,
}) {
  if (backgroundColor == EColorTypes.default_) {
    return EBasicColors.borderGray;
  }
  if (isDisabled) {
    return backgroundColor.withValues(alpha: 0.4);
  }
  if (isPlain) {
    return backgroundColor;
  }
  return backgroundColor;
}

Color getColorByType(EColorType type) {
  // 根据 type 和主题生成样式
  switch (type) {
    case EColorType.primary:
      return EColorTypes.primary;
    // 其他类型...
    case EColorType.success:
      return EColorTypes.success;
    case EColorType.warning:
      return EColorTypes.warning;
    case EColorType.danger:
      return EColorTypes.danger;
    case EColorType.info:
      return EColorTypes.info;
    case EColorType.default_:
      return EColorTypes.default_;
  }
}

Color getMessageBackgroundColor(EColorType type) {
  switch (type) {
    case EColorType.primary:
      return EColorTypes.primary.withValues(alpha: 0.9);
    case EColorType.success:
      return EColorTypes.success.withValues(alpha: 0.9);
    case EColorType.warning:
      return EColorTypes.warning.withValues(alpha: 0.9);
    case EColorType.danger:
      return EColorTypes.danger.withValues(alpha: 0.9);
    case EColorType.info:
      return EColorTypes.info.withValues(alpha: 0.9);
    default:
      return EColorTypes.primary.withValues(alpha: 0.9);
  }
}

IconData getDefaultIconByType(EColorType type, {IconData? customIcon}) {
  switch (type) {
    case EColorType.primary:
      return Icons.info_outline;
    case EColorType.success:
      return Icons.check_circle_outline;
    case EColorType.warning:
      return Icons.warning_amber_outlined;
    case EColorType.danger:
      return Icons.error_outline;
    case EColorType.info:
      return Icons.info_outline;
    default:
      return customIcon ?? Icons.info_outline;
  }
}

Color getDefaultContentColorByTypeAndTheme(
    {EColorType type = EColorType.primary,
    EThemeType theme = EThemeType.light,
    Color? customColor}) {
  if (theme == EThemeType.light) {
    return customColor ?? getColorByType(type);
  } else {
    return Colors.white;
  }
}

Color getBackGroundColorByTypeAndTheme({
  EColorType type = EColorType.primary,
  EThemeType theme = EThemeType.light,
  Color? customColor,
}) {
  if (theme == EThemeType.light) {
    return (customColor ?? getColorByType(type)).withValues(alpha: 0.3);
  } else {
    return customColor ?? getColorByType(type);
  }
}
