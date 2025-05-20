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
            type: EButtonType.primary,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.success,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.warning,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.danger,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.info,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.default_,
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
            type: EButtonType.primary,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.success,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.warning,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.danger,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.info,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.default_,
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
            type: EButtonType.primary,
            round: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.success,
            round: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.warning,
            round: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.danger,
            round: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.info,
            round: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.default_,
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
            text: 'Primary Button',
            type: EButtonType.primary,
            round: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.success,
            round: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.warning,
            round: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.danger,
            round: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.info,
            round: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.default_,
            round: true,
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
            icon: Icons.edit,
            type: EButtonType.primary,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.check,
            type: EButtonType.success,
            isDisabled: true,
            onPressed: () {},
          ),
          SizedBox(
            child: EButton(
              icon: Icons.message,
              type: EButtonType.info,
              isDisabled: true,
              onPressed: () {},
            ),
          ),
          EButton(
            icon: Icons.star,
            type: EButtonType.warning,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.delete,
            type: EButtonType.danger,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.search,
            type: EButtonType.default_,
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
            type: EButtonType.primary,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.check,
            type: EButtonType.success,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.message,
            type: EButtonType.info,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.star,
            type: EButtonType.warning,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.delete,
            type: EButtonType.danger,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.search,
            type: EButtonType.default_,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
        ],
      ),
    ],
  );
}
