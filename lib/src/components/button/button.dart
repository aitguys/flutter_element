// lib/src/components/button/button.dart
import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';
import 'content_caculate.dart';

/// A customizable button component that follows Element Plus design guidelines.
///
/// The [EButton] widget provides a flexible button implementation with various
/// styles, states, and behaviors. It supports different types, sizes, and
/// interactive states like hover, loading, and disabled.
///
/// ## Example
///
/// ```dart
/// EButton(
///   text: 'Click me',
///   type: EColorType.primary,
///   onPressed: () => print('Button pressed'),
/// )
/// ```
///
/// See also:
/// * [EColorType] for available button types
/// * [ESizeItem] for available button sizes
class EButton extends StatefulWidget {
  /// The text to display on the button.
  ///
  /// If both [text] and [child] are provided, [child] takes precedence.
  final String? text;

  /// The type of button, which determines its color scheme.
  ///
  /// Defaults to [EColorType.default_].
  final EColorType type;

  /// The size of the button.
  ///
  /// Defaults to [ESizeItem.medium].
  final ESizeItem size;

  /// Custom font size for the button text.
  ///
  /// If not provided, the size will be determined by [size].
  final double? fontSize;

  /// Custom color for the button.
  ///
  /// If provided, this overrides the color determined by [type].
  final Color? color;

  /// Gradient for the button background. If provided and not null,
  /// the button background will use the gradient instead of a solid color.
  final Gradient? gradient;

  /// Whether the button should be rendered as a link.
  ///
  /// When true, the button will have no background or border.
  final bool isLink;

  /// The icon to display on the button.
  ///
  /// If provided, the icon will be shown before the text.
  final IconData? icon;
  final IconData? suffixIcon;

  /// A custom widget to display inside the button.
  ///
  /// If provided, this takes precedence over [text].
  final Widget? child;

  /// Whether the button should have a plain style.
  ///
  /// When true, the button will have a transparent background with a border.
  final bool isPlain;

  /// Whether the button should have rounded corners.
  ///
  /// When true, the button will have fully rounded corners.
  final bool isRound;

  /// Whether the button should be circular.
  ///
  /// When true, the button will be rendered as a circle, typically used for icon-only buttons.
  final bool isCircle;

  /// Whether the button is in a loading state.
  ///
  /// When true, a loading spinner will be shown instead of the button content.
  final bool loading;

  /// Whether the button should automatically show loading state when pressed.
  ///
  /// When true, the button will show a loading spinner while the [onPressed] callback is executing.
  final bool autoLoading;

  /// Whether the button is disabled.
  ///
  /// When true, the button cannot be pressed and will show a disabled style.
  final bool isDisabled;

  /// Callback function when the button is pressed.
  ///
  /// If [autoLoading] is true, this callback can return a [Future] and the button
  /// will show a loading state until the future completes.
  final dynamic Function()? onPressed;

  /// Callback function when the button is long-pressed.
  final dynamic Function()? onLongPressed;

  /// Callback function when the button's hover state changes.
  ///
  /// The callback receives a boolean indicating whether the button is being hovered.
  final ValueChanged<bool>? onHover;

  /// Callback function when the button is closed.
  final dynamic Function()? onSuffixPressed;

  /// Custom border radius for the button.
  final double? borderRadius;

  /// Creates an [EButton] widget.
  ///
  /// The [text] and [child] arguments are optional, but at least one should be provided
  /// to give the button content.
  const EButton({
    super.key,
    this.text,
    this.isLink = false,
    this.onPressed,
    this.onLongPressed,
    this.onHover,
    this.onSuffixPressed,
    this.type = EColorType.default_,
    this.isPlain = false,
    this.isRound = false,
    this.isCircle = false,
    this.icon,
    this.suffixIcon,
    this.child,
    this.color,
    this.gradient,
    this.loading = false,
    this.autoLoading = false,
    this.isDisabled = false,
    this.size = ESizeItem.medium,
    this.fontSize,
    this.borderRadius,
  });

  @override
  State<EButton> createState() => _EButtonState();
}

class _EButtonState extends State<EButton> {
  bool isHovered = false;
  bool isLoading = false;

  void _handlePress() async {
    if (widget.onPressed == null) return;

    if (widget.autoLoading) {
      setState(() {
        isLoading = true;
      });

      try {
        final result = widget.onPressed!();
        if (result is Future) {
          await result;
        }
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    } else {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = widget.color ?? getColorByType(type: widget.type);

    final isIconOnly = isOnlyIcon(widget.icon, widget.text, widget.child);

    // 优先级：isLink > gradient > color
    BoxDecoration? boxDecoration;
    if (widget.isLink) {
      boxDecoration = null;
    } else if (widget.gradient != null) {
      boxDecoration = BoxDecoration(
        gradient: widget.gradient,
        // 使用一个带透明度的蒙版色覆盖在渐变上
        // 这里我们以白色带一定透明度做常规蒙版，可按需调整
        color: isHovered
            ? calculateBackgroundColor(Colors.white.withValues(alpha: 0.8),
                isPlain: widget.isPlain,
                isActive: true,
                isDisabled: widget.isDisabled)
            : calculateBackgroundColor(Colors.white.withValues(alpha: 1),
                isPlain: widget.isPlain,
                isActive: false,
                isDisabled: widget.isDisabled),
        borderRadius: isIconOnly && widget.isCircle
            ? BorderRadius.circular(100)
            : widget.isRound
                ? BorderRadius.circular(100)
                : BorderRadius.circular(widget.borderRadius ?? 4),
      );
    } else {
      boxDecoration = BoxDecoration(
        color: isHovered
            ? calculateBackgroundColor(buttonColor,
                isPlain: widget.isPlain,
                isActive: true,
                isDisabled: widget.isDisabled)
            : calculateBackgroundColor(buttonColor,
                isPlain: widget.isPlain,
                isActive: false,
                isDisabled: widget.isDisabled),
        borderRadius: isIconOnly && widget.isCircle
            ? BorderRadius.circular(100)
            : widget.isRound
                ? BorderRadius.circular(100)
                : BorderRadius.circular(widget.borderRadius ?? 4),
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
      );
    }

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
        onTap: widget.isDisabled ? null : _handlePress,
        onLongPress: widget.isDisabled ? null : widget.onLongPressed,
        child: Container(
          padding: isIconOnly && widget.isCircle
              ? ElememtSize(size: widget.size).getButtonRoundPadding()
              : ElememtSize(size: widget.size).getButtonPadding(),
          decoration: boxDecoration,
          child: Builder(
            builder: (context) {
              return calculateButtonContent(
                text: widget.text,
                icon: widget.icon,
                suffixIcon: widget.suffixIcon,
                child: widget.child,
                loading: widget.loading || isLoading,
                type: widget.type,
                color: buttonColor,
                isPlain: widget.isPlain,
                isLink: widget.isLink,
                isDisabled: widget.isDisabled,
                isActive: isHovered,
                size: widget.size,
                fontSize: widget.fontSize,
                onSuffixPressed: widget.onSuffixPressed,
              );
            },
          ),
        ),
      ),
    );

    return btn;
  }
}
