import 'package:flutter/material.dart';

/// The type of tag, which determines its color scheme.
/// 
/// This enum defines the different color schemes available for [ETag].
enum ETagType {
  /// Primary tag style with brand colors.
  primary,

  /// Success tag style with green colors.
  success,

  /// Warning tag style with yellow/orange colors.
  warning,

  /// Info tag style with blue colors.
  info,

  /// Danger tag style with red colors.
  danger
}

/// The size of the tag.
/// 
/// This enum defines the different size options available for [ETag].
enum ETagSize {
  /// Large tag size.
  large,

  /// Default tag size.
  default_,

  /// Small tag size.
  small
}

/// A tag component that follows Element Plus design guidelines.
/// 
/// The [ETag] widget provides a customizable tag that can be used to
/// display labels, categories, or status indicators. It supports different
/// types, sizes, and features like closable tags and custom icons.
/// 
/// ## Example
/// 
/// ```dart
/// ETag(
///   text: 'New',
///   type: ETagType.success,
///   closable: true,
///   onClose: () => print('Tag closed'),
/// )
/// ```
class ETag extends StatelessWidget {
  /// The text to display in the tag.
  final String text;

  /// The type of tag, which determines its color scheme.
  /// 
  /// If not provided, the tag will use the default theme colors.
  final ETagType? type;

  /// The size of the tag.
  /// 
  /// Defaults to [ETagSize.default_].
  final ETagSize size;

  /// Whether the tag can be closed by the user.
  /// 
  /// When true, a close button will be shown in the tag.
  /// Defaults to false.
  final bool closable;

  /// Whether to disable the fade transition when the tag is removed.
  /// 
  /// When true, the tag will be removed immediately without animation.
  /// Defaults to false.
  final bool disableTransitions;

  /// Whether the tag has a hit effect.
  /// 
  /// When true, the tag will have a border in its text color.
  /// Defaults to false.
  final bool hit;

  /// A custom color for the tag text.
  /// 
  /// If provided, this overrides the text color determined by [type].
  final Color? color;

  /// A custom background color for the tag.
  /// 
  /// If provided, this overrides the background color determined by [type].
  final Color? backgroundColor;

  /// Callback function when the tag is closed.
  /// 
  /// This is called when the user clicks the close button.
  final VoidCallback? onClose;

  /// A custom icon to display in the tag.
  /// 
  /// If provided, the icon will be shown before the text.
  final Widget? icon;

  /// Custom padding for the tag content.
  /// 
  /// If not provided, a default padding based on the tag size will be used.
  final EdgeInsetsGeometry? padding;

  /// Custom border radius for the tag.
  /// 
  /// If not provided, a default border radius of 4.0 will be used,
  /// unless [round] is true.
  final double? borderRadius;

  /// Whether the tag should have fully rounded corners.
  /// 
  /// When true, the tag will have a pill-like appearance.
  /// Defaults to false.
  final bool round;

  /// Custom text style for the tag text.
  /// 
  /// If provided, this will be merged with the default text style.
  final TextStyle? textStyle;

  /// Creates an [ETag] widget.
  /// 
  /// The [text] argument is required.
  const ETag({
    super.key,
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
  });

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
          bgColor = theme.colorScheme.primary.withValues(alpha: 0.1);
          textColor = theme.colorScheme.primary;
          break;
        case ETagType.success:
          bgColor = Colors.green.withValues(alpha: 0.1);
          textColor = Colors.green;
          break;
        case ETagType.warning:
          bgColor = Colors.orange.withValues(alpha: 0.1);
          textColor = Colors.orange;
          break;
        case ETagType.info:
          bgColor = Colors.blue.withValues(alpha: 0.1);
          textColor = Colors.blue;
          break;
        case ETagType.danger:
          bgColor = Colors.red.withValues(alpha: 0.1);
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
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: (textStyle ?? const TextStyle()).copyWith(
              color: textColor,
              fontSize: fontSize,
              height: 1.5,
            ),
          ),
          if (closable) ...[
            const SizedBox(width: 4),
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
