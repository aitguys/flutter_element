import 'package:flutter/material.dart';
import 'dart:math';

enum RefreshHeaderMode { idle, drag, armed, refresh, done }

/// 限制顶部下拉的最大回弹距离为 [maxOverscroll]
class MaxOverscrollPhysics extends ScrollPhysics {
  final double maxOverscroll;
  final bool holdAtTop;
  final double holdExtent; // 正值，表示期望顶部悬停的可见高度

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
    // 先让父级处理（平台/外部 physics 的边界），若父级阻止则尊重父级
    if (parent != null) {
      final parentResult = parent!.applyBoundaryConditions(position, value);
      if (parentResult != 0.0) return parentResult;
    }

    // 自定义顶部边界：
    // 刷新/展示 done 期间固定在 holdExtent，其他时候允许到 maxOverscroll
    final double limit = holdAtTop ? holdExtent : maxOverscroll;
    final double customTopBoundary =
        position.minScrollExtent - limit; // 通常 min 为 0

    // 试图越过我们自定义的顶部边界
    if (value < customTopBoundary && position.pixels >= customTopBoundary) {
      return value - customTopBoundary;
    }
    // 已经在自定义边界之外，且继续往外移动，全部拦截
    if (value < position.pixels && position.pixels < customTopBoundary) {
      return value - position.pixels;
    }
    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // 刷新/展示 done 期间，如果在顶部区域，尽量维持在 -holdExtent，形成“悬停”
    if (holdAtTop && position.pixels < position.minScrollExtent) {
      final double target = position.minScrollExtent - holdExtent;
      if ((position.pixels - target).abs() < toleranceFor(position).distance) {
        return parent?.createBallisticSimulation(position, velocity);
      }
    }
    return parent?.createBallisticSimulation(position, velocity) ??
        super.createBallisticSimulation(position, velocity);
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
  // 偏移阈值
  final double offsetThresholdMin;
  final double offsetThresholdMax;

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
    this.offsetThresholdMin = 40.0,
    this.offsetThresholdMax = 80.0,
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
        // 关闭悬停保持，并在 done 显示后再回到顶部
        setState(() {
          _refreshing = false;
        });
        if (_controller.hasClients) {
          await _controller.animateTo(
            0.0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );
        }
        if (mounted) {
          setState(() {
            _dragOffset = 0.0;
            _refreshMode = RefreshHeaderMode.idle;
          });
        }
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
      physics: MaxOverscrollPhysics(
        maxOverscroll: widget.offsetThresholdMax,
        holdAtTop: _refreshing ||
            _refreshMode == RefreshHeaderMode.refresh ||
            _refreshMode == RefreshHeaderMode.done,
        holdExtent: widget.offsetThresholdMin,
        parent: widget.physics ?? const AlwaysScrollableScrollPhysics(),
      ),
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
          if (notification is ScrollUpdateNotification) {
            if (notification.dragDetails != null) {
              if (_dragOffset < widget.offsetThresholdMin) {
                setState(() {
                  _refreshMode = RefreshHeaderMode.drag;
                });
              } else if (_dragOffset >= widget.offsetThresholdMin) {
                setState(() {
                  _refreshMode = RefreshHeaderMode.armed;
                });
              }
              setState(() {
                _dragOffset = metrics.pixels.abs();
              });
            } else {
              // 用户松手了
              if (_dragOffset >= widget.offsetThresholdMin) {
                setState(() {
                  _refreshMode = RefreshHeaderMode.refresh;
                });
                _handleRefresh().then((value) {
                  setState(() {
                    _refreshMode = RefreshHeaderMode.done;
                  });
                });
              } else {
                setState(() {
                  _dragOffset = 0.0;
                  _refreshMode = RefreshHeaderMode.idle;
                });
              }
            }
          }
        }
        return false;
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          listView,
          Container(
            height: min(_dragOffset, widget.offsetThresholdMax),
            child: _buildCustomHeader(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    // 如果传入了 refreshHeaderBuilder，使用它；否则用默认的
    if (widget.refreshHeaderBuilder != null) {
      return widget.refreshHeaderBuilder!(context, _refreshMode, _dragOffset);
    }
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
