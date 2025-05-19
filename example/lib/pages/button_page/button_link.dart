import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class ButtonLinkPreview extends StatelessWidget {
  const ButtonLinkPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: buttonLink(),
      code: getCodeUrl('button_page', 'button_link.dart'),
      title: '链接按钮',
    );
  }
}

Widget buttonLink() {
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
            type: EButtonType.Primary,
            link: true,
            onPressed: () {
              print('点击了');
            },
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.Success,
            link: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.Warning,
            link: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.Danger,
            link: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.Info,
            link: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.Default,
            link: true,
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
            type: EButtonType.Primary,
            link: true,
            isDisabled: true,
            onPressed: () {
              print('点击了');
            },
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.Success,
            link: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.Warning,
            link: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.Danger,
            link: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.Info,
            link: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.Default,
            link: true,
            isDisabled: true,
            onPressed: () {},
          ),
        ],
      ),
    ],
  );
}
