import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _visible = false;
  String _position = 'topRight';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification 通知'),
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
                    NotificationController.info(
                      context,
                      '通知标题',
                      '这是一条通知的内容',
                    );
                  },
                  child: const Text('显示通知'),
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
                        NotificationController.success(
                          context,
                          '成功',
                          '这是一条成功的提示消息',
                        );
                      },
                      child: const Text('成功'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        NotificationController.warning(
                          context,
                          '警告',
                          '这是一条警告的提示消息',
                        );
                      },
                      child: const Text('警告'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        NotificationController.info(
                          context,
                          '消息',
                          '这是一条消息的提示消息',
                        );
                      },
                      child: const Text('消息'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        NotificationController.error(
                          context,
                          '错误',
                          '这是一条错误的提示消息',
                        );
                      },
                      child: const Text('错误'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text('不同位置',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        NotificationController.info(
                          context,
                          '右上角通知',
                          '这是一条通知的内容',
                          position: 'topRight',
                        );
                      },
                      child: const Text('右上角'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        NotificationController.info(
                          context,
                          '右下角通知',
                          '这是一条通知的内容',
                          position: 'bottomRight',
                        );
                      },
                      child: const Text('右下角'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        NotificationController.info(
                          context,
                          '左下角通知',
                          '这是一条通知的内容',
                          position: 'bottomLeft',
                        );
                      },
                      child: const Text('左下角'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        NotificationController.info(
                          context,
                          '左上角通知',
                          '这是一条通知的内容',
                          position: 'topLeft',
                        );
                      },
                      child: const Text('左上角'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text('使用原生通知',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    NotificationController.info(
                      context,
                      '原生通知',
                      '这是一条原生通知',
                      usePlatformNotification: true,
                    );
                  },
                  child: const Text('显示原生通知'),
                ),
                const SizedBox(height: 32),
                const Text('可关闭的通知',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    NotificationController.info(
                      context,
                      '不会自动关闭',
                      '这是一条不会自动关闭的通知',
                      duration: 0,
                      showClose: true,
                    );
                  },
                  child: const Text('显示不会自动关闭的通知'),
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
                      child: const Text('显示通知'),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: _position,
                      items: const [
                        DropdownMenuItem(value: 'topRight', child: Text('右上角')),
                        DropdownMenuItem(value: 'topLeft', child: Text('左上角')),
                        DropdownMenuItem(
                            value: 'bottomRight', child: Text('右下角')),
                        DropdownMenuItem(
                            value: 'bottomLeft', child: Text('左下角')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _position = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_visible)
            ENotification(
              title: '组件式调用',
              message: '这是一条组件式调用的通知',
              type: NotificationType.success,
              position: _position,
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
