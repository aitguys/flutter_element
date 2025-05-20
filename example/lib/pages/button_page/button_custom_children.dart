import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class ButtonCustomChildrenPreview extends StatelessWidget {
  const ButtonCustomChildrenPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: buttonCustomChildren(),
      code:
          'https://aitmed-public.oss-cn-hangzhou.aliyuncs.com/button_custom_children.dart',
      title: '自定义内容按钮',
    );
  }
}

Widget buttonCustomChildren() {
  return Wrap(
    spacing: 8,
    runSpacing: 16,
    children: [
      EButton(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(height: 8),
              Text('Primary Button'),
              Text('Primary Button'),
            ],
          ),
        ),
        onPressed: () {},
      ),
    ],
  );
}
