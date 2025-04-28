// 传入参数，text icon ，child , child 和 text icon 同时存在的情况下 ，child 优先级最高， 如果child 存在，text icon 不显示， 如果 child 不存在，text icon 显示

import 'package:flutter/material.dart';
import 'button_style.dart';
import 'color_caculate.dart';

Widget calculateButtonContent({
  String? text,
  IconData? icon,
  Widget? child,
  bool loading = false,
  EButtonType type = EButtonType.Default,
  Color? color,
  IconData? loadingIcon,
  bool isActive = false,
  bool isPlain = false,
  bool isDisabled = false,
}) {
  Widget content;

  if (child != null) {
    content = child;
  } else if (text != null && icon != null) {
    content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: calculateForegroundColor(
            color ?? getButtonColor(type),
            isPlain: isPlain,
            isDisabled: isDisabled,
            isActive: isActive,
          ),
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  } else if (text != null) {
    content = Text(text);
  } else {
    content = Icon(icon);
  }

  if (loading) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        loadingIcon != null
            ? Icon(loadingIcon,
                color: calculateForegroundColor(color ?? getButtonColor(type),
                    isPlain: isPlain))
            : SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: calculateForegroundColor(color ?? getButtonColor(type),
                      isPlain: isPlain),
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
