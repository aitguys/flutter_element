import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';
import '../../const/index.dart';

class MessageDurationPreview extends StatelessWidget {
  const MessageDurationPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(context),
      code: getCodeUrl('message_page', 'message_duration.dart'),
      title: '控制自动自动关闭时长',
    );
  }
}

class MessageDurationView extends StatelessWidget {
  const MessageDurationView({super.key});

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
            duration: 1000,
          );
        },
        child: const Text('一秒自动关闭'),
      ),
      ElevatedButton(
        onPressed: () {
          EMessageController.success(
            context,
            '这是一条消息提示',
            duration: 2000,
          );
        },
        child: const Text('两秒自动关闭'),
      ),
      ElevatedButton(
        onPressed: () {
          EMessageController.success(
            context,
            '这是一条消息提示',
            duration: 3000,
          );
        },
        child: const Text('三秒自动关闭'),
      ),
      ElevatedButton(
        onPressed: () {
          EMessageController.success(
            context,
            '这是一条消息提示',
            duration: 0,
            showClose: true,
          );
        },
        child: const Text('duration = 0， 手动触发关闭， 否则永不关闭'),
      ),
    ],
  );
}
