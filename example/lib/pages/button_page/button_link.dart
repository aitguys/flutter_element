import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class ButtonLinkPreview extends StatelessWidget {
  const ButtonLinkPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('button_page', 'button_link.dart'),
      title: '链接按钮',
    );
  }
}

class ButtonLinkView extends StatelessWidget {
  const ButtonLinkView({super.key});

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
      const Text('链接按钮'),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary Button',
            type: EButtonType.primary,
            isLink: true,
            onPressed: () {
              print('点击了');
            },
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.success,
            isLink: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.warning,
            isLink: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.danger,
            isLink: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.info,
            isLink: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.default_,
            isLink: true,
            onPressed: () {},
          ),
        ],
      ),
      const Text('带图标的链接按钮'),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary Button',
            icon: Icons.edit,
            type: EButtonType.primary,
            isLink: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            icon: Icons.check,
            type: EButtonType.success,
            isLink: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            icon: Icons.star,
            type: EButtonType.warning,
            isLink: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            icon: Icons.delete,
            type: EButtonType.danger,
            isLink: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            icon: Icons.message,
            type: EButtonType.info,
            isLink: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            icon: Icons.search,
            type: EButtonType.default_,
            isLink: true,
            onPressed: () {},
          ),
        ],
      ),
      const Text('禁用链接按钮'),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary Button',
            type: EButtonType.primary,
            isLink: true,
            isDisabled: true,
            onPressed: () {
              print('点击了');
            },
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.success,
            isLink: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.warning,
            isLink: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.danger,
            isLink: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.info,
            isLink: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.default_,
            isLink: true,
            isDisabled: true,
            onPressed: () {},
          ),
        ],
      ),
      const Text('带图标的禁用链接按钮'),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary Button',
            icon: Icons.edit,
            type: EButtonType.primary,
            isLink: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            icon: Icons.check,
            type: EButtonType.success,
            isLink: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            icon: Icons.star,
            type: EButtonType.warning,
            isLink: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            icon: Icons.delete,
            type: EButtonType.danger,
            isLink: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            icon: Icons.message,
            type: EButtonType.info,
            isLink: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            icon: Icons.search,
            type: EButtonType.default_,
            isLink: true,
            isDisabled: true,
            onPressed: () {},
          ),
        ],
      ),
    ],
  );
}
