import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class BackTopPage extends StatefulWidget {
  const BackTopPage({Key? key}) : super(key: key);

  @override
  State<BackTopPage> createState() => _BackTopPageState();
}

class _BackTopPageState extends State<BackTopPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back Top 回到顶部'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('List Item ${index + 1}'),
                subtitle: const Text('滚动页面查看右下角的返回顶部按钮'),
              );
            },
          ),
          EBackTop(
            controller: _scrollController,
            visibilityHeight: 400,
            onClick: () {
              debugPrint('Clicked on back to top button!');
            },
          ),
          // 加一个自定义样式的案例
          EBackTop(
            controller: _scrollController,
            visibilityHeight: 400,
            onClick: () {
              debugPrint('Clicked on back to top button!');
            },
            child: const Icon(Icons.arrow_upward),
          ),
        ],
      ),
    );
  }
}
