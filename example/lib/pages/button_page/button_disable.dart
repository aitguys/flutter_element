import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class ButtonDisablePreview extends StatelessWidget {
  const ButtonDisablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('button_page', 'button_disable.dart'),
      title: '禁用状态',
    );
  }
}

class ButtonDisableView extends StatelessWidget {
  const ButtonDisableView({super.key});
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
            isRound: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.success,
            isRound: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.warning,
            isRound: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.danger,
            isRound: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.info,
            isRound: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.default_,
            isRound: true,
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
            isRound: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EButtonType.success,
            isRound: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EButtonType.warning,
            isRound: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EButtonType.danger,
            isRound: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EButtonType.info,
            isRound: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EButtonType.default_,
            isRound: true,
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
