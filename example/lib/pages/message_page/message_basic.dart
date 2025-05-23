import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class MessageBasicPreview extends StatelessWidget {
  const MessageBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(context),
      code: getCodeUrl('message_page', 'message_basic.dart'),
      title: '基础用法',
    );
  }
}

class MessageBasicView extends StatelessWidget {
  const MessageBasicView({super.key});

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
          MessageController.success(
            context,
            '这是一条消息提示',
          );
        },
        child: const Text('成功消息-success'),
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () {
          MessageController.error(
            context,
            '这是一条失败消息',
          );
        },
        child: const Text('失败消息-error'),
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () {
          MessageController.warning(
            context,
            '这是一条警告消息',
          );
        },
        child: const Text('警告消息-warning'),
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () {
          MessageController.info(
            context,
            '这是一条信息消息',
          );
        },
        child: const Text('信息消息-info'),
      ),
    ],
  );
}
