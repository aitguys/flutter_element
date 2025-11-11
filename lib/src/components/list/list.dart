import 'package:flutter/material.dart';

enum RefreshHeaderMode { idle, drag, armed, refresh, done }

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
  // 偏移阈值
  final double offsetThreshold;

  /// 自定义刷新头构建器 (context, mode, offset)
  final Widget Function(
          BuildContext context, RefreshHeaderMode mode, double offset)?
      refreshHeaderBuilder;

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
    this.offsetThreshold = 40.0,
  });

  @override
  State<EList> createState() => _EListState();
}

class _EListState extends State<EList> {
  late ScrollController _controller;
  bool _loading = false;
  int _currentPage = 1;
  List<Widget> _items = [];
  bool _hasMore = true;

  // refresh visuals
  RefreshHeaderMode _refreshMode = RefreshHeaderMode.idle;
  double _dragOffset = 0.0; // px
  final double _triggerDistance = 80.0; // 触发刷新的距离阈值
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.currentPage;
    _items = List<Widget>.from(widget.children);
    _hasMore = widget.hasMore;
    _controller = ScrollController();
    _controller.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(EList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.children != widget.children) {
      _items = List<Widget>.from(widget.children);
    }
    if (oldWidget.currentPage != widget.currentPage) {
      _currentPage = widget.currentPage;
    }
    if (oldWidget.hasMore != widget.hasMore) {
      _hasMore = widget.hasMore;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
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
    } catch (e) {
      debugPrint('Error loading more items: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // 实际刷新由 RefreshIndicator 调用
  Future<void> _handleRefresh() async {
    if (widget.onRefresh == null) return;
    setState(() {
      _refreshing = true;
      _refreshMode = RefreshHeaderMode.refresh;
      // 保持 header 显示
    });
    try {
      await widget.onRefresh!();
      // 刷新完成
      if (mounted) {
        setState(() {
          _currentPage = widget.currentPage;
          _hasMore = widget.hasMore;
          _items = List<Widget>.from(widget.children);
          _refreshMode = RefreshHeaderMode.done;
        });
      }
      // 给用户看到 done 一会儿
      await Future.delayed(const Duration(milliseconds: 500));
    } finally {
      if (mounted) {
        setState(() {
          _refreshing = false;
          _dragOffset = 0;
          _refreshMode = RefreshHeaderMode.idle;
        });
      }
    }
  }

  Widget _buildNoMoreWidget() {
    return widget.noMoreWidget ??
        const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text('没有更多了', style: TextStyle(color: Colors.grey)),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    // 当无数据且无更多时显示 noMore
    if (!_hasMore && _items.isEmpty) {
      return _buildNoMoreWidget();
    }

    final listView = ListView.builder(
      controller: _controller,
      padding: widget.padding,
      physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
      shrinkWrap: widget.shrinkWrap,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      itemCount: _items.length + 1,
      itemBuilder: (context, index) {
        if (index < _items.length) return _items[index];
        if (_loading) {
          return widget.loadingWidget ??
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
        } else if (!_hasMore) {
          return _buildNoMoreWidget();
        } else {
          return const SizedBox.shrink();
        }
      },
    );

    // 如果没有启用下拉或没有 onRefresh，则直接返回 list
    if (!widget.enablePullDown || widget.onRefresh == null) {
      return listView;
    }

    // 使用 RefreshIndicator 提供稳定的下拉刷新触发
    // 使用 NotificationListener 收集下拉偏移量用于自定义 header 展示（不干扰手势）
    // https://api.flutter.dev/flutter/widgets/ScrollNotification-class.html
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        // print(
        //     'notification: ${notification},${notification.metrics.hasPixels}, Date: ${DateTime.now()}');
        final metrics = notification.metrics;
        if (metrics.pixels < 0) {
          // 下拉刷新
          setState(() {
            _dragOffset = metrics.pixels.abs();
          });
        }

        if (notification is ScrollUpdateNotification) {
          print(notification.dragDetails);
          if (notification.dragDetails != null) {
            if (_dragOffset < widget.offsetThreshold) {
              setState(() {
                _refreshMode = RefreshHeaderMode.drag;
              });
            } else if (_dragOffset >= widget.offsetThreshold) {
              setState(() {
                _refreshMode = RefreshHeaderMode.armed;
              });
            }
          } else {
            // 用户松手了
            setState(() {
              _refreshMode = RefreshHeaderMode.refresh;
            });
            _handleRefresh().then((value) {
              setState(() {
                _refreshMode = RefreshHeaderMode.done;
              });
            });
          }
        } else if (notification is ScrollEndNotification &&
            _dragOffset <= 80 &&
            !_refreshing) {
          setState(() {
            _dragOffset = 0.0;
            _refreshMode = RefreshHeaderMode.idle;
          });
        }
        return false;
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          listView,
          // 顶部下拉头部
          if (_dragOffset > 0)
            Positioned(
              top: -80 + _dragOffset,
              left: 0,
              right: 0,
              child: _buildCustomHeader(context),
            ),
        ],
      ),
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    switch (_refreshMode) {
      case RefreshHeaderMode.drag:
        return const Center(child: Text("继续下拉"));
      case RefreshHeaderMode.armed:
        return const Center(child: Text("松开刷新"));
      case RefreshHeaderMode.refresh:
        return const Center(child: CircularProgressIndicator());
      case RefreshHeaderMode.done:
        return const Center(child: Text("刷新完成"));
      default:
        return const SizedBox.shrink();
    }
  }
}
