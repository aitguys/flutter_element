import 'package:flutter/material.dart';

enum ECarouselDirection { horizontal, vertical }

enum ECarouselArrow { always, hover, never }

typedef CarouselChangeCallback = void Function(int newIndex, int oldIndex);

class ECarousel extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final int initialIndex;
  final bool autoplay;
  final Duration interval;
  final ECarouselDirection direction;
  final bool loop;
  final bool showIndicator;
  final ECarouselArrow arrow;
  final CarouselChangeCallback? onChange;

  const ECarousel({
    Key? key,
    required this.items,
    this.height = 200,
    this.initialIndex = 0,
    this.autoplay = true,
    this.interval = const Duration(seconds: 3),
    this.direction = ECarouselDirection.horizontal,
    this.loop = true,
    this.showIndicator = true,
    this.arrow = ECarouselArrow.hover,
    this.onChange,
  }) : super(key: key);

  @override
  State<ECarousel> createState() => _ECarouselState();
}

class _ECarouselState extends State<ECarousel> {
  late PageController _controller;
  late int _currentIndex;
  // bool _showArrow = false;
  late List<Widget> _items;
  late bool _isHover;
  // late bool _isAutoPlaying;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: _currentIndex);
    _items = widget.items;
    _isHover = false;
    // _isAutoPlaying = widget.autoplay;
    if (widget.autoplay) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoPlay());
    }
  }

  void _startAutoPlay() async {
    while (mounted && widget.autoplay) {
      await Future.delayed(widget.interval);
      if (!_isHover) {
        _nextPage();
      }
    }
  }

  void _nextPage() {
    int next = _currentIndex + 1;
    if (next >= _items.length) {
      if (widget.loop) {
        next = 0;
      } else {
        return;
      }
    }
    _animateToPage(next);
  }

  void _prevPage() {
    int prev = _currentIndex - 1;
    if (prev < 0) {
      if (widget.loop) {
        prev = _items.length - 1;
      } else {
        return;
      }
    }
    _animateToPage(prev);
  }

  void _animateToPage(int index) {
    if (index == _currentIndex) return;
    widget.onChange?.call(index, _currentIndex);
    setState(() {
      _currentIndex = index;
    });
    _controller.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontal = widget.direction == ECarouselDirection.horizontal;
    final showArrow = widget.arrow == ECarouselArrow.always ||
        (widget.arrow == ECarouselArrow.hover && _isHover);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: widget.height,
            child: PageView.builder(
              controller: _controller,
              scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
              itemCount: _items.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
                widget.onChange?.call(index, _currentIndex);
              },
              itemBuilder: (context, index) {
                return _items[index];
              },
            ),
          ),
          if (showArrow)
            Positioned(
              left: 8,
              child: _buildArrowButton(Icons.chevron_left, _prevPage),
            ),
          if (showArrow)
            Positioned(
              right: 8,
              child: _buildArrowButton(Icons.chevron_right, _nextPage),
            ),
          if (widget.showIndicator)
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_items.length, (i) {
                  final isActive = i == _currentIndex;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildArrowButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 4,
              ),
            ],
          ),
          child: Icon(icon, color: Colors.black54),
        ),
      ),
    );
  }
}
