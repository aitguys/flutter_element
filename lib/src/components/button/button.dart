// lib/src/components/button/button.dart
import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';
import 'button_style.dart';
import 'content_caculate.dart';

class EButton extends StatefulWidget {
  final String? text;
  final bool link;
  final IconData? icon;
  final Widget? child;
  final ESizeItem size;
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

  const EButton({
    super.key,
    this.text,
    this.link = false,
    this.onPressed,
    this.onLongPressed,
    this.onHover,
    this.onFocus,
    this.type = EButtonType.default_,
    this.textColor,
    this.isPlain = false,
    this.round = false,
    this.icon,
    this.child,
    this.color,
    this.loading = false,
    this.loadingIcon,
    this.isDisabled = false,
    this.size = ESizeItem.medium,
    this.fontSize,
    this.padding,
    this.autoFocus = false,
  });

  @override
  State<EButton> createState() => _EButtonState();
}

class _EButtonState extends State<EButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final buttonColor = widget.color ?? getButtonColor(widget.type);

    // Calculate padding based on size

    final isIconOnly = isOnlyIcon(widget.icon, widget.text, widget.child);

    Widget btn = MouseRegion(
      cursor: widget.isDisabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => isHovered = true);
        widget.onHover?.call(true);
      },
      onExit: (_) {
        setState(() => isHovered = false);
        widget.onHover?.call(false);
      },
      child: GestureDetector(
        onTap: widget.isDisabled ? null : widget.onPressed,
        onLongPress: widget.isDisabled ? null : widget.onLongPressed,
        child: Container(
          padding: isIconOnly
              ? ElememtSize(size: widget.size).getButtonRoundPadding()
              : ElememtSize(size: widget.size).getButtonPadding(),
          decoration: widget.link
              ? null
              : BoxDecoration(
                  color: isHovered
                      ? calculateBackgroundColor(buttonColor,
                          isPlain: widget.isPlain,
                          isActive: true,
                          isDisabled: widget.isDisabled)
                      : calculateBackgroundColor(buttonColor,
                          isPlain: widget.isPlain,
                          isActive: false,
                          isDisabled: widget.isDisabled),
                  borderRadius: isIconOnly
                      ? BorderRadius.circular(100)
                      : widget.round
                          ? BorderRadius.circular(100)
                          : BorderRadius.circular(5),
                  border: Border.all(
                    color: isHovered
                        ? calculateBorderColor(buttonColor,
                            isPlain: widget.isPlain,
                            isActive: true,
                            isDisabled: widget.isDisabled)
                        : calculateBorderColor(buttonColor,
                            isPlain: widget.isPlain,
                            isActive: false,
                            isDisabled: widget.isDisabled),
                    width: 1,
                  ),
                ),
          child: Builder(
            builder: (context) {
              return calculateButtonContent(
                text: widget.text,
                icon: widget.icon,
                child: widget.child,
                loading: widget.loading,
                type: widget.type,
                color: buttonColor,
                loadingIcon: widget.loadingIcon,
                isPlain: widget.isPlain,
                link: widget.link,
                isDisabled: widget.isDisabled,
                isActive: isHovered,
                size: widget.size,
              );
            },
          ),
        ),
      ),
    );

    return btn;
  }
}
