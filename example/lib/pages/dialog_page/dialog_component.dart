import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';
import '../../const/index.dart';

class DialogComponentPreview extends StatelessWidget {
  const DialogComponentPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('dialog_page', 'dialog_component.dart'),
      title: '组件式调用',
    );
  }
}

class DialogComponentView extends StatelessWidget {
  const DialogComponentView({super.key});

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
  return Builder(
    builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 这里仅做按钮演示，具体内容在 View 中
        EDialog(
          visible: true,
          title: '组件式调用',
          content: const Text('通过visible组件式调用，可以控制弹窗的显示和隐藏'),
          onClose: () {},
          actions: [
            EButton(
              onPressed: () {},
              child: const Text('取消'),
            ),
            EButton(
              onPressed: () {},
              child: const Text('确定'),
            ),
          ],
        ),
      ],
    ),
  );
}
