import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class MessageSizePreview extends StatelessWidget {
  const MessageSizePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(context),
      code: getCodeUrl('message_page', 'message_size.dart'),
      title: '不同尺寸消息， size 和 padding 和 fontSize ',
    );
  }
}

class MessageSizeView extends StatelessWidget {
  const MessageSizeView({super.key});

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
            size: ESizeItem.large,
          );
        },
        child: const Text('成功消息-large'),
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () {
          EMessageController.success(
            context,
            '这是一条失败消息',
            size: ESizeItem.medium,
          );
        },
        child: const Text('失败消息-medium （默认）'),
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () {
          EMessageController.success(
            context,
            '这是一条警告消息',
            size: ESizeItem.small,
            padding: const EdgeInsets.all(20),
            fontSize: 20,
          );
        },
        child: const Text('通过自定义padding 和 fontSize 来改变消息大小'),
      ),
    ],
  );
}
