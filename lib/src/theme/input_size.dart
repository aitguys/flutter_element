// 定义大中小情况下 输入框
import 'package:flutter/material.dart';

enum ESizeItem {
  large,
  medium,
  small,
}

// 定义不同size情况下 输入框的padding
class ElememtSize {
  // 给参数 EInputESizeItem 返回对应的padding
  final ESizeItem size;
  ElememtSize({
    required this.size,
  });
  // 控制button 大小
  EdgeInsets getButtonPadding() {
    switch (size) {
      case ESizeItem.large:
        return const EdgeInsets.symmetric(vertical: 7, horizontal: 12);
      case ESizeItem.medium:
        return const EdgeInsets.symmetric(vertical: 5, horizontal: 9);
      case ESizeItem.small:
        return const EdgeInsets.symmetric(vertical: 3, horizontal: 5);
    }
  }

  // Input 输入框
  double getInputFontSize({double? customFontSize}) {
    if (customFontSize != null) {
      return customFontSize;
    }
    switch (size) {
      case ESizeItem.small:
        return 14;
      case ESizeItem.large:
        return 18;
      case ESizeItem.medium:
        return 16;
    }
  }

  double getInputHeight({double? customHeight}) {
    if (customHeight != null) {
      return customHeight;
    }
    switch (size) {
      case ESizeItem.large:
        return 48;
      case ESizeItem.medium:
        return 40;
      case ESizeItem.small:
        return 32;
    }
  }

  double getInputBorderRadius({double? customBorderRadius}) {
    if (customBorderRadius != null) {
      return customBorderRadius;
    }
    switch (size) {
      case ESizeItem.large:
        return 6;
      case ESizeItem.medium:
        return 4;
      case ESizeItem.small:
        return 2;
    }
  }

  EdgeInsets getButtonRoundPadding() {
    switch (size) {
      case ESizeItem.large:
        return const EdgeInsets.all(7);
      case ESizeItem.medium:
        return const EdgeInsets.all(5);
      case ESizeItem.small:
        return const EdgeInsets.all(3);
    }
  }

  // 控制fontsize大小
  double getButtonFontSize() {
    switch (size) {
      case ESizeItem.large:
        return 16;
      case ESizeItem.medium:
        return 14;
      case ESizeItem.small:
        return 12;
    }
  }

  double getMessageFontSize({double? customFontSize}) {
    if (customFontSize != null) {
      return customFontSize;
    }
    switch (size) {
      case ESizeItem.large:
        return 16;
      case ESizeItem.medium:
        return 14;
      case ESizeItem.small:
        return 12;
    }
  }

  EdgeInsets getInputPadding() {
    switch (size) {
      case ESizeItem.large:
        return const EdgeInsets.all(20);
      case ESizeItem.medium:
        return const EdgeInsets.all(16);
      case ESizeItem.small:
        return const EdgeInsets.symmetric(vertical: 0);
    }
  }

  EdgeInsets getMessagePadding({EdgeInsets? customPadding}) {
    if (customPadding != null) {
      return customPadding;
    }
    switch (size) {
      case ESizeItem.large:
        return const EdgeInsets.all(10);
      case ESizeItem.medium:
        return const EdgeInsets.all(8);
      case ESizeItem.small:
        return const EdgeInsets.all(6);
    }
  }

  // 输入框整体高度
  double getContainerHeight() {
    switch (size) {
      case ESizeItem.large:
        return 50;
      case ESizeItem.medium:
        return 40;
      case ESizeItem.small:
        return 32;
    }
  }

  // getCheckboxSize
  double getCheckboxSize() {
    switch (size) {
      case ESizeItem.large:
        return 20;
      case ESizeItem.medium:
        return 16;
      case ESizeItem.small:
        return 12;
    }
  }

  double getIconSize() {
    switch (size) {
      case ESizeItem.large:
        return 28;
      case ESizeItem.medium:
        return 21;
      case ESizeItem.small:
        return 20;
    }
  }

  double getTextfieldFontSize() {
    switch (size) {
      case ESizeItem.large:
        return 18;
      case ESizeItem.medium:
        return 16;
      case ESizeItem.small:
        return 14;
    }
  }
}
