import 'package:flutter/material.dart';
import 'button_basic.dart';
import 'button_disable.dart';
import 'button_link.dart';
import 'button_custom_children.dart';
import 'button_custom_color.dart';
import 'button_icon.dart';
import 'button_loading.dart';
import 'button_size.dart';
import 'button_api.dart';

class ButtonPreview extends StatelessWidget {
  const ButtonPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '按钮组件',
          style: TextStyle(fontSize: 15),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 16,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: const Column(
            children: [
              ButtonBasicPreview(),
              ButtonDisablePreview(),
              ButtonLinkPreview(),
              ButtonIconPreview(),
              ButtonCustomColorPreview(),
              ButtonCustomChildrenPreview(),
              ButtonSizePreview(),
              ButtonLoadingPreview(),
              ButtonApiPreview(),
            ],
          ),
        ),
      ),
    );
  }
}
