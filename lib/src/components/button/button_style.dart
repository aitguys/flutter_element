import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';

enum EButtonType { primary, success, warning, danger, info, default_ }

enum EButtonShape { defaultShape, circle, round }

enum EButtonLoadingType { spinner, icon }

enum EButtonStatus { normal, hover, active, disabled }

enum EButtonVariant {
  defaultVariant,
  primaryVariant,
  successVariant,
  warningVariant,
  dangerVariant,
  infoVariant,
  textVariant
}

Color getButtonColor(EButtonType type) {
  // 根据 type 和主题生成样式
  switch (type) {
    case EButtonType.primary:
      return EColorTypes.primary;
    // 其他类型...
    case EButtonType.success:
      return EColorTypes.success;
    case EButtonType.warning:
      return EColorTypes.warning;
    case EButtonType.danger:
      return EColorTypes.danger;
    case EButtonType.info:
      return EColorTypes.info;
    case EButtonType.default_:
      return EColorTypes.default_;
  }
}
