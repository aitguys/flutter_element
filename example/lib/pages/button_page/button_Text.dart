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
            type: EButtonType.primary,
            onPressed: () {
              print('点击了');
            },
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.success,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.warning,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.danger,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.info,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.default_,
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
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.success,
            size: ESizeItem.small,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.warning,
            isPlain: true,
            size: ESizeItem.large,
            icon: Icons.add,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.danger,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.info,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.default_,
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
            type: EButtonType.primary,
            round: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.success,
            round: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.warning,
            round: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.danger,
            round: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.info,
            round: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.default_,
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
            type: EButtonType.primary,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.check,
            type: EButtonType.success,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.message,
            type: EButtonType.info,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.star,
            type: EButtonType.warning,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.delete,
            type: EButtonType.danger,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.search,
            type: EButtonType.default_,
            onPressed: () {},
          ),
        ],
      ),
    ],
  );
}
