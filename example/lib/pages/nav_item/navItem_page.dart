import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class NavItemTestPage extends StatelessWidget {
  const NavItemTestPage({Key? key}) : super(key: key);

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
          FlNavItem(
            child: const Text('中间内容', style: TextStyle(fontSize: 18)),
            suffix: const Icon(Icons.more_vert),
          ),
          const Divider(),
          FlNavItem(
            prefix: const CircleAvatar(child: Text('A')),
            child: const Text('带头像的导航项', style: TextStyle(fontSize: 18)),
            suffix: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
