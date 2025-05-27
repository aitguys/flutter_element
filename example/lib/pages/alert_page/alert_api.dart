import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class AlertApiPreview extends StatelessWidget {
  const AlertApiPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('alert_page', 'alert_api.dart'),
      title: '函数调用方式',
    );
  }
}

class AlertApiView extends StatelessWidget {
  const AlertApiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _viewerContent(),
    );
  }
}

Widget _viewerContent() {
  return Builder(
    builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                showAlert(
                  context: context,
                  title: '成功提示',
                  description: '这是一条成功消息提示',
                  type: EColorType.success,
                  autoCloseDuration: const Duration(seconds: 3),
                );
              },
              child: const Text('显示成功提示'),
            ),
            ElevatedButton(
              onPressed: () {
                showAlert(
                  context: context,
                  title: '错误提示',
                  description: '这是一条错误消息提示',
                  type: EColorType.danger,
                  autoCloseDuration: const Duration(seconds: 3),
                );
              },
              child: const Text('显示错误提示'),
            ),
            ElevatedButton(
              onPressed: () {
                showAlert(
                  context: context,
                  title: '错误提示',
                  description: '1s后自动关闭',
                  type: EColorType.danger,
                  autoCloseDuration: const Duration(seconds: 1),
                );
              },
              child: const Text('显示错误提示, 1s后自动关闭'),
            ),
          ],
        ),
      ],
    ),
  );
}
