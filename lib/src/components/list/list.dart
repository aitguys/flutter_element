import 'package:flutter/material.dart';
// import 'package:flutter/physics.dart';
// import 'dart:math';

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

/// 自定义 physics：限制顶部最大overscroll，并在惯性阶段用弹簧回弹处理
// class MaxOverscrollPhysics extends ScrollPhysics {
//   final double maxOverscroll;
//   final bool holdAtTop;
//   final double holdExtent; // 正值，表示期望顶部悬停的可见高度

//   const MaxOverscrollPhysics({
//     required this.maxOverscroll,
//     this.holdAtTop = false,
//     this.holdExtent = 0.0,
//     super.parent,
//   });

//   @override
//   MaxOverscrollPhysics applyTo(ScrollPhysics? ancestor) {
//     return MaxOverscrollPhysics(
//       maxOverscroll: maxOverscroll,
//       holdAtTop: holdAtTop,
//       holdExtent: holdExtent,
//       parent: buildParent(ancestor),
//     );
//   }

//   @override
//   double applyBoundaryConditions(ScrollMetrics position, double value) {
//     // 首先交给父类处理，如果父类认为存在边界条件则返回其结果
//     if (parent != null) {
//       final parentResult = parent!.applyBoundaryConditions(position, value);
//       if (parentResult != 0.0) return parentResult;
//     }

//     final double limit = holdAtTop ? holdExtent : maxOverscroll;
//     final double customTopBoundary = position.minScrollExtent - limit;

//     // 当 value 超过自定义顶部边界时，阻止超过
//     if (value < customTopBoundary && position.pixels >= customTopBoundary) {
//       return value - customTopBoundary;
//     }
//     // 当当前位置已经在自定义顶部边界之外（更负），并且继续往负方向移动时，限制移动
//     if (value < position.pixels && position.pixels < customTopBoundary) {
//       return value - position.pixels;
//     }
//     return 0.0;
//   }
// }

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
  // final double offsetThresholdMax;

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
    // this.offsetThresholdMax = 80.0,
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

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        final metrics = notification.metrics;
        if (_refreshing) return false;
        if (metrics.pixels < 0) {
          if (notification is ScrollUpdateNotification) {
            // 手势仍在进行（dragDetails != null），更新 drag 状态
            if (notification.dragDetails != null) {
              if (metrics.pixels.abs() >= widget.offsetThresholdMin) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _dragOffset = metrics.pixels.abs();
                    _refreshMode = RefreshHeaderMode.armed;
                  });
                });
              } else if (_dragOffset < widget.offsetThresholdMin) {
                setState(() {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        _dragOffset = metrics.pixels.abs();
                        _refreshMode = RefreshHeaderMode.drag;
                      });
                    }
                  });
                });
              }
            } else {
              if (_dragOffset >= widget.offsetThresholdMin) {
                // 达到触发阈值：开始刷新
                setState(() {
                  _refreshMode = RefreshHeaderMode.refresh;
                  _refreshing = true;
                });
                // 发起刷新的异步操作（不阻塞滚动系统）
                _handleRefresh().then((_) {
                  if (mounted) {
                    setState(() {
                      _refreshMode = RefreshHeaderMode.done;
                      _refreshing = false;
                    });
                  }
                });
              } else {
                // 未达到阈值，恢复到顶部（这里调用 animateTo 以确保滚动有回弹动画）
                if (_controller.hasClients) {
                  setState(() {
                    _dragOffset = 0.0;
                    _refreshMode = RefreshHeaderMode.idle;
                    _refreshing = false;
                  });
                  _controller.animateTo(
                    0.0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                  );
                }
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
          // header 的高度受 _dragOffset 限制，最多为 offsetThresholdMax
          SizedBox(
            height: _dragOffset,
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
