// lib/src/components/button/button.dart
import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';
import 'button_style.dart';
import 'content_caculate.dart';

class EButton extends StatefulWidget {
  final String? text;

  final EButtonType type;

  final ESizeItem size;
  final double? fontSize;
  final Color? color;
  final bool isLink;
  final IconData? icon;

  final Widget? child;

  final bool isPlain;
  final bool isRound;

  final bool loading;
  final IconData? loadingIcon;

  final bool isDisabled;

  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final ValueChanged<bool>? onHover;

  const EButton({
    super.key,
    this.text,
    this.isLink = false,
    this.onPressed,
    this.onLongPressed,
    this.onHover,
    this.type = EButtonType.default_,
    this.isPlain = false,
    this.isRound = false,
    this.icon,
    this.child,
    this.color,
    this.loading = false,
    this.loadingIcon,
    this.isDisabled = false,
    this.size = ESizeItem.medium,
    this.fontSize,
  });

  @override
  State<EButton> createState() => _EButtonState();
}

class _EButtonState extends State<EButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final buttonColor = widget.color ?? getButtonColor(widget.type);

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
          decoration: widget.isLink
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
                      : widget.isRound
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
                isLink: widget.isLink,
                isDisabled: widget.isDisabled,
                isActive: isHovered,
                size: widget.size,
                fontSize: widget.fontSize,
              );
            },
          ),
        ),
      ),
    );

    return btn;
  }
}
