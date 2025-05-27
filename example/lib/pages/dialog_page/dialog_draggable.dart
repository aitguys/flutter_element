import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DialogDraggablePreview extends StatelessWidget {
  const DialogDraggablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('dialog_page', 'dialog_draggable.dart'),
      title: '可拖拽对话框',
    );
  }
}

class DialogDraggableView extends StatelessWidget {
  const DialogDraggableView({super.key});

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
          text: '打开可拖拽对话框',
          onPressed: () {
            showEDialog(
              context: context,
              title: '可拖拽对话框',
              content: const Text('这是一段内容'),
              draggable: true,
              actions: [
                EButton(
                  onPressed: () => Navigator.pop(context),
                  text: 'Cancel',
                  type: EColorType.default_,
                ),
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
