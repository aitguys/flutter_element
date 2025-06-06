import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/components/button/button.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

class ETag extends StatefulWidget {
  // content
  final String text;
  final Widget? child;
  // styles
  final EColorType type;
  final ESizeItem size;
  final bool closable;
  final bool isPlain;
  final bool isRound;
  final bool isCircle;
  final Color? color;
  final Color? backgroundColor;
  final double? borderRadius;
  final Widget? icon;
  final double? fontSize;
  // events
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final VoidCallback? onHover;
  final VoidCallback? onClose;

  const ETag({
    super.key,
    required this.text,
    this.onPressed,
    this.onLongPressed,
    this.onHover,
    this.type = EColorType.primary,
    this.isPlain = true,
    this.isRound = false,
    this.isCircle = false,
    this.size = ESizeItem.medium,
    this.closable = false,
    this.color,
    this.backgroundColor,
    this.onClose,
    this.icon,
    this.borderRadius,
    this.child,
    this.fontSize,
  });

  @override
  State<ETag> createState() => _ETagState();
}

class _ETagState extends State<ETag> {
  @override
  Widget build(BuildContext context) {
    return EButton(
      text: widget.text,
      onPressed: widget.onPressed,
      onLongPressed: widget.onLongPressed,
      type: widget.type,
      isPlain: widget.isPlain,
      isRound: widget.isRound,
      isCircle: widget.isCircle,
      size: widget.size,
      icon: widget.icon is Icon ? (widget.icon as Icon).icon : null,
      color: widget.color,
      fontSize: widget.fontSize,
      suffixIcon: widget.closable ? Icons.close : null,
      onSuffixPressed: widget.onClose,
      child: widget.child,
    );
  }
}
