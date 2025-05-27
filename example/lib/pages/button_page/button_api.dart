import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';
import '../../const/index.dart';

class ButtonApiPreview extends StatelessWidget {
  const ButtonApiPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(context),
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
          child: _viewerContent(context),
        ),
      ),
    );
  }
}

Widget _viewerContent(BuildContext context) {
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
              if (isHover) {
                EMessageController.info(context, 'hover', duration: 300);
              } else {
                EMessageController.info(context, 'out', duration: 300);
              }
            },
            onPressed: () {
              EMessageController.info(context, '点击了', duration: 300);
            },
            onLongPressed: () {
              EMessageController.info(context, '长按了', duration: 300);
            },
          ),
        ],
      ),
    ],
  );
}
