import 'package:flutter/material.dart';

enum ECardShadow { always, hover, never }

class ECard extends StatefulWidget {
  final Widget? header;
  final Widget? footer;
  final Widget? child;
  final BoxDecoration? bodyStyle;
  final String? headerClass;
  final String? bodyClass;
  final String? footerClass;
  final ECardShadow shadow;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const ECard({
    super.key,
    this.header,
    this.footer,
    this.child,
    this.bodyStyle,
    this.headerClass,
    this.bodyClass,
    this.footerClass,
    this.shadow = ECardShadow.always,
    this.margin,
    this.padding,
    this.width,
    this.height,
  });

  @override
  State<ECard> createState() => _ECardState();
}

class _ECardState extends State<ECard> {
  bool _isHover = false;

  BoxShadow? get _boxShadow {
    if (widget.shadow == ECardShadow.never) return null;
    if (widget.shadow == ECardShadow.hover && !_isHover) return null;
    return const BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE4E7ED), width: 1),
        boxShadow: _boxShadow != null ? [_boxShadow!] : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.header != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: widget.header,
            ),
          Container(
            padding: widget.padding ?? const EdgeInsets.all(16),
            decoration: widget.bodyStyle,
            child: widget.child,
          ),
          if (widget.footer != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: widget.footer,
            ),
        ],
      ),
    );
    if (widget.shadow == ECardShadow.hover) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHover = true),
        onExit: (_) => setState(() => _isHover = false),
        child: card,
      );
    }
    return card;
  }
}
