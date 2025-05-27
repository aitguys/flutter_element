import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';

class InfiniteScrollPage extends StatefulWidget {
  const InfiniteScrollPage({super.key});

  @override
  State<InfiniteScrollPage> createState() => _InfiniteScrollPageState();
}

class _InfiniteScrollPageState extends State<InfiniteScrollPage> {
  final List<int> _items = List.generate(20, (i) => i);
  bool _hasMore = true;

  Future<void> _loadMore() async {
    await Future.delayed(const Duration(seconds: 1));
    if (_items.length >= 40) {
      setState(() => _hasMore = false);
    } else {
      setState(
          () => _items.addAll(List.generate(10, (i) => _items.length + i)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('InfiniteScroll 无限滚动')),
      body: SizedBox(
        height: 300,
        child: EInfiniteScroll(
          itemCount: _items.length,
          itemBuilder: (context, i) =>
              ListTile(title: Text('Item ${_items[i]}')),
          onLoadMore: _loadMore,
          hasMore: _hasMore,
          loadingWidget: const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
          noMoreWidget: const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
                child: Text('没有更多了', style: TextStyle(color: Colors.grey))),
          ),
        ),
      ),
    );
  }
}
