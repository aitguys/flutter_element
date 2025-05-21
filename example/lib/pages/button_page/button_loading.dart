import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class ButtonLoadingPreview extends StatelessWidget {
  const ButtonLoadingPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code:
          'https://aitmed-public.oss-cn-hangzhou.aliyuncs.com/button_loading.dart',
      title: '加载状态按钮',
    );
  }
}

class ButtonLoadingView extends StatelessWidget {
  const ButtonLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  return const Wrap(
    spacing: 8,
    runSpacing: 16,
    children: [
      EButton(
        text: 'Primary Button',
        type: EButtonType.primary,
        loading: true,
      ),
      EButton(
        text: 'Primary Button',
        type: EButtonType.primary,
        loading: true,
        loadingIcon: Icons.add,
      ),
    ],
  );
}
