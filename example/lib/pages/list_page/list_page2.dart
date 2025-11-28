import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class ListPage2 extends StatefulWidget {
  const ListPage2({super.key});

  @override
  State<ListPage2> createState() => _ListPage2State();
}

class _ListPage2State extends State<ListPage2> {
  final controller = EListController();
  List<String> items = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    items = List.generate(20, (i) => "Item ${i + 1}");
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      page = 1;
      items = List.generate(20, (i) => "Item ${i + 1}");
    });
  }

  Future<List<String>> _loadMore(int nextPage) async {
    await Future.delayed(const Duration(seconds: 1));
    final newItems =
        List.generate(10, (i) => "Item ${(nextPage - 1) * 10 + i + 1}");
    items.addAll(newItems);
    return newItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EList Test Page")),
      body: EList<String>(
        controller: controller,

        /// data 模式
        data: items,
        itemBuilder: (context, item, index) {
          return ListTile(title: Text(item));
        },

        currentPage: page,
        hasMore: true,

        onRefresh: _refresh,
        onLoadMore: _loadMore,

        refreshHeaderBuilder: (ctx, mode, offset) {
          return Container(
            color: Colors.blue.withValues(alpha: 0.1),
            child: Center(
              child: Text(
                "${mode.toString().split('.').last} | offset=$offset",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.triggerPullDown(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
