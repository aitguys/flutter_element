// 定义大中小情况下 输入框
import 'package:flutter/material.dart';

enum SizeItem {
  large,
  medium,
  small,
}

// 定义不同size情况下 输入框的padding
class ElememtSize {
  // 给参数 EInputSizeItem 返回对应的padding
  final SizeItem size;

  ElememtSize({required this.size});

  EdgeInsets getInputPadding(SizeItem size) {
    switch (size) {
      case SizeItem.large:
        return EdgeInsets.fromLTRB(20, 20, 20, 20);
      case SizeItem.medium:
        return EdgeInsets.fromLTRB(12, 12, 12, 12);
      case SizeItem.small:
        return EdgeInsets.fromLTRB(8, 8, 8, 8);
    }
  }

  // getCheckboxSize
  double getCheckboxSize(SizeItem size) {
    switch (size) {
      case SizeItem.large:
        return 20;
      case SizeItem.medium:
        return 16;
      case SizeItem.small:
        return 12;
    }
  }
}
