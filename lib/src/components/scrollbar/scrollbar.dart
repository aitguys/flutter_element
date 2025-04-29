import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';

class EScrollbar extends StatefulWidget {
  final Widget child;
  final double? height;
  final double? maxHeight;
  final bool native;
  final bool always;
  final double minSize;
  final bool horizontal; // Add horizontal scrollbar property

  final Function(ScrollController)? onScroll;

  const EScrollbar({
    super.key,
    required this.child,
    this.height,
    this.maxHeight,
    this.native = false,
    this.always = false,
    this.minSize = 20,
    this.horizontal = false, // Default to false
    this.onScroll,
  });

  @override
  State<EScrollbar> createState() => _EScrollbarState();
}

class _EScrollbarState extends State<EScrollbar> {
  final ScrollController _scrollController = ScrollController();
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (widget.onScroll != null) {
      widget.onScroll!(_scrollController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        height: widget.height,
        constraints: BoxConstraints(
          maxHeight: widget.maxHeight ?? double.infinity,
        ),
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: widget.always || _isHovered,
          thickness: widget.native ? null : 6,
          radius: widget.native ? null : const Radius.circular(3),
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection:
                widget.horizontal ? Axis.horizontal : Axis.vertical,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
