import 'package:flutter/material.dart';

enum RefreshHeaderMode { idle, drag, armed, refresh, done }

class MaxOverscrollPhysics extends ScrollPhysics {
  final double maxOverscroll;
  final bool holdAtTop;
  final double holdExtent;

  const MaxOverscrollPhysics({
    required this.maxOverscroll,
    this.holdAtTop = false,
    this.holdExtent = 0.0,
    ScrollPhysics? parent,
  }) : super(parent: parent);

  @override
  MaxOverscrollPhysics applyTo(ScrollPhysics? ancestor) {
    return MaxOverscrollPhysics(
      maxOverscroll: maxOverscroll,
      holdAtTop: holdAtTop,
      holdExtent: holdExtent,
      parent: buildParent(ancestor),
    );
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (parent != null) {
      final parentResult = parent!.applyBoundaryConditions(position, value);
      if (parentResult != 0.0) return parentResult;
    }

    final double limit = holdAtTop ? holdExtent : maxOverscroll;
    final double topBoundary = position.minScrollExtent - limit;

    if (value < topBoundary && position.pixels >= topBoundary) {
      return value - topBoundary;
    }
    if (value < position.pixels && position.pixels < topBoundary) {
      return value - position.pixels;
    }
    return 0.0;
  }
}

class EList extends StatefulWidget {
  final List<Widget> children;
  final int currentPage;
  final Future<void> Function()? onRefresh;
  final Future<List<Widget>> Function(int page)? onLoadMore;
  final bool hasMore;
  final Widget? loadingWidget;
  final Widget? noMoreWidget;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Axis scrollDirection;
  final bool reverse;
  final bool enablePullDown;
  final double offsetThresholdMin;
  final double offsetThresholdMax;
  final Widget Function(
          BuildContext context, RefreshHeaderMode mode, double offset)?
      refreshHeaderBuilder;
  final bool headerPinnedToTop;

  const EList({
    super.key,
    required this.children,
    this.currentPage = 1,
    this.onRefresh,
    this.onLoadMore,
    this.hasMore = true,
    this.loadingWidget,
    this.noMoreWidget,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.enablePullDown = true,
    this.refreshHeaderBuilder,
    this.offsetThresholdMin = 60,
    this.offsetThresholdMax = 120,
    this.headerPinnedToTop = false,
  });

  @override
  State<EList> createState() => _EListState();
}

class _EListState extends State<EList> with TickerProviderStateMixin {
  late ScrollController _controller;
  List<Widget> _items = [];
  bool _loading = false;
  bool _hasMore = true;
  int _currentPage = 1;

  double _dragOffset = 0.0;
  double _headerHeight = 0.0;
  bool _refreshing = false;
  RefreshHeaderMode _refreshMode = RefreshHeaderMode.idle;

  late AnimationController _headerAnimController;
  late Animation<double> _headerAnim;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
    _items = List.from(widget.children);
    _currentPage = widget.currentPage;
    _hasMore = widget.hasMore;

    _headerAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _headerAnim = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _headerAnimController, curve: Curves.easeOut),
    )..addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(EList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.children != widget.children)
      _items = List.from(widget.children);
    if (oldWidget.hasMore != widget.hasMore) _hasMore = widget.hasMore;
    if (oldWidget.currentPage != widget.currentPage)
      _currentPage = widget.currentPage;
  }

  @override
  void dispose() {
    _controller.dispose();
    _headerAnimController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_loading && _hasMore && widget.onLoadMore != null) {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 100) {
        _loadMore();
      }
    }
  }

  Future<void> _loadMore() async {
    if (_loading || !_hasMore) return;
    setState(() => _loading = true);
    try {
      final nextPage = _currentPage + 1;
      final newItems = await widget.onLoadMore?.call(nextPage);
      if (mounted && newItems != null) {
        setState(() {
          _items.addAll(newItems);
          _currentPage = nextPage;
          if (newItems.isEmpty) _hasMore = false;
        });
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _handleRefresh() async {
    if (widget.onRefresh == null) return;

    setState(() {
      _refreshing = true;
      _refreshMode = RefreshHeaderMode.refresh;
    });

    try {
      await widget.onRefresh?.call();
      if (mounted) {
        setState(() {
          _items = List.from(widget.children);
          _currentPage = widget.currentPage;
          _hasMore = widget.hasMore;
          _refreshMode = RefreshHeaderMode.done;
        });
      }
    } finally {
      if (!mounted) return;
      // 完成后立即隐藏
      _animateHeaderHide(immediate: true);
    }
  }

  void _animateHeaderHide({bool immediate = false}) {
    if (immediate) {
      setState(() {
        _dragOffset = 0;
        _headerHeight = 0;
        _refreshing = false;
        _refreshMode = RefreshHeaderMode.idle;
      });
      return;
    }

    _headerAnim = Tween<double>(begin: _headerHeight, end: 0).animate(
      CurvedAnimation(parent: _headerAnimController, curve: Curves.easeOut),
    );
    _headerAnimController.forward(from: 0).whenComplete(() {
      if (mounted) {
        setState(() {
          _dragOffset = 0;
          _headerHeight = 0;
          _refreshing = false;
          _refreshMode = RefreshHeaderMode.idle;
        });
      }
    });
  }

  void _triggerRefresh() {
    setState(() => _refreshMode = RefreshHeaderMode.refresh);
    _handleRefresh();
  }

  Widget _buildAnimatedHeader(BuildContext context) {
    double height;
    if (widget.headerPinnedToTop) {
      height = _dragOffset.clamp(0.0, widget.offsetThresholdMax);
      if (_refreshing || _refreshMode == RefreshHeaderMode.refresh) {
        height = widget.offsetThresholdMin;
      }
    } else {
      height = (_refreshing ||
              _refreshMode == RefreshHeaderMode.refresh ||
              _refreshMode == RefreshHeaderMode.done)
          ? widget.offsetThresholdMin
          : _dragOffset.clamp(0.0, widget.offsetThresholdMax);
    }

    if (_headerAnimController.isAnimating) height = _headerAnim.value;

    _headerHeight = height;

    return SizedBox(
      height: height,
      child: widget.refreshHeaderBuilder != null
          ? widget.refreshHeaderBuilder!(context, _refreshMode, _headerHeight)
          : _defaultHeader(context),
    );
  }

  Widget _defaultHeader(BuildContext context) {
    switch (_refreshMode) {
      case RefreshHeaderMode.drag:
        return const Center(child: Text("下拉刷新", key: ValueKey(1)));
      case RefreshHeaderMode.armed:
        return const Center(child: Text("松开刷新", key: ValueKey(2)));
      case RefreshHeaderMode.refresh:
        return const Center(child: CircularProgressIndicator(key: ValueKey(3)));
      case RefreshHeaderMode.done:
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseListView = ListView.builder(
      controller: _controller,
      padding: widget.padding,
      physics: MaxOverscrollPhysics(
        maxOverscroll: widget.offsetThresholdMax,
        holdAtTop: _refreshing ||
            _refreshMode == RefreshHeaderMode.refresh ||
            _refreshMode == RefreshHeaderMode.done,
        holdExtent: widget.offsetThresholdMin,
        parent: widget.physics ?? const AlwaysScrollableScrollPhysics(),
      ),
      itemCount: _items.length + 1,
      itemBuilder: (context, index) {
        if (index < _items.length) return _items[index];
        if (_loading)
          return widget.loadingWidget ??
              const Center(child: CircularProgressIndicator());
        if (!_hasMore) return widget.noMoreWidget ?? const SizedBox.shrink();
        return const SizedBox.shrink();
      },
    );

    if (!widget.enablePullDown || widget.onRefresh == null) return baseListView;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;

        if (metrics.pixels < 0 && notification is ScrollUpdateNotification) {
          if (notification.dragDetails != null) {
            setState(() {
              _dragOffset = widget.headerPinnedToTop
                  ? (-metrics.pixels).clamp(0.0, widget.offsetThresholdMax)
                  : metrics.pixels.abs();

              _refreshMode = _dragOffset < widget.offsetThresholdMin
                  ? RefreshHeaderMode.drag
                  : RefreshHeaderMode.armed;
            });
          } else {
            if (_dragOffset >= widget.offsetThresholdMin)
              _triggerRefresh();
            else
              _animateHeaderHide();
          }
        }

        return false;
      },
      child: widget.headerPinnedToTop
          ? ListView.builder(
              controller: _controller,
              padding: widget.padding,
              physics: MaxOverscrollPhysics(
                maxOverscroll: widget.offsetThresholdMax,
                holdAtTop: _refreshing ||
                    _refreshMode == RefreshHeaderMode.refresh ||
                    _refreshMode == RefreshHeaderMode.done,
                holdExtent: widget.offsetThresholdMin,
                parent: widget.physics ?? const AlwaysScrollableScrollPhysics(),
              ),
              itemCount: _items.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) return _buildAnimatedHeader(context);
                if (index <= _items.length) return _items[index - 1];
                if (_loading)
                  return widget.loadingWidget ??
                      const Center(child: CircularProgressIndicator());
                if (!_hasMore)
                  return widget.noMoreWidget ?? const SizedBox.shrink();
                return const SizedBox.shrink();
              },
            )
          : Stack(
              alignment: Alignment.topCenter,
              children: [
                baseListView,
                _buildAnimatedHeader(context),
              ],
            ),
    );
  }
}
