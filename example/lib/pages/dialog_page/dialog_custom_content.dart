import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class DialogCustomContentPreview extends StatelessWidget {
  const DialogCustomContentPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('dialog_page', 'dialog_custom_content.dart'),
      title: '自定义内容',
    );
  }
}

class DialogCustomContentView extends StatelessWidget {
  const DialogCustomContentView({super.key});

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
        EButton(
          type: EColorType.primary,
          text: '点击打开 Dialog',
          onPressed: () {
            showEDialog(
              context: context,
              title: '自定义内容',
              content: const SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    TextField(
                      decoration: InputDecoration(
                        labelText: '用户名',
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: '密码',
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
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
