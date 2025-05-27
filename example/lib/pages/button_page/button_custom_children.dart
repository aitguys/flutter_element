import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class ButtonCustomChildrenPreview extends StatelessWidget {
  const ButtonCustomChildrenPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code:
          'https://aitmed-public.oss-cn-hangzhou.aliyuncs.com/button_custom_children.dart',
      title: '自定义内容按钮',
    );
  }
}

class ButtonCustomChildrenView extends StatelessWidget {
  const ButtonCustomChildrenView({super.key});

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
