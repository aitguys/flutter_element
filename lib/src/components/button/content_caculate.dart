// 传入参数，text icon ，child , child 和 text icon 同时存在的情况下 ，child 优先级最高， 如果child 存在，text icon 不显示， 如果 child 不存在，text icon 显示

import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

Widget calculateButtonContent({
  String? text,
  IconData? icon,
  Widget? child,
  bool loading = false,
  EColorType type = EColorType.default_,
  Color? color,
  bool isActive = false,
  bool isPlain = false,
  bool isDisabled = false,
  bool isLink = false,
  ESizeItem size = ESizeItem.medium,
  double? fontSize,
}) {
  Widget content;
  final iconWidget = Icon(
    icon,
    color: calculateContentColor(
      color ?? getColorByType(type: type),
      isPlain: isPlain,
      isDisabled: isDisabled,
      isActive: isActive,
      isLink: isLink,
    ),
    size: ElememtSize(size: size).getIconSize(),
  );
  final textWidget = Text(
    text ?? '',
    style: TextStyle(
      fontSize: fontSize ?? ElememtSize(size: size).getButtonFontSize(),
      decoration: TextDecoration.none,
      color: calculateContentColor(
        color ?? getColorByType(type: type),
        isPlain: isPlain,
        isDisabled: isDisabled,
        isActive: isActive,
        isLink: isLink,
      ),
    ),
  );
  if (child != null) {
    content = child;
  } else if (text != null && icon != null) {
    content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        iconWidget,
        const SizedBox(width: 8),
        textWidget,
      ],
    );
  } else if (text != null) {
    content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        textWidget,
      ],
    );
  } else {
    content = iconWidget;
  }

  if (loading) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: calculateContentColor(
              color ?? getColorByType(type: type),
              isPlain: isPlain,
              isDisabled: isDisabled,
              isActive: isActive,
              isLink: isLink,
            ),
          ),
        ),
        const SizedBox(width: 8),
        content,
      ],
    );
  }

  return content;
}

// 判断是否只传入了 icon
bool isOnlyIcon(IconData? icon, String? text, Widget? child) {
  return icon != null && text == null && child == null;
}
