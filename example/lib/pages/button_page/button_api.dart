import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class ButtonApiPreview extends StatelessWidget {
  const ButtonApiPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('button_page', 'button_basic.dart'),
      title: '尝试鼠标掠过、点击、长按事件',
    );
  }
}

class ButtonApiView extends StatelessWidget {
  const ButtonApiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _viewerContent(),
        ),
      ),
    );
  }
}

Widget _viewerContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary Button',
            type: EColorType.primary,
            onHover: (isHover) {
              print('hover: $isHover');
            },
            onPressed: () {
              print('点击了');
            },
            onLongPressed: () {
              print('长按了');
            },
          ),
        ],
      ),
    ],
  );
}
