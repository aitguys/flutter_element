import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class ButtonIconPreview extends StatelessWidget {
  const ButtonIconPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code:
          'https://aitmed-public.oss-cn-hangzhou.aliyuncs.com/button_icon.dart',
      title: '图标按钮',
    );
  }
}

class ButtonIconView extends StatelessWidget {
  const ButtonIconView({super.key});

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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('基础用法'),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary Button',
            type: EButtonType.primary,
            icon: Icons.add,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.success,
            icon: Icons.add,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.warning,
            icon: Icons.add,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.danger,
            icon: Icons.add,
            onPressed: () {},
          ),
          EButton(
            type: EButtonType.info,
            text: 'Info Button',
            icon: Icons.add,
            onPressed: () {},
          ),
          EButton(
            type: EButtonType.default_,
            text: 'Default Button',
            icon: Icons.add,
            onPressed: () {},
          ),
        ],
      ),
      const SizedBox(height: 20),
      const Text('圆角按钮'),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary Button',
            type: EButtonType.primary,
            icon: Icons.add,
            isRound: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.success,
            icon: Icons.add,
            isRound: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.warning,
            icon: Icons.add,
            isRound: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.danger,
            icon: Icons.add,
            isRound: true,
            onPressed: () {},
          ),
          EButton(
            type: EButtonType.info,
            text: 'Info Button',
            icon: Icons.add,
            isRound: true,
            onPressed: () {},
          ),
          EButton(
            type: EButtonType.default_,
            text: 'Default Button',
            icon: Icons.add,
            isRound: true,
            onPressed: () {},
          ),
        ],
      ),
    ],
  );
}
