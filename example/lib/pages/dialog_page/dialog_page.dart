import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({Key? key}) : super(key: key);

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialog 对话框'),
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
                    showEDialog(
                      context: context,
                      title: '提示',
                      content: const Text('这是一段内容'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('取消'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('确定'),
                        ),
                      ],
                    );
                  },
                  child: const Text('点击打开 Dialog'),
                ),
                const SizedBox(height: 32),
                const Text('自定义内容',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    showEDialog(
                      context: context,
                      title: '自定义内容',
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const TextField(
                            decoration: InputDecoration(
                              labelText: '用户名',
                            ),
                          ),
                          const SizedBox(height: 16),
                          const TextField(
                            decoration: InputDecoration(
                              labelText: '密码',
                            ),
                            obscureText: true,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('取消'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('确定'),
                        ),
                      ],
                    );
                  },
                  child: const Text('自定义内容'),
                ),
                const SizedBox(height: 32),
                const Text('组件式调用',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _visible = true;
                    });
                  },
                  child: const Text('组件式调用'),
                ),
                const SizedBox(height: 32),
                const Text('可拖拽对话框',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    showEDialog(
                      context: context,
                      title: '可拖拽对话框',
                      content: const Text('这是一段内容'),
                      draggable: true,
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('取消'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('确定'),
                        ),
                      ],
                    );
                  },
                  child: const Text('打开可拖拽对话框'),
                ),
              ],
            ),
          ),
          EDialog(
            visible: _visible,
            title: '组件式调用',
            content: const Text('这是一段内容'),
            onClose: () {
              setState(() {
                _visible = false;
              });
            },
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _visible = false;
                  });
                },
                child: const Text('取消'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _visible = false;
                  });
                },
                child: const Text('确定'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
