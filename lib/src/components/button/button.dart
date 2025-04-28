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
  final VoidCallback? onPressed;
  final EButtonType type;
  final Color? textColor;
  final bool isPlain;
  final bool round;
  final Color? color;
  final bool loading;
  final IconData? loadingIcon;
  final bool isDisabled;
  const EButton(
      {super.key,
      this.text,
      this.onPressed,
      this.type = EButtonType.Default,
      this.textColor,
      this.isPlain = false,
      this.round = false,
      this.icon,
      this.child,
      this.color,
      this.loading = false,
      this.loadingIcon,
      this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? getButtonColor(type);
    bool isActive = false;
    WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        isActive = true;
        return ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                return calculatePlainBackgroundColor(buttonColor,
                    isPlain: isPlain, isActive: isActive);
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.hovered)) {
                  return calculateForegroundColor(buttonColor,
                      isPlain: isPlain, isActive: isActive);
                }
                return calculateForegroundColor(buttonColor, isPlain: isPlain);
              }),
              textStyle: WidgetStateProperty.all(const TextStyle()),
              elevation: WidgetStateProperty.all(0),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              side: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.hovered)) {
                  return BorderSide(
                    color: calculateBorderColor(buttonColor,
                        isPlain: isPlain, isActive: isActive),
                    width: 1,
                  );
                }
                return BorderSide(
                  color: calculateBorderColor(buttonColor, isPlain: isPlain),
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
              mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
            ),
            onPressed: onPressed,
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
                  isActive: isActive);
            }));
      }
      return calculatePlainBackgroundColor(buttonColor, isPlain: isPlain);
    });

    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return calculatePlainBackgroundColor(buttonColor,
                  isPlain: isPlain, isActive: true);
            }
            return calculatePlainBackgroundColor(buttonColor, isPlain: isPlain);
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return calculateForegroundColor(buttonColor,
                  isPlain: isPlain, isActive: true);
            }
            return calculateForegroundColor(buttonColor, isPlain: isPlain);
          }),
          textStyle: WidgetStateProperty.all(const TextStyle()),
          elevation: WidgetStateProperty.all(0),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return BorderSide(
                color: calculateBorderColor(buttonColor,
                    isPlain: isPlain, isActive: true),
                width: 1,
              );
            }
            return BorderSide(
              color: calculateBorderColor(buttonColor, isPlain: isPlain),
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
          mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
        ),
        onPressed: onPressed,
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
