import 'package:flutter/material.dart';

/// An infinite scroll component that follows Element Plus design guidelines.
///
/// The [EInfiniteScroll] widget provides a scrollable list with infinite loading
/// capabilities. It automatically triggers loading more items when the user
/// scrolls near the bottom of the list.
///
/// Features:
/// - Automatic loading when scrolling near the bottom
/// - Customizable loading and "no more" indicators
/// - Configurable padding
/// - Support for any type of list item through itemBuilder
///
/// Example:
/// ```dart
/// EInfiniteScroll(
///   itemCount: items.length,
///   itemBuilder: (context, index) => ListTile(
///     title: Text(items[index].title),
///   ),
///   onLoadMore: () async {
///     // Load more items
///     final newItems = await fetchMoreItems();
///     setState(() {
///       items.addAll(newItems);
///     });
///   },
///   hasMore: hasMoreItems,
///   loadingWidget: CircularProgressIndicator(),
///   noMoreWidget: Text('No more items'),
/// )
/// ```
class EInfiniteScroll extends StatefulWidget {
  /// A builder function that creates a widget for each item in the list.
  ///
  /// The [itemBuilder] is called for each item in the list, with the item's
  /// index and build context. It should return a widget that represents the
  /// item at that index.
  final IndexedWidgetBuilder itemBuilder;

  /// The total number of items in the list.
  ///
  /// This should be the current number of items, which may increase as more
  /// items are loaded.
  final int itemCount;

  /// A callback function that is called when more items need to be loaded.
  ///
  /// This function should load the next batch of items and update the state
  /// accordingly. It is called automatically when the user scrolls near the
  /// bottom of the list.
  final Future<void> Function()? onLoadMore;

  /// Whether there are more items to load.
  ///
  /// When false, the "no more" widget will be displayed at the bottom of the
  /// list instead of attempting to load more items.
  final bool hasMore;

  /// A widget to display while loading more items.
  ///
  /// If not provided, a default loading indicator will be shown.
  final Widget? loadingWidget;

  /// A widget to display when there are no more items to load.
  ///
  /// If not provided, a default "no more" text will be shown.
  final Widget? noMoreWidget;

  /// The padding to apply to the list.
  ///
  /// This can be used to add spacing around the list items.
  final EdgeInsetsGeometry? padding;

  const EInfiniteScroll({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.onLoadMore,
    this.hasMore = true,
    this.loadingWidget,
    this.noMoreWidget,
    this.padding,
  });

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
