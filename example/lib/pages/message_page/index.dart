import 'package:flutter/material.dart';
import 'message_basic.dart';
import 'message_round.dart';
import 'message_size.dart';
import 'message_duration.dart';
import 'message_icon.dart';
import 'message_show_close.dart';
import 'message_api.dart';

class MessagePreview extends StatelessWidget {
  const MessagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('消息组件'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            MessageBasicPreview(),
            MessageRoundPreview(),
            MessageSizePreview(),
            MessageDurationPreview(),
            MessageIconPreview(),
            MessageShowClosePreview(),
            MessageApiPreview(),
          ],
        ),
      ),
    );
  }
}
