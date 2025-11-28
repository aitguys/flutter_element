import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ButtonBasicPreview extends StatelessWidget {
  const ButtonBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('button_page', 'button_basic.dart'),
      title: '基础用法, isPlain, isRound, icon ',
    );
  }
}

class ButtonBasicView extends StatelessWidget {
  const ButtonBasicView({super.key});

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
          SizedBox(
            width: 400,
            child: EButton(
              text: 'Primary Button',
              loading: true,
              type: EColorType.primary,
              onPressed: () {},
            ),
          ),
          EButton(
            text: 'Success Button',
            type: EColorType.success,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EColorType.warning,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EColorType.danger,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EColorType.info,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EColorType.default_,
            onPressed: () {},
          ),
        ],
      ),
      const SizedBox(height: 20),
      const Text('渐变按钮'),
      const SizedBox(height: 20),
      Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary Button',
            type: EColorType.primary,
            gradient: const LinearGradient(
              colors: [Color(0xFF9ec7f7), Color(0xFF4982f7)],
            ),
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
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EColorType.success,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EColorType.warning,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EColorType.danger,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EColorType.info,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EColorType.default_,
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
            type: EColorType.primary,
            isRound: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EColorType.success,
            isRound: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EColorType.warning,
            isRound: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EColorType.danger,
            isRound: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EColorType.info,
            isRound: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EColorType.default_,
            isRound: true,
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
            onPressed: () {},
          ),
          EButton(
            text: 'Success Button',
            type: EColorType.success,
            isRound: true,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Warning Button',
            type: EColorType.warning,
            isRound: true,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Danger Button',
            type: EColorType.danger,
            isRound: true,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Info Button',
            type: EColorType.info,
            isRound: true,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            text: 'Default Button',
            type: EColorType.default_,
            isRound: true,
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
            icon: Icons.edit,
            type: EColorType.primary,
            isCircle: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.check,
            type: EColorType.success,
            isCircle: true,
            onPressed: () {},
          ),
          SizedBox(
            child: EButton(
              icon: Icons.message,
              type: EColorType.info,
              isCircle: true,
              onPressed: () {},
            ),
          ),
          EButton(
            icon: Icons.star,
            type: EColorType.warning,
            isCircle: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.delete,
            type: EColorType.danger,
            isCircle: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.search,
            type: EColorType.default_,
            isCircle: true,
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
            onPressed: () {},
          ),
          EButton(
            icon: Icons.check,
            type: EColorType.success,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.message,
            type: EColorType.info,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.star,
            type: EColorType.warning,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.delete,
            type: EColorType.danger,
            isPlain: true,
            onPressed: () {},
          ),
          EButton(
            icon: Icons.search,
            type: EColorType.default_,
            isPlain: true,
            isRound: false,
            onPressed: () {},
          ),
        ],
      ),
    ],
  );
}
