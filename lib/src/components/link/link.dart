import 'package:flutter/material.dart';
import 'link_style.dart';
import 'color_caculate.dart';

class ELink extends StatelessWidget {
  final String text;
  final ELinkType type;
  final bool disabled;
  final bool underline;
  final IconData? icon;
  final VoidCallback? onPressed;
  final String? href;
  final String? target;

  const ELink({
    super.key,
    required this.text,
    this.type = ELinkType.Default,
    this.disabled = false,
    this.underline = true,
    this.icon,
    this.onPressed,
    this.href,
    this.target,
  });

  @override
  Widget build(BuildContext context) {
    final color = getLinkColor(type);
    final textStyle = TextStyle(
      color: disabled
          ? calculateForegroundColor(color, isDisabled: true)
          : calculateForegroundColor(color),
    );

    Widget linkContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 16,
            color: disabled
                ? calculateForegroundColor(color, isDisabled: true)
                : calculateForegroundColor(color),
          ),
          const SizedBox(width: 8),
        ],
        Text(text, style: textStyle),
      ],
    );

    if (underline) {
      linkContent = MouseRegion(
        cursor:
            disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: disabled
                    ? calculateForegroundColor(color, isDisabled: true)
                    : calculateForegroundColor(color),
                width: 1,
              ),
            ),
          ),
          child: linkContent,
        ),
      );
    }

    if (href != null) {
      return InkWell(
        onTap: disabled
            ? null
            : () {
                // Handle href navigation
                if (onPressed != null) {
                  onPressed!();
                }
              },
        child: linkContent,
      );
    }

    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: linkContent,
    );
  }
}
