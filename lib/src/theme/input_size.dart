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

  EdgeInsets getInputPadding() {
    switch (size) {
      case SizeItem.large:
        return EdgeInsets.all(20);
      case SizeItem.medium:
        return EdgeInsets.all(12);
      case SizeItem.small:
        return EdgeInsets.symmetric(vertical: 4);
    }
  }

  double getContainerHeight() {
    switch (size) {
      case SizeItem.large:
        return 40;
      case SizeItem.medium:
        return 32;
      case SizeItem.small:
        return 24;
    }
  }

  // getCheckboxSize
  double getCheckboxSize() {
    switch (size) {
      case SizeItem.large:
        return 20;
      case SizeItem.medium:
        return 16;
      case SizeItem.small:
        return 12;
    }
  }

  double getIconSize() {
    switch (size) {
      case SizeItem.large:
        return 28;
      case SizeItem.medium:
        return 24;
      case SizeItem.small:
        return 20;
    }
  }

  double getTextfieldFontSize() {
    switch (size) {
      case SizeItem.large:
        return 16;
      case SizeItem.medium:
        return 14;
      case SizeItem.small:
        return 12;
    }
  }
}
