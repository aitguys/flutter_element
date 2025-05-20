import 'package:flutter/material.dart';
import 'button_basic.dart';
import 'button_disable.dart';
import 'button_link.dart';
import 'button_custom_children.dart';
import 'button_custom_color.dart';
import 'button_icon.dart';
import 'button_loading.dart';
import 'button_size.dart';

class ButtonPreview extends StatelessWidget {
  const ButtonPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('按钮组件'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ButtonBasicPreview(),
            ButtonDisablePreview(),
            ButtonLinkPreview(),
            ButtonIconPreview(),
            ButtonCustomColorPreview(),
            ButtonCustomChildrenPreview(),
            ButtonSizePage(),
            button_loading_preview(),
            // button_badge_preview(),
          ],
        ),
      ),
    );
  }
}
