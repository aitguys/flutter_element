import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message 消息提示'),
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
                    EMessageController.info(
                      context,
                      '这是一条消息提示',
                    );
                  },
                  child: const Text('显示消息'),
                ),
                const SizedBox(height: 32),
                const Text('不同类型',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        EMessageController.success(
                          context,
                          '成功提示的文案',
                        );
                      },
                      child: const Text('成功'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        EMessageController.warning(
                          context,
                          '警告提示的文案',
                        );
                      },
                      child: const Text('警告'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        EMessageController.info(
                          context,
                          '消息提示的文案',
                        );
                      },
                      child: const Text('消息'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        EMessageController.error(
                          context,
                          '错误提示的文案',
                        );
                      },
                      child: const Text('错误'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text('可关闭的消息提示',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    EMessageController.info(
                      context,
                      '这是一条可关闭的消息提示',
                      showClose: true,
                      duration: 0,
                    );
                  },
                  child: const Text('显示可关闭消息'),
                ),
                const SizedBox(height: 32),
                const Text('自定义时长',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    EMessageController.success(
                      context,
                      '这条消息将在 10 秒后消失',
                      duration: 10000,
                    );
                  },
                  child: const Text('10秒后消失'),
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
                  child: const Text('显示消息'),
                ),
              ],
            ),
          ),
          if (_visible)
            EMessage(
              message: '这是一条组件式调用的消息',
              type: EColorType.success,
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
