import 'package:flutter/material.dart';

class EInfiniteScroll extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final Future<void> Function()? onLoadMore;
  final bool hasMore;
  final Widget? loadingWidget;
  final Widget? noMoreWidget;
  final EdgeInsetsGeometry? padding;

  const EInfiniteScroll({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.onLoadMore,
    this.hasMore = true,
    this.loadingWidget,
    this.noMoreWidget,
    this.padding,
  }) : super(key: key);

  @override
  State<EInfiniteScroll> createState() => _EInfiniteScrollState();
}

class _EInfiniteScrollState extends State<EInfiniteScroll> {
  final ScrollController _controller = ScrollController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_loading && widget.hasMore && widget.onLoadMore != null) {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 100) {
        _loadMore();
      }
    }
  }

  Future<void> _loadMore() async {
    setState(() => _loading = true);
    await widget.onLoadMore?.call();
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      padding: widget.padding,
      itemCount: widget.itemCount + 1,
      itemBuilder: (context, index) {
        if (index < widget.itemCount) {
          return widget.itemBuilder(context, index);
        } else {
          if (_loading) {
            return widget.loadingWidget ??
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
          } else if (!widget.hasMore) {
            return widget.noMoreWidget ??
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                      child:
                          Text('没有更多了', style: TextStyle(color: Colors.grey))),
                );
          } else {
            return const SizedBox.shrink();
          }
        }
      },
    );
  }
}
