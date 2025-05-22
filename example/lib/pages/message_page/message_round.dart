import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class MessageRoundPreview extends StatelessWidget {
  const MessageRoundPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(context),
      code: getCodeUrl('message_page', 'message_basic.dart'),
      title: '圆角消息 - isRound',
    );
  }
}

class MessageRoundView extends StatelessWidget {
  const MessageRoundView({super.key});

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
            isRound: true,
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
            isRound: true,
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
            isRound: true,
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
            isRound: true,
          );
        },
        child: const Text('信息消息-info'),
      ),
    ],
  );
}
