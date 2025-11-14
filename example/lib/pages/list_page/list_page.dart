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
  bool _initLoading = true;
  @override
  void initState() {
    super.initState();
    // 初始化数据
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _initLoading = false;
      });
    });
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
    await Future.delayed(const Duration(seconds: 2));
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
    final controller = EListController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('List 列表'),
      ),
      body: Column(
        children: [
          const Text(
            '上滑下面这个列表触发 分页/懒加载， 下滑触发刷新。 刷新状态有四个：拖动中、松开刷新、正在刷新、刷新完成，widget 均可以自定义，其父组件为被下拉的空白区域',
            style: TextStyle(color: Colors.blue),
          ),
          Expanded(
            child: EList(
              controller: controller,
              currentPage: _currentPage,
              onRefresh: _handleRefresh,
              initLoading: _initLoading,
              initLoadingWidget: Padding(
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
              onLoadMore: _handleLoadMore,
              hasMore: _hasMore,
              offsetThresholdMin: 30.0,
              // offsetThresholdMax: 60.0,
              // headerPinnedToTop: false,
              refreshHeaderBuilder: (context, mode, offset) {
                switch (mode) {
                  case RefreshHeaderMode.drag:
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("继续下拉, 偏移：$offset"),
                    );

                  case RefreshHeaderMode.armed:
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("松开刷新, 偏移：$offset"),
                    );
                  case RefreshHeaderMode.refresh:
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        EButton(
                          text: "正在刷新",
                          type: EColorType.primary,
                          isRound: true,
                          size: ESizeItem.small,
                          loading: true,
                        )
                      ],
                    );
                  case RefreshHeaderMode.done:
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        EButton(
                          text: "刷新完成",
                          type: EColorType.success,
                          isRound: true,
                          size: ESizeItem.small,
                          icon: Icons.check_circle,
                        )
                      ],
                    );
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
                    'No more data',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: _items,
            ),
          ),
        ],
      ),
    );
  }
}
