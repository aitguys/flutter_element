import 'package:flutter/material.dart';

class EBadge extends StatelessWidget {
  final dynamic value; // String/num
  final int? max;
  final bool isDot;
  final bool hidden;
  final String? type; // 'primary', 'success', 'warning', 'danger', 'info'
  final bool showZero;
  final Color? color;
  final List<double>? offset; // [x, y]
  final TextStyle? textStyle;
  final BoxDecoration? badgeStyle;
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
