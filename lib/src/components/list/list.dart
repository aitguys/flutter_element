import 'package:flutter/material.dart';

enum RefreshHeaderMode { idle, drag, armed, refresh, done }

/// 控制 EList 行为：主动刷新、主动下拉显示等
class EListController extends ChangeNotifier {
  _EListState? _state;

  /// 主动触发刷新
  Future<void> refresh() async {
    await _state?._handleRefresh();
  }

  /// 主动下拉显示刷新头（动画拉下）
  Future<void> triggerPullDown() async {
    final state = _state;
    if (state == null) return;

    if (!state.widget.enablePullDown || state.widget.onRefresh == null) return;

    state._dragOffset = state.widget.offsetThresholdMin + 1;
    state._refreshMode = RefreshHeaderMode.refresh;
    await state._handleRefresh();
  }
}

/// EList —— 支持 data / itemBuilder 方式的通用下拉刷新 + 分页加载组件
class EList<T> extends StatefulWidget {
  /// --- 数据驱动（推荐）
  final List<T>? data;
  final Widget Function(BuildContext context, T item, int index)? itemBuilder;

  /// --- 兼容旧的 children 模式
  final List<Widget>? children;

  /// 下拉刷新
  final Future<void> Function()? onRefresh;

  /// 分页加载
  final Future<List<T>> Function(int page)? onLoadMore;

  /// 是否还有更多数据
  final bool hasMore;

  /// 页面控制
  final int currentPage;

  /// 加载中/无更多
  final Widget? loadingWidget;
  final Widget? noMoreWidget;

  /// 布局参数
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Axis scrollDirection;
  final bool reverse;

  /// 下拉刷新控制
  final bool enablePullDown;
  final double offsetThresholdMin;

  /// 外部控制器
  final EListController? controller;

  /// 自定义刷新头
  final Widget Function(
    BuildContext context,
    RefreshHeaderMode mode,
    double offset,
  )? refreshHeaderBuilder;

  /// 初始加载逻辑
  final bool initLoading;
  final Widget? initLoadingWidget;

  const EList({
    super.key,
    this.data,
    this.itemBuilder,
    this.children,
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
    this.offsetThresholdMin = 50,
    this.controller,
    this.refreshHeaderBuilder,
    this.initLoading = false,
    this.initLoadingWidget,
  }) : assert(
          (data != null && itemBuilder != null) ||
              (children != null) ||
              (data == null && children == null),
          '必须提供 data + itemBuilder，或 children 二选一',
        );

  @override
  State<EList<T>> createState() => _EListState<T>();
}

class _EListState<T> extends State<EList<T>> {
  late ScrollController _scrollController;

  /// 列表数据
  late List<T> _dataItems;
  late List<Widget> _widgetItems;

  int _currentPage = 1;
  bool _loadingMore = false;
  bool _hasMore = true;

  /// 下拉刷新动画状态
  RefreshHeaderMode _refreshMode = RefreshHeaderMode.idle;
  double _dragOffset = 0;
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);

    _currentPage = widget.currentPage;
    _hasMore = widget.hasMore;

    // 初始化数据
    if (widget.data != null) {
      _dataItems = List.from(widget.data!);
      _widgetItems = [];
    } else {
      _dataItems = [];
      _widgetItems = List.from(widget.children ?? []);
    }

    widget.controller?._state = this;
  }

  @override
  void didUpdateWidget(covariant EList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 更新数据
    if (widget.data != oldWidget.data) {
      if (widget.data != null) {
        _dataItems = List.from(widget.data!);
      }
    }
    if (widget.children != oldWidget.children) {
      if (widget.children != null) {
        _widgetItems = List.from(widget.children!);
      }
    }

    // 更新分页信息
    _currentPage = widget.currentPage;
    _hasMore = widget.hasMore;

    // 更新 controller 的绑定
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?._state = null;
      widget.controller?._state = this;
    }
  }

  @override
  void dispose() {
    widget.controller?._state = null;
    _scrollController.dispose();
    super.dispose();
  }

  /// 是否使用 data + itemBuilder 模式
  bool get _useDataMode => widget.data != null && widget.itemBuilder != null;

  /// 当前列表总数
  int get _itemCount => _useDataMode ? _dataItems.length : _widgetItems.length;

  /// 取第 index 项
  Widget _buildItem(BuildContext context, int index) {
    if (_useDataMode) {
      return widget.itemBuilder!(context, _dataItems[index], index);
    }
    return _widgetItems[index];
  }

  /// 监听滚动触发分页
  void _onScroll() {
    if (!_loadingMore && _hasMore && widget.onLoadMore != null) {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 100) {
        _loadMore();
      }
    }
  }

  Future<void> _loadMore() async {
    if (_loadingMore || !_hasMore) return;

    setState(() => _loadingMore = true);

    try {
      final nextPage = _currentPage + 1;
      final list = await widget.onLoadMore?.call(nextPage);

      if (mounted && list != null) {
        setState(() {
          _dataItems.addAll(list);
          _currentPage = nextPage;
          if (list.isEmpty) _hasMore = false;
        });
      }
    } catch (e) {
      debugPrint("EList loadMore error: $e");
    }

    if (mounted) {
      setState(() => _loadingMore = false);
    }
  }

  /// 下拉刷新核心逻辑
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
          _refreshMode = RefreshHeaderMode.done;
          _currentPage = widget.currentPage;
          _hasMore = widget.hasMore;

          // 刷新数据
          if (_useDataMode) {
            _dataItems = List.from(widget.data!);
          } else {
            _widgetItems = List.from(widget.children ?? []);
          }
        });
      }

      await Future.delayed(const Duration(milliseconds: 400));
    } finally {
      if (!mounted) return;

      setState(() {
        _refreshMode = RefreshHeaderMode.idle;
        _dragOffset = 0;
        _refreshing = false;
      });

      // 自动回弹
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    }
  }

  /// 构建 footer
  Widget _buildFooter() {
    if (_loadingMore) {
      return widget.loadingWidget ??
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
    }
    if (!_hasMore) {
      return widget.noMoreWidget ??
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: Text("没有更多了")),
          );
    }
    return const SizedBox.shrink();
  }

  /// 自定义刷新头
  Widget _buildHeader() {
    if (widget.refreshHeaderBuilder != null) {
      return widget.refreshHeaderBuilder!(
        context,
        _refreshMode,
        _dragOffset,
      );
    }

    switch (_refreshMode) {
      case RefreshHeaderMode.drag:
        return const Center(child: Text("继续下拉…"));
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

  @override
  Widget build(BuildContext context) {
    if (widget.initLoading) {
      return widget.initLoadingWidget ??
          const Center(child: CircularProgressIndicator());
    }

    /// 主列表
    final listView = ListView.builder(
      controller: _scrollController,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics ?? const BouncingScrollPhysics(),
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      itemCount: _itemCount + 1,
      itemBuilder: (context, i) {
        if (i < _itemCount) return _buildItem(context, i);
        return _buildFooter();
      },
    );

    if (!widget.enablePullDown || widget.onRefresh == null) {
      return listView;
    }

    /// 包装下拉刷新
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final pixels = notification.metrics.pixels;

        if (_refreshing) return false;

        if (pixels < 0 && notification is ScrollUpdateNotification) {
          final offset = pixels.abs();

          if (notification.dragDetails != null) {
            // 手拖动
            setState(() {
              _dragOffset = offset;

              if (offset >= widget.offsetThresholdMin) {
                _refreshMode = RefreshHeaderMode.armed;
              } else {
                _refreshMode = RefreshHeaderMode.drag;
              }
            });
          } else {
            // 手松开
            if (_dragOffset >= widget.offsetThresholdMin) {
              _handleRefresh();
            } else {
              setState(() {
                _dragOffset = 0;
                _refreshMode = RefreshHeaderMode.idle;
              });
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
            height: _dragOffset,
            child: _buildHeader(),
          ),
        ],
      ),
    );
  }
}
