import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final List<ETabPane> _tabs = [
    const ETabPane(
      label: '用户管理',
      icon: Icons.person,
      content: Center(child: Text('用户管理内容')),
    ),
    const ETabPane(
      label: '配置管理',
      icon: Icons.settings,
      content: Center(child: Text('配置管理内容')),
    ),
    const ETabPane(
      label: '角色管理',
      icon: Icons.security,
      content: Center(child: Text('角色管理内容')),
    ),
    const ETabPane(
      label: '任务',
      content: Center(child: Text('定时任务补偿内容')),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabs 标签页'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle('基础用法 (Border Style - Top)'),
              Container(
                height: 100,
                decoration: _boxDecoration,
                child: ETabs(
                  tabs: _tabs,
                  type: ETabType.border,
                  position: ETabPosition.top,
                ),
              ),
              _buildTitle('卡片样式 (Card Style)'),
              Container(
                height: 200,
                decoration: _boxDecoration,
                child: ETabs(
                  tabs: _tabs,
                  type: ETabType.card,
                ),
              ),
              _buildTitle('分段样式 (Segment Style)'),
              Container(
                height: 200,
                decoration: _boxDecoration,
                child: ETabs(
                  tabs: _tabs,
                  type: ETabType.segment,
                  stretch: false, // 紧凑模式
                ),
              ),
              _buildTitle('底部位置 (Bottom Position)'),
              Container(
                height: 200,
                decoration: _boxDecoration,
                child: ETabs(
                  tabs: _tabs,
                  type: ETabType.border,
                  position: ETabPosition.bottom,
                ),
              ),
              _buildTitle('左侧位置 (Left Position)'),
              Container(
                height: 200,
                decoration: _boxDecoration,
                child: ETabs(
                  tabs: _tabs,
                  type: ETabType.border,
                  position: ETabPosition.left,
                  tabWidth: 100,
                ),
              ),
              _buildTitle('右侧位置 (Right Position - Segment)'),
              Container(
                height: 200,
                decoration: _boxDecoration,
                child: ETabs(
                  tabs: _tabs,
                  type: ETabType.segment,
                  position: ETabPosition.right,
                  tabWidth: 120,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  final BoxDecoration _boxDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
    borderRadius: BorderRadius.circular(4),
  );
}
