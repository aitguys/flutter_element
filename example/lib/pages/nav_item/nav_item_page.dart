import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class NavItemTestPage extends StatelessWidget {
  const NavItemTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NavItem 测试')),
      body: ListView(
        children: [
          FlNavItem(
            prefix: const Icon(Icons.arrow_back),
            child: const Text('返回', style: TextStyle(fontSize: 18)),
            onTap: () => ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('点击返回'))),
          ),
          const Divider(),
          const FlNavItem(
            suffix: Icon(Icons.more_vert),
            child: Text('中间内容', style: TextStyle(fontSize: 18)),
          ),
          const Divider(),
          const FlNavItem(
            prefix: CircleAvatar(child: Text('A')),
            suffix: Icon(Icons.chevron_right),
            child: Text('带头像的导航项', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
