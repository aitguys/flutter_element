import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';

class ButtonCustomColorPreview extends StatelessWidget {
  const ButtonCustomColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code:
          'https://aitmed-public.oss-cn-hangzhou.aliyuncs.com/button_custom_color.dart',
      title: '自定义颜色按钮',
    );
  }
}

class ButtonCustomColorView extends StatelessWidget {
  const ButtonCustomColorView({super.key});

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
  return Wrap(
    spacing: 8,
    runSpacing: 16,
    children: [
      EButton(
        text: 'Primary Button',
        type: EColorType.primary,
        color: Colors.purple,
        onPressed: () {},
      ),
      EButton(
        text: 'Primary Button',
        color: Colors.purple,
        isPlain: true,
        onPressed: () {},
      ),
      EButton(
        text: 'Primary Button',
        color: Colors.purple,
        isRound: true,
        onPressed: () {},
      ),
      EButton(
        color: Colors.purple,
        icon: Icons.add,
        onPressed: () {},
      ),
    ],
  );
}
