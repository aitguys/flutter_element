import 'package:flutter/material.dart';

class EBackTop extends StatefulWidget {
  final double? visibilityHeight;
  final Duration? transitionDuration;
  final Widget? child;
  final double? right;
  final double? bottom;
  final VoidCallback? onClick;
  final Curve curve;
  final ScrollController? controller;

  const EBackTop({
    Key? key,
    this.visibilityHeight = 200.0,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.child,
    this.right = 40.0,
    this.bottom = 40.0,
    this.onClick,
    this.curve = Curves.easeInOut,
    this.controller,
  }) : super(key: key);

  @override
  State<EBackTop> createState() => _EBackTopState();
}

class _EBackTopState extends State<EBackTop> {
  late ScrollController _scrollController;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_onScroll);
    }
    super.dispose();
  }

  void _onScroll() {
    final newVisible =
        _scrollController.offset >= (widget.visibilityHeight ?? 200);
    if (newVisible != _visible) {
      setState(() {
        _visible = newVisible;
      });
    }
  }

  void _scrollToTop() {
    widget.onClick?.call();
    _scrollController.animateTo(
      0,
      duration: widget.transitionDuration ?? const Duration(milliseconds: 300),
      curve: widget.curve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: widget.transitionDuration ?? const Duration(milliseconds: 300),
      right: widget.right,
      bottom: _visible ? widget.bottom : -(widget.bottom ?? 40.0),
      child: GestureDetector(
        onTap: _scrollToTop,
        child: widget.child ??
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
      ),
    );
  }
}
