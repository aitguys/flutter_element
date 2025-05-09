import 'package:flutter/material.dart';

enum ETagType { primary, success, warning, info, danger }

enum ETagSize { large, default_, small }

class ETag extends StatelessWidget {
  final String text;
  final ETagType? type;
  final ETagSize size;
  final bool closable;
  final bool disableTransitions;
  final bool hit;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onClose;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final bool round;
  final TextStyle? textStyle;

  const ETag({
    Key? key,
    required this.text,
    this.type,
    this.size = ETagSize.default_,
    this.closable = false,
    this.disableTransitions = false,
    this.hit = false,
    this.color,
    this.backgroundColor,
    this.onClose,
    this.icon,
    this.padding,
    this.borderRadius,
    this.round = false,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 计算尺寸
    double height;
    double fontSize;
    switch (size) {
      case ETagSize.large:
        height = 32.0;
        fontSize = 14.0;
        break;
      case ETagSize.small:
        height = 24.0;
        fontSize = 12.0;
        break;
      case ETagSize.default_:
        height = 28.0;
        fontSize = 13.0;
        break;
    }

    // 计算颜色
    Color bgColor;
    Color textColor;
    if (backgroundColor != null) {
      bgColor = backgroundColor!;
      textColor = color ?? theme.colorScheme.onSurface;
    } else if (type != null) {
      switch (type!) {
        case ETagType.primary:
          bgColor = theme.colorScheme.primary.withOpacity(0.1);
          textColor = theme.colorScheme.primary;
          break;
        case ETagType.success:
          bgColor = Colors.green.withOpacity(0.1);
          textColor = Colors.green;
          break;
        case ETagType.warning:
          bgColor = Colors.orange.withOpacity(0.1);
          textColor = Colors.orange;
          break;
        case ETagType.info:
          bgColor = Colors.blue.withOpacity(0.1);
          textColor = Colors.blue;
          break;
        case ETagType.danger:
          bgColor = Colors.red.withOpacity(0.1);
          textColor = Colors.red;
          break;
      }
    } else {
      bgColor = theme.colorScheme.surface;
      textColor = theme.colorScheme.onSurface;
    }

    final defaultPadding = EdgeInsets.symmetric(
      horizontal: size == ETagSize.small ? 8.0 : 10.0,
      vertical: 0,
    );

    final tag = Container(
      height: height,
      padding: padding ?? defaultPadding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(
          round ? height / 2 : (borderRadius ?? 4.0),
        ),
        border: hit ? Border.all(color: textColor, width: 1) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(
                color: textColor,
                size: fontSize + 2,
              ),
              child: icon!,
            ),
            SizedBox(width: 4),
          ],
          Text(
            text,
            style: (textStyle ?? TextStyle()).copyWith(
              color: textColor,
              fontSize: fontSize,
              height: 1.5,
            ),
          ),
          if (closable) ...[
            SizedBox(width: 4),
            InkWell(
              onTap: onClose,
              child: Icon(
                Icons.close,
                size: fontSize + 2,
                color: textColor,
              ),
            ),
          ],
        ],
      ),
    );

    if (disableTransitions) {
      return tag;
    }

    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 200),
      child: tag,
    );
  }
}
