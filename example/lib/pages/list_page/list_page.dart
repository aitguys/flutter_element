import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Widget> _items = [];
  int _currentPage = 1;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    // 初始化数据
    _items = List.generate(
      20,
      (i) => ListTile(
        leading: CircleAvatar(
          child: Text('${i + 1}'),
        ),
        title: Text('列表项 ${i + 1}'),
        subtitle: Text('这是第 ${i + 1} 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    // 模拟刷新数据
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      _currentPage = 1;
      _hasMore = true;
      _items = List.generate(
        20,
        (i) => ListTile(
          leading: CircleAvatar(
            child: Text('${i + 1}'),
          ),
          title: Text('列表项 ${i + 1} (已刷新)'),
          subtitle: Text('这是第 ${i + 1} 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      );
    });
  }

  Future<List<Widget>> _handleLoadMore(int page) async {
    // 模拟加载更多数据
    await Future.delayed(const Duration(seconds: 1));

    if (page > 3) {
      // 模拟没有更多数据
      setState(() {
        _hasMore = false;
      });
      return [];
    }

    // 返回新页面的数据
    final newItems = List.generate(
      10,
      (i) => ListTile(
        leading: CircleAvatar(
          child: Text('${_items.length + i + 1}'),
        ),
        title: Text('列表项 ${_items.length + i + 1} (第 $page 页)'),
        subtitle: Text('这是第 ${_items.length + i + 1} 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );

    return newItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List 列表'),
      ),
      body: EList(
        currentPage: _currentPage,
        onRefresh: _handleRefresh,
        onLoadMore: _handleLoadMore,
        hasMore: _hasMore,
        refreshHeaderBuilder: (context, mode, offset) {
          switch (mode) {
            case RefreshHeaderMode.drag:
              return const Center(child: Text("继续下拉"));
            case RefreshHeaderMode.armed:
              return const Center(child: Text("松开刷新"));
            case RefreshHeaderMode.refresh:
              return const Center(child: Text("正在刷新"));
            case RefreshHeaderMode.done:
              return const Center(child: Text("刷新完成"));
            default:
              return const SizedBox.shrink();
          }
        },
        loadingWidget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Image.asset(
              'assets/image/loading.gif',
              width: 36,
              height: 36,
              fit: BoxFit.contain,
            ),
          ),
        ),
        noMoreWidget: const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              '没有更多了',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: _items,
      ),
    );
  }
}
