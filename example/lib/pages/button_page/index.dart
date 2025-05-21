import 'package:flutter/material.dart';
import 'button_basic.dart';
import 'button_disable.dart';
import 'button_link.dart';
import 'button_custom_children.dart';
import 'button_custom_color.dart';
import 'button_icon.dart';
import 'button_loading.dart';
import 'button_size.dart';
import 'package:flutter_element/flutter_element.dart';
import 'package:get/get.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            EButton(
              text: 'Primary Button',
              type: EButtonType.primary,
              onPressed: () {
                Get.toNamed('/button/basic');
              },
            ),
            const ButtonBasicPreview(),
            const ButtonDisablePreview(),
            const ButtonLinkPreview(),
            const ButtonIconPreview(),
            const ButtonCustomColorPreview(),
            const ButtonCustomChildrenPreview(),
            const ButtonSizePage(),
            const button_loading_preview(),
            // button_badge_preview(),
          ],
        ),
      ),
    );
  }
}
