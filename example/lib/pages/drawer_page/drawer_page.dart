import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});
  
  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool _visible = false;
  String _direction = 'rtl';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer 抽屉'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('基础用法',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    showEDrawer(
                      context: context,
                      title: '标题',
                      content: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('这是一段内容...'),
                      ),
                    );
                  },
                  child: const Text('点击打开 Drawer'),
                ),
                const SizedBox(height: 32),
                const Text('自定义内容',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    showEDrawer(
                      context: context,
                      title: '用户信息',
                      content: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextField(
                              decoration: InputDecoration(
                                labelText: '用户名',
                              ),
                            ),
                            const SizedBox(height: 16),
                            const TextField(
                              decoration: InputDecoration(
                                labelText: '邮箱',
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('取消'),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('确定'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Text('自定义内容'),
                ),
                const SizedBox(height: 32),
                const Text('不同方向',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showEDrawer(
                          context: context,
                          direction: 'rtl',
                          title: '右侧打开',
                          content: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('右侧打开的抽屉...'),
                          ),
                        );
                      },
                      child: const Text('右侧打开'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showEDrawer(
                          context: context,
                          direction: 'ltr',
                          title: '左侧打开',
                          content: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('左侧打开的抽屉...'),
                          ),
                        );
                      },
                      child: const Text('左侧打开'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showEDrawer(
                          context: context,
                          direction: 'ttb',
                          title: '顶部打开',
                          content: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('顶部打开的抽屉...'),
                          ),
                        );
                      },
                      child: const Text('顶部打开'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showEDrawer(
                          context: context,
                          direction: 'btt',
                          title: '底部打开',
                          content: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('底部打开的抽屉...'),
                          ),
                        );
                      },
                      child: const Text('底部打开'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text('组件式调用',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _visible = true;
                        });
                      },
                      child: const Text('打开 Drawer'),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: _direction,
                      items: const [
                        DropdownMenuItem(value: 'rtl', child: Text('右侧')),
                        DropdownMenuItem(value: 'ltr', child: Text('左侧')),
                        DropdownMenuItem(value: 'ttb', child: Text('顶部')),
                        DropdownMenuItem(value: 'btt', child: Text('底部')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _direction = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          EDrawer(
            visible: _visible,
            direction: _direction,
            title: '组件式调用',
            content: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('这是一段内容...'),
            ),
            onClose: () {
              setState(() {
                _visible = false;
              });
            },
          ),
        ],
      ),
    );
  }
}
