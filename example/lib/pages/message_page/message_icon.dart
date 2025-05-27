import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class MessageIconPreview extends StatelessWidget {
  const MessageIconPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(context),
      code: getCodeUrl('message_page', 'message_icon.dart'),
      title: '自定义图标',
    );
  }
}

class MessageIconView extends StatelessWidget {
  const MessageIconView({super.key});

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
            icon: const Icon(Icons.check),
          );
        },
        child: const Text('自定义图标'),
      ),
    ],
  );
}
