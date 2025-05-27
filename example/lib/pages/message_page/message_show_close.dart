import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';
import '../../const/index.dart';

class MessageShowClosePreview extends StatelessWidget {
  const MessageShowClosePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(context),
      code: getCodeUrl('message_page', 'message_showClose.dart'),
      title: '是否展示关闭按钮',
    );
  }
}

class MessageShowCloseView extends StatelessWidget {
  const MessageShowCloseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _viewerContent(context),
        ),
      ),
    );
  }
}

Widget _viewerContent(BuildContext context) {
  return Wrap(
    spacing: 16,
    runSpacing: 16,
    children: [
      ElevatedButton(
        onPressed: () {
          EMessageController.success(
            context,
            '这是一条消息提示',
            duration: 3000,
            showClose: true,
          );
        },
        child: const Text('手动关闭'),
      ),
      ElevatedButton(
        onPressed: () {
          EMessageController.success(
            context,
            '这是一条消息提示',
            duration: 3000,
            showClose: true,
          );
        },
        child: const Text('手动关闭'),
      ),
    ],
  );
}
