import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class WidgetPreviewTestPage extends StatelessWidget {
  const WidgetPreviewTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WidgetPreview 测试')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          WidgetPreview(
            widget: ElevatedButton(
              onPressed: () {},
              child: const Text('按钮示例'),
            ),
            code: '''
            
            ''',
          ),
          WidgetPreview(
            widget: Switch(
              value: true,
              onChanged: (_) {},
            ),
            code: '''
            
            ''',
          ),
        ],
      ),
    );
  }
}
