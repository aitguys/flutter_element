import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ButtonSizePreview extends StatelessWidget {
  const ButtonSizePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('button_page', 'button_size.dart'),
      title: '不同尺寸的按钮',
    );
  }
}

class ButtonSizeView extends StatelessWidget {
  const ButtonSizeView({super.key});

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
            type: EColorType.primary,
            size: ESizeItem.large,
          ),
          EButton(
            text: 'Success',
            type: EColorType.success,
            size: ESizeItem.medium,
          ),
          EButton(
            text: 'Warning',
            type: EColorType.warning,
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
            type: EColorType.primary,
            size: ESizeItem.large,
            isRound: true,
          ),
          EButton(
            text: 'Success',
            type: EColorType.success,
            size: ESizeItem.medium,
            isRound: true,
          ),
          EButton(
            text: 'Warning',
            type: EColorType.warning,
            size: ESizeItem.small,
            isRound: true,
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
            type: EColorType.primary,
            size: ESizeItem.large,
            icon: Icons.add,
          ),
          EButton(
            text: 'Success',
            type: EColorType.success,
            size: ESizeItem.medium,
            icon: Icons.add,
          ),
          EButton(
            text: 'Warning',
            type: EColorType.warning,
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
              type: EColorType.primary,
              size: ESizeItem.large,
              icon: Icons.add,
            ),
          ),
          SizedBox(
            width: 150,
            height: 50,
            child: EButton(
              type: EColorType.primary,
              size: ESizeItem.large,
              icon: Icons.add,
            ),
          ),
        ],
      ),
      // 自定义文字大小
      SizedBox(height: 16),
      Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          EButton(
            text: 'Primary',
            type: EColorType.primary,
            fontSize: 14,
          ),
          EButton(
            text: 'Success',
            type: EColorType.success,
            fontSize: 16,
          ),
          EButton(
            text: 'Warning',
            type: EColorType.warning,
            fontSize: 18,
          ),
        ],
      ),
    ],
  );
}
