import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class button_loading_preview extends StatelessWidget {
  const button_loading_preview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: buttonLoading(),
      code:
          'https://aitmed-public.oss-cn-hangzhou.aliyuncs.com/button_loading.dart',
      title: '加载状态按钮',
    );
  }
}

Widget buttonLoading() {
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
