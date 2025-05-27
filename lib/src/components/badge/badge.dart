import 'package:flutter/material.dart';

/// A badge component that follows Element Plus design guidelines.
///
/// The [EBadge] widget provides a small badge that can be used to display
/// notifications, counts, or status indicators. It can be used as a standalone
/// element or attached to other widgets.
///
/// ## Example
///
/// ```dart
/// // Badge with a number
/// EBadge(
///   value: 5,
///   max: 99,
///   child: Icon(Icons.notifications),
/// )
///
/// // Dot badge
/// EBadge(
///   isDot: true,
///   type: 'danger',
///   child: Icon(Icons.mail),
/// )
///
/// // Custom styled badge
/// EBadge(
///   value: 'New',
///   color: Colors.purple,
///   textStyle: TextStyle(color: Colors.white),
///   badgeStyle: BoxDecoration(
///     borderRadius: BorderRadius.circular(10),
///   ),
///   child: Text('Messages'),
/// )
/// ```
class EBadge extends StatelessWidget {
  /// The value to display in the badge.
  /// This can be a number or a string.
  /// If null and [isDot] is false, no badge will be shown.
  final dynamic value;

  /// The maximum value to display.
  /// If [value] exceeds this number, it will be displayed as "{max}+".
  /// Only applies when [value] is a number.
  final int? max;

  /// Whether to display the badge as a dot.
  /// When true, [value] will be ignored and a small dot will be shown instead.
  final bool isDot;

  /// Whether to hide the badge.
  /// When true, no badge will be shown regardless of other properties.
  final bool hidden;

  /// The type of badge, which determines its color scheme.
  /// Available types: 'primary', 'success', 'warning', 'danger', 'info'.
  /// If not provided, the default color will be used.
  final String? type;

  /// Whether to show the badge when [value] is 0.
  /// When false, the badge will be hidden when [value] is 0.
  /// Only applies when [value] is a number.
  final bool showZero;

  /// A custom color for the badge.
  /// If provided, this overrides the color determined by [type].
  final Color? color;

  /// The offset of the badge from its child.
  /// This is a list of two numbers: [x, y] offset in logical pixels.
  final List<double>? offset;

  /// Custom text style for the badge value.
  /// If not provided, a default style will be used.
  final TextStyle? textStyle;

  /// Custom decoration for the badge.
  /// If provided, this overrides the default badge appearance.
  final BoxDecoration? badgeStyle;

  /// The widget to attach the badge to.
  /// If null, the badge will be displayed as a standalone element.
  final Widget? child;

  const EBadge({
    super.key,
    this.value,
    this.max,
    this.isDot = false,
    this.hidden = false,
    this.type,
    this.showZero = true,
    this.color,
    this.offset,
    this.textStyle,
    this.badgeStyle,
    this.child,
  });

  Color get _bgColor {
    if (color != null) return color!;
    switch (type) {
      case 'primary':
        return const Color(0xFF409EFF);
      case 'success':
        return const Color(0xFF67C23A);
      case 'warning':
        return const Color(0xFFE6A23C);
      case 'danger':
        return const Color(0xFFF56C6C);
      case 'info':
        return const Color(0xFF909399);
      default:
        return const Color(0xFFF56C6C);
    }
  }

  String? get _displayValue {
    if (value == null) return null;
    if (value is num && max != null && value > max!) {
      return '${max!}+';
    }
    return value.toString();
  }

  bool get _showBadge {
    if (hidden) return false;
    if (isDot) return true;
    if (value == null) return false;
    if (value == 0 && !showZero) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (!_showBadge) return child ?? const SizedBox();
    Widget badge = isDot
        ? Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _bgColor,
              shape: BoxShape.circle,
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: badgeStyle ??
                BoxDecoration(
                  color: _bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
            child: Text(
              _displayValue ?? '',
              style: textStyle ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          );
    if (offset != null && offset!.length == 2) {
      badge = Transform.translate(
        offset: Offset(offset![0], offset![1]),
        child: badge,
      );
    }
    if (child == null) return badge;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child!,
        Positioned(
          right: -4,
          top: -4,
          child: badge,
        ),
      ],
    );
  }
}
