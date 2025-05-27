import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';
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
            type: EColorType.primary,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EColorType.success,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EColorType.warning,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EColorType.danger,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EColorType.info,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EColorType.default_,
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
            type: EColorType.primary,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EColorType.success,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EColorType.warning,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EColorType.danger,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EColorType.info,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EColorType.default_,
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
            type: EColorType.primary,
            isRound: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EColorType.success,
            isRound: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EColorType.warning,
            isRound: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EColorType.danger,
            isRound: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EColorType.info,
            isRound: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EColorType.default_,
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
            type: EColorType.primary,
            isRound: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EColorType.success,
            isRound: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EColorType.warning,
            isRound: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EColorType.danger,
            isRound: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EColorType.info,
            isRound: true,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EColorType.default_,
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
            type: EColorType.primary,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.check,
            type: EColorType.success,
            isDisabled: true,
            onPressed: () {},
          ),
          SizedBox(
            child: EButton(
              icon: Icons.message,
              type: EColorType.info,
              isDisabled: true,
              onPressed: () {},
            ),
          ),
          EButton(
            icon: Icons.star,
            type: EColorType.warning,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.delete,
            type: EColorType.danger,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.search,
            type: EColorType.default_,
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
            type: EColorType.primary,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.check,
            type: EColorType.success,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.message,
            type: EColorType.info,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.star,
            type: EColorType.warning,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.delete,
            type: EColorType.danger,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.search,
            type: EColorType.default_,
            isPlain: true,
            isDisabled: true,
            onPressed: () {},
          ),
        ],
      ),
    ],
  );
}
