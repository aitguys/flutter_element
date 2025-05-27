import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';
import '../../const/index.dart';

class DialogBasicPreview extends StatelessWidget {
  const DialogBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('dialog_page', 'dialog_basic.dart'),
      title: '基础用法',
    );
  }
}

class DialogBasicView extends StatelessWidget {
  const DialogBasicView({super.key});

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
      children: [
        EButton(
          type: EColorType.primary,
          text: '点击打开 Dialog',
          onPressed: () {
            showEDialog(
              context: context,
              title: '提示',
              content: const Text('这是一段内容'),
              actions: [
                EButton(
                  onPressed: () => Navigator.pop(context),
                  text: 'Cancel',
                  type: EColorType.default_,
                ),
                const SizedBox(width: 10),
                EButton(
                  onPressed: () => Navigator.pop(context),
                  text: 'Confirm',
                  type: EColorType.primary,
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}
