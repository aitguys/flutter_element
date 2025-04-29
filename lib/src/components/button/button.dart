// lib/src/components/button/button.dart
import 'package:flutter/material.dart';
import 'button_style.dart';
import 'package:flutter_element/src/theme/index.dart';
import 'color_caculate.dart';
import 'content_caculate.dart';

class EButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Widget? child;
  final EButtonSize size;
  final EButtonType type;
  final Color? textColor;
  final bool isPlain;
  final bool round;
  final Color? color;
  final bool loading;
  final IconData? loadingIcon;
  final bool isDisabled;
  final double? fontSize;
  final EdgeInsets? padding;
  final bool autoFocus;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;
  const EButton(
      {super.key,
      this.text,
      this.onPressed,
      this.onLongPressed,
      this.onHover,
      this.onFocus,
      this.type = EButtonType.Default,
      this.textColor,
      this.isPlain = false,
      this.round = false,
      this.icon,
      this.child,
      this.color,
      this.loading = false,
      this.loadingIcon,
      this.isDisabled = false,
      this.size = EButtonSize.medium,
      this.fontSize,
      this.padding,
      this.autoFocus = false});

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? getButtonColor(type);

    // Calculate padding based on size
    EdgeInsetsGeometry contentPadding;
    double contentFontSize;

    switch (size) {
      case EButtonSize.small:
        contentPadding =
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
        contentFontSize = 12;
        break;
      case EButtonSize.large:
        contentPadding =
            const EdgeInsets.symmetric(horizontal: 25, vertical: 15);
        contentFontSize = 16;
        break;
      case EButtonSize.medium:
        contentPadding =
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        contentFontSize = 14;
    }
    if (padding != null) {
      contentPadding = padding!;
    }
    if (fontSize != null) {
      contentFontSize = fontSize!;
    }

    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return calculatePlainBackgroundColor(buttonColor,
                  isPlain: isPlain, isActive: true, isDisabled: isDisabled);
            }
            return calculatePlainBackgroundColor(buttonColor,
                isPlain: isPlain, isActive: false, isDisabled: isDisabled);
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return calculateForegroundColor(buttonColor,
                  isPlain: isPlain, isActive: true, isDisabled: isDisabled);
            }
            return calculateForegroundColor(buttonColor,
                isPlain: isPlain, isActive: false, isDisabled: isDisabled);
          }),
          textStyle:
              WidgetStateProperty.all(TextStyle(fontSize: contentFontSize)),
          padding: WidgetStateProperty.all(contentPadding),
          elevation: WidgetStateProperty.all(0),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return BorderSide(
                color: calculateBorderColor(buttonColor,
                    isPlain: isPlain, isActive: true, isDisabled: isDisabled),
                width: 1,
              );
            }
            return BorderSide(
              color: calculateBorderColor(buttonColor,
                  isPlain: isPlain, isActive: false, isDisabled: isDisabled),
              width: 1,
            );
          }),
          shape: WidgetStateProperty.all(
            isOnlyIcon(icon, text, child)
                ? const CircleBorder()
                : round
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      )
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
          ),
          mouseCursor: isDisabled
              ? WidgetStateProperty.all(SystemMouseCursors.forbidden)
              : WidgetStateProperty.all(SystemMouseCursors.click),
        ),
        onPressed: isDisabled ? null : onPressed,
        onLongPress: isDisabled ? null : onLongPressed,
        autofocus: autoFocus,
        onHover: isDisabled ? null : onHover,
        onFocusChange: isDisabled ? null : onFocus,
        child: Builder(builder: (context) {
          return calculateButtonContent(
              text: text,
              icon: icon,
              child: child,
              loading: loading,
              type: type,
              color: color,
              loadingIcon: loadingIcon,
              isPlain: isPlain,
              isDisabled: isDisabled,
              isActive: false);
        }));
  }
}
