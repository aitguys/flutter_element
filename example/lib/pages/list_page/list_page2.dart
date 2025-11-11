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
    // 直接用数组的方式初始化数据
    _items = [
      ListTile(
        leading: CircleAvatar(child: Text('1')),
        title: Text('列表项 1'),
        subtitle: Text('这是第 1 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('2')),
        title: Text('列表项 2'),
        subtitle: Text('这是第 2 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('3')),
        title: Text('列表项 3'),
        subtitle: Text('这是第 3 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('4')),
        title: Text('列表项 4'),
        subtitle: Text('这是第 4 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('5')),
        title: Text('列表项 5'),
        subtitle: Text('这是第 5 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('6')),
        title: Text('列表项 6'),
        subtitle: Text('这是第 6 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('7')),
        title: Text('列表项 7'),
        subtitle: Text('这是第 7 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('8')),
        title: Text('列表项 8'),
        subtitle: Text('这是第 8 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('9')),
        title: Text('列表项 9'),
        subtitle: Text('这是第 9 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('10')),
        title: Text('列表项 10'),
        subtitle: Text('这是第 10 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('11')),
        title: Text('列表项 11'),
        subtitle: Text('这是第 11 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('12')),
        title: Text('列表项 12'),
        subtitle: Text('这是第 12 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('13')),
        title: Text('列表项 13'),
        subtitle: Text('这是第 13 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('14')),
        title: Text('列表项 14'),
        subtitle: Text('这是第 14 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('15')),
        title: Text('列表项 15'),
        subtitle: Text('这是第 15 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('16')),
        title: Text('列表项 16'),
        subtitle: Text('这是第 16 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('17')),
        title: Text('列表项 17'),
        subtitle: Text('这是第 17 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('18')),
        title: Text('列表项 18'),
        subtitle: Text('这是第 18 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('19')),
        title: Text('列表项 19'),
        subtitle: Text('这是第 19 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('20')),
        title: Text('列表项 20'),
        subtitle: Text('这是第 20 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    ];
  }

  Future<void> _handleRefresh() async {
    // 模拟刷新数据
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _currentPage = 1;
      _hasMore = true;
      // 刷新时换成“已刷新”的标签（仍然用数组方式）
      _items = [
        ListTile(
          leading: CircleAvatar(child: Text('1')),
          title: Text('列表项 1 (已刷新)'),
          subtitle: Text('这是第 1 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('2')),
          title: Text('列表项 2 (已刷新)'),
          subtitle: Text('这是第 2 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('3')),
          title: Text('列表项 3 (已刷新)'),
          subtitle: Text('这是第 3 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('4')),
          title: Text('列表项 4 (已刷新)'),
          subtitle: Text('这是第 4 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('5')),
          title: Text('列表项 5 (已刷新)'),
          subtitle: Text('这是第 5 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('6')),
          title: Text('列表项 6 (已刷新)'),
          subtitle: Text('这是第 6 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('7')),
          title: Text('列表项 7 (已刷新)'),
          subtitle: Text('这是第 7 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('8')),
          title: Text('列表项 8 (已刷新)'),
          subtitle: Text('这是第 8 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('9')),
          title: Text('列表项 9 (已刷新)'),
          subtitle: Text('这是第 9 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('10')),
          title: Text('列表项 10 (已刷新)'),
          subtitle: Text('这是第 10 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('11')),
          title: Text('列表项 11 (已刷新)'),
          subtitle: Text('这是第 11 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('12')),
          title: Text('列表项 12 (已刷新)'),
          subtitle: Text('这是第 12 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('13')),
          title: Text('列表项 13 (已刷新)'),
          subtitle: Text('这是第 13 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('14')),
          title: Text('列表项 14 (已刷新)'),
          subtitle: Text('这是第 14 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('15')),
          title: Text('列表项 15 (已刷新)'),
          subtitle: Text('这是第 15 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('16')),
          title: Text('列表项 16 (已刷新)'),
          subtitle: Text('这是第 16 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('17')),
          title: Text('列表项 17 (已刷新)'),
          subtitle: Text('这是第 17 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('18')),
          title: Text('列表项 18 (已刷新)'),
          subtitle: Text('这是第 18 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('19')),
          title: Text('列表项 19 (已刷新)'),
          subtitle: Text('这是第 19 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Text('20')),
          title: Text('列表项 20 (已刷新)'),
          subtitle: Text('这是第 20 个列表项的内容'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ];
    });
  }

  Future<List<Widget>> _handleLoadMore(int page) async {
    // 模拟加载更多数据
    await Future.delayed(const Duration(seconds: 1));

    if (page > 3) {
      setState(() {
        _hasMore = false;
      });
      return [];
    }

    // 直接写成数组形式返回新页面的数据（每页10条）
    List<Widget> newItems = [
      ListTile(
        leading: CircleAvatar(child: Text('${_items.length + 1}')),
        title: Text('列表项 ${_items.length + 1} (第 $page 页)'),
        subtitle: Text('这是第 ${_items.length + 1} 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('${_items.length + 2}')),
        title: Text('列表项 ${_items.length + 2} (第 $page 页)'),
        subtitle: Text('这是第 ${_items.length + 2} 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('${_items.length + 3}')),
        title: Text('列表项 ${_items.length + 3} (第 $page 页)'),
        subtitle: Text('这是第 ${_items.length + 3} 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('${_items.length + 4}')),
        title: Text('列表项 ${_items.length + 4} (第 $page 页)'),
        subtitle: Text('这是第 ${_items.length + 4} 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('${_items.length + 5}')),
        title: Text('列表项 ${_items.length + 5} (第 $page 页)'),
        subtitle: Text('这是第 ${_items.length + 5} 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('${_items.length + 6}')),
        title: Text('列表项 ${_items.length + 6} (第 $page 页)'),
        subtitle: Text('这是第 ${_items.length + 6} 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('${_items.length + 7}')),
        title: Text('列表项 ${_items.length + 7} (第 $page 页)'),
        subtitle: Text('这是第 ${_items.length + 7} 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('${_items.length + 8}')),
        title: Text('列表项 ${_items.length + 8} (第 $page 页)'),
        subtitle: Text('这是第 ${_items.length + 8} 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('${_items.length + 9}')),
        title: Text('列表项 ${_items.length + 9} (第 $page 页)'),
        subtitle: Text('这是第 ${_items.length + 9} 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ListTile(
        leading: CircleAvatar(child: Text('${_items.length + 10}')),
        title: Text('列表项 ${_items.length + 10} (第 $page 页)'),
        subtitle: Text('这是第 ${_items.length + 10} 个列表项的内容'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    ];

    return newItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List 列表'),
      ),
      body: EList(
        children: _items,
        currentPage: _currentPage,
        onRefresh: _handleRefresh,
        onLoadMore: _handleLoadMore,
        hasMore: _hasMore,
        loadingWidget: const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.red,
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
      ),
    );
  }
}
