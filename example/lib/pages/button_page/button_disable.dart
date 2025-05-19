import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class ButtonDisablePreview extends StatelessWidget {
  const ButtonDisablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: buttonDisable(),
      code: getCodeUrl('button_page', 'button_disable.dart'),
      title: '禁用状态',
    );
  }
}

Widget buttonDisable() {
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
            isDisabled: true,
            onPressed: () {
              print('点击了');
            },
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.Success,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.Warning,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.Danger,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.Info,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.Default,
            isDisabled: true,
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
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.Success,
            size: EButtonSize.small,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.Warning,
            isPlain: true,
            isDisabled: true,
            size: EButtonSize.large,
            icon: Icons.add,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.Danger,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.Info,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.Default,
            isPlain: true,
            isDisabled: true,
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
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.Success,
            round: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.Warning,
            round: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.Danger,
            round: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.Info,
            round: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.Default,
            round: true,
            isDisabled: true,
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
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.check,
            type: EButtonType.Success,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.message,
            type: EButtonType.Info,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.star,
            type: EButtonType.Warning,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.delete,
            type: EButtonType.Danger,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.search,
            type: EButtonType.Default,
            isDisabled: true,
            onPressed: () {},
          ),
        ],
      ),
    ],
  );
}
