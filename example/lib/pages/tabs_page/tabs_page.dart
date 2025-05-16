import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final List<ETabPane> _tabs = [
    ETabPane(
      label: '用户管理',
      icon: Icons.person,
      content: const Center(child: Text('用户管理内容')),
    ),
    ETabPane(
      label: '配置管理',
      icon: Icons.settings,
      content: const Center(child: Text('配置管理内容')),
    ),
    ETabPane(
      label: '角色管理',
      icon: Icons.security,
      content: const Center(child: Text('角色管理内容')),
    ),
    ETabPane(
      label: '定时任务补偿',
      content: const Center(child: Text('定时任务补偿内容')),
    ),
  ];

  final List<ETabPane> _closableTabs = [
    ETabPane(
      label: 'Tab 1',
      closable: true,
      content: const Center(child: Text('Tab 1 内容')),
    ),
    ETabPane(
      label: 'Tab 2',
      closable: true,
      content: const Center(child: Text('Tab 2 内容')),
    ),
    ETabPane(
      label: 'Tab 3',
      closable: true,
      content: const Center(child: Text('Tab 3 内容')),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabs 标签页'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础用法',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ETabs(
                tabs: _tabs,
                type: ETabType.border,
              ),
            ),
            const SizedBox(height: 32),
            const Text('选项卡样式',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ETabs(
                tabs: _tabs,
                type: ETabType.card,
              ),
            ),
            const SizedBox(height: 32),
            const Text('分段样式',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ETabs(
                tabs: _tabs.sublist(0, 3),
                type: ETabType.segment,
              ),
            ),
            const SizedBox(height: 32),
            const Text('可关闭标签',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ETabs(
                tabs: _closableTabs,
                type: ETabType.card,
                closable: true,
              ),
            ),
            const SizedBox(height: 32),
            const Text('位置',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ETabs(
                tabs: _tabs,
                position: ETabPosition.left,
                type: ETabType.border,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
