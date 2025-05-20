import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class ButtonSizePage extends StatelessWidget {
  const ButtonSizePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: buttonSize(),
      code: getCodeUrl('button_page', 'button_size.dart'),
      title: '不同尺寸的按钮',
    );
  }
}

Widget buttonSize() {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary',
            type: EButtonType.primary,
            size: ESizeItem.large,
          ),
          EButton(
            text: 'Success',
            type: EButtonType.success,
            size: ESizeItem.medium,
          ),
          EButton(
            text: 'Warning',
            type: EButtonType.warning,
            size: ESizeItem.small,
          ),
        ],
      ),
      SizedBox(height: 16),
      Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary',
            type: EButtonType.primary,
            size: ESizeItem.large,
            round: true,
          ),
          EButton(
            text: 'Success',
            type: EButtonType.success,
            size: ESizeItem.medium,
            round: true,
          ),
          EButton(
            text: 'Warning',
            type: EButtonType.warning,
            size: ESizeItem.small,
            round: true,
          ),
        ],
      ),
      SizedBox(height: 16),
      Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary',
            type: EButtonType.primary,
            size: ESizeItem.large,
            icon: Icons.add,
          ),
          EButton(
            text: 'Success',
            type: EButtonType.success,
            size: ESizeItem.medium,
            icon: Icons.add,
          ),
          EButton(
            text: 'Warning',
            type: EButtonType.warning,
            size: ESizeItem.small,
            icon: Icons.add,
          ),
        ],
      ),
      SizedBox(height: 16),
      Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          SizedBox(
            width: 150,
            height: 50,
            child: EButton(
              text: 'Primary',
              type: EButtonType.primary,
              size: ESizeItem.large,
              icon: Icons.add,
            ),
          ),
          SizedBox(
            width: 150,
            height: 50,
            child: EButton(
              type: EButtonType.primary,
              size: ESizeItem.large,
              icon: Icons.add,
            ),
          ),
        ],
      ),
    ],
  );
}
