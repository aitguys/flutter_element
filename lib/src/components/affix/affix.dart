import 'package:flutter/material.dart';

class EAffix extends StatefulWidget {
  final double? offsetTop;
  final double? offsetBottom;
  final int? zIndex;
  final Widget child;
  final VoidCallback? onChange;

  const EAffix({
    Key? key,
    this.offsetTop,
    this.offsetBottom,
    this.zIndex,
    required this.child,
    this.onChange,
  }) : super(key: key);

  @override
  State<EAffix> createState() => _EAffixState();
}

class _EAffixState extends State<EAffix> {
  final GlobalKey _key = GlobalKey();
  double? _top;
  double? _bottom;
  bool _affixed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updatePosition());
  }

  void _updatePosition() {
    final RenderBox? box =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (box != null && mounted) {
      final offset = box.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.of(context).size.height;
      bool shouldAffix = false;
      if (widget.offsetTop != null) {
        shouldAffix = offset.dy <= (widget.offsetTop ?? 0);
      } else if (widget.offsetBottom != null) {
        shouldAffix = offset.dy + box.size.height >=
            screenHeight - (widget.offsetBottom ?? 0);
      }
      if (shouldAffix != _affixed) {
        setState(() {
          _affixed = shouldAffix;
        });
        widget.onChange?.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _updatePosition());
    return Stack(
      children: [
        Opacity(
          opacity: _affixed ? 0 : 1,
          child: Container(key: _key, child: widget.child),
        ),
        if (_affixed)
          Positioned(
            top: widget.offsetTop,
            left: 0,
            right: 0,
            child: Material(
              elevation: widget.zIndex?.toDouble() ?? 0,
              child: widget.child,
            ),
          ),
      ],
    );
  }
}
