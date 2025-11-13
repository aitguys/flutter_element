import 'package:flutter/material.dart';
import 'dart:math';

enum RefreshHeaderMode { idle, drag, armed, refresh, done }

/// 控制EList组件的Key与方法
class EListController extends ChangeNotifier {
  _EListState? _state;

  /// 主动触发刷新
  Future<void> refresh() async {
    await _state?._handleRefresh();
  }

  /// 主动触发下拉刷新UI（动画拉下，之后会触发刷新）
  Future<void> triggerPullDown() async {
    if (_state == null) return;
    final state = _state!;
    final widget = state.widget;
    if (!widget.enablePullDown || widget.onRefresh == null) return;
    // 直接设置至阈值并切换状态
    state._dragOffset = widget.offsetThresholdMin + 1; // 确保超阈值
    state._refreshMode = RefreshHeaderMode.refresh;
    await state._handleRefresh();
  }

  /// 可补充更多控制方法
}

class MaxOverscrollPhysics extends ScrollPhysics {
  final double maxOverscroll;
  final bool holdAtTop;
  final double holdExtent; // 正值，表示期望顶部悬停的可见高度

  const MaxOverscrollPhysics({
    required this.maxOverscroll,
    this.holdAtTop = false,
    this.holdExtent = 0.0,
    super.parent,
  });

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
    final double customTopBoundary = position.minScrollExtent - limit;

    if (value < customTopBoundary && position.pixels >= customTopBoundary) {
      return value - customTopBoundary;
    }
    if (value < position.pixels && position.pixels < customTopBoundary) {
      return value - position.pixels;
    }
    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
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
  final double offsetThresholdMin;
  final double offsetThresholdMax;

  /// 供外部控制EList如刷新等
  final EListController? controller;

  /// 自定义刷新头构建器 (context, mode, offset)
  final Widget Function(
          BuildContext context, RefreshHeaderMode mode, double offset)?
      refreshHeaderBuilder;

  /// 是否为初始化加载状态
  final bool initLoading;

  /// 自定义初始化加载动画
  final Widget? initLoadingWidget;

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
    this.controller,
    this.initLoading = false,
    this.initLoadingWidget,
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

  // 用于下拉截流的变量
  double? _lastDragDy;
  int? _lastDragTime; // 毫秒时间戳

  // 每多少ms/px的速度就视为快速滑动（如5000px/s，按惯用人手滑动阈值可调）
  static const double _quickFlingThreshold = 5500.0;

  bool _isQuickFling(DragUpdateDetails details) {
    final now = DateTime.now().millisecondsSinceEpoch;
    double speed = 0;
    if (_lastDragDy != null && _lastDragTime != null) {
      // 计算dy的变化和时间差，速度px/ms，再转px/s
      final deltaDy = details.primaryDelta ?? 0;
      final deltaTime = now - _lastDragTime!;
      if (deltaTime > 0) {
        speed = (deltaDy / deltaTime) * 1000; // px/s
        // 取绝对值，因为往下拉是正数
        speed = speed.abs();
      }
    }
    _lastDragDy = details.primaryDelta;
    _lastDragTime = now;

    // 只要每一次dy瞬时速度>阈值就判为快速
    return speed > _quickFlingThreshold;
  }

  @override
  void initState() {
    super.initState();
    _currentPage = widget.currentPage;
    _items = List<Widget>.from(widget.children);
    _hasMore = widget.hasMore;
    _controller = ScrollController();
    _controller.addListener(_onScroll);

    // 绑定controller到当前state实例
    widget.controller?._state = this;
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
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._state = null;
      widget.controller?._state = this;
    }
  }

  @override
  void dispose() {
    widget.controller?._state = null;
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
    });
    try {
      await widget.onRefresh!();
      if (mounted) {
        setState(() {
          _currentPage = widget.currentPage;
          _hasMore = widget.hasMore;
          _items = List<Widget>.from(widget.children);
          _refreshMode = RefreshHeaderMode.done;
        });
      }
      await Future.delayed(const Duration(milliseconds: 500));
    } finally {
      if (mounted) {
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

  Widget _buildInitLoadingWidget() {
    return widget.initLoadingWidget ??
        const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: CircularProgressIndicator(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    // 新增：初始化加载
    if (widget.initLoading) {
      return _buildInitLoadingWidget();
    }

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

    if (!widget.enablePullDown || widget.onRefresh == null) {
      return listView;
    }

    bool skipPullDown = false; // 局部变量用于安全标记本frame

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        final metrics = notification.metrics;

        // 只要不是负数就清理滑动速率历史
        if (metrics.pixels >= 0) {
          _lastDragDy = null;
          _lastDragTime = null;
          skipPullDown = false;
        }

        if (metrics.pixels < 0) {
          if (notification is ScrollUpdateNotification) {
            // 检查快速fling场景，若为快速fling顶部，则不响应下拉逻辑
            if (notification.dragDetails != null) {
              if (_isQuickFling(notification.dragDetails!)) {
                skipPullDown = true;
                // 只要判定为快速fling就直接return，不进入下拉刷新流程
                return false;
              }
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
              if (skipPullDown) {
                // 本次fling已判定为快速fling, 跳过
                setState(() {
                  _dragOffset = 0.0;
                  _refreshMode = RefreshHeaderMode.idle;
                });
                return false;
              }
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
          SizedBox(
            height: min(_dragOffset, widget.offsetThresholdMax),
            child: _buildCustomHeader(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    if (widget.refreshHeaderBuilder != null) {
      return widget.refreshHeaderBuilder!(context, _refreshMode, _dragOffset);
    }
    switch (_refreshMode) {
      case RefreshHeaderMode.drag:
        return const Center(child: Text("Continue to pull down"));
      case RefreshHeaderMode.armed:
        return const Center(child: Text("Release to refresh"));
      case RefreshHeaderMode.refresh:
        return const Center(child: CircularProgressIndicator());
      case RefreshHeaderMode.done:
        return const Center(child: Text("Refresh Successfully"));
      default:
        return const SizedBox.shrink();
    }
  }
}
