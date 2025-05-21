import 'package:flutter/material.dart';
import 'layout_basic.dart';
import 'layout_container.dart';
import 'layout_row_col.dart';
import 'layout_api.dart';
import 'route.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout 布局'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('基础布局'),
            subtitle: const Text('基础的页面布局，包含 Header、Aside、Main、Footer 等组件'),
            onTap: () => Navigator.pushNamed(context, LayoutRoutes.basic),
          ),
          ListTile(
            title: const Text('Container 容器'),
            subtitle: const Text('用于布局的容器组件，支持水平和垂直两种布局方式'),
            onTap: () => Navigator.pushNamed(context, LayoutRoutes.container),
          ),
          ListTile(
            title: const Text('Row 和 Col 栅格'),
            subtitle: const Text('通过基础的 24 分栏，迅速简便地创建布局'),
            onTap: () => Navigator.pushNamed(context, LayoutRoutes.rowCol),
          ),
          ListTile(
            title: const Text('API'),
            subtitle: const Text('Layout 组件的 API 文档'),
            onTap: () => Navigator.pushNamed(context, LayoutRoutes.api),
          ),
        ],
      ),
    );
  }
}
