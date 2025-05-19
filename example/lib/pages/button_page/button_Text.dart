import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class ButtonBasicPreview extends StatelessWidget {
  const ButtonBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: buttonBasic(),
      code: getCodeUrl('button_page', 'button_basic.dart'),
      title: '基础用法',
    );
  }
}

Widget buttonBasic() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary Button',
            type: EButtonType.Primary,
            onPressed: () {
              print('点击了');
            },
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.Success,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.Warning,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.Danger,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.Info,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.Default,
            onPressed: () {},
          ),
        ],
      ),
      const SizedBox(height: 20),
      Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary Button',
            type: EButtonType.Primary,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.Success,
            size: EButtonSize.small,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.Warning,
            isPlain: true,
            size: EButtonSize.large,
            icon: Icons.add,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.Danger,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.Info,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.Default,
            isPlain: true,
            onPressed: () {},
          ),
        ],
      ),
      const SizedBox(height: 20),
      Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary Button',
            type: EButtonType.Primary,
            round: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.Success,
            round: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.Warning,
            round: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.Danger,
            round: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.Info,
            round: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.Default,
            round: true,
            onPressed: () {},
          ),
        ],
      ),
      const SizedBox(height: 20),
      Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          EButton(
            icon: Icons.edit,
            type: EButtonType.Primary,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.check,
            type: EButtonType.Success,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.message,
            type: EButtonType.Info,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.star,
            type: EButtonType.Warning,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.delete,
            type: EButtonType.Danger,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.search,
            type: EButtonType.Default,
            onPressed: () {},
          ),
        ],
      ),
    ],
  );
}
