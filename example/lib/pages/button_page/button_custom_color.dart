import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class button_custom_color_preview extends StatelessWidget {
  const button_custom_color_preview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: button_custom_color(),
      code:
          'https://aitmed-public.oss-cn-hangzhou.aliyuncs.com/button_custom_color.dart',
      title: '自定义颜色按钮',
    );
  }
}

Widget button_custom_color() {
  return Wrap(
    spacing: 8,
    runSpacing: 16,
    children: [
      EButton(
        text: 'Primary Button',
        type: EButtonType.Primary,
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
        round: true,
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
