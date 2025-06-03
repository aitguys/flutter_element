import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';
import 'package:logger/logger.dart';

class CheckboxThemePreview extends StatelessWidget {
  const CheckboxThemePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('checkbox_page', 'checkbox_theme.dart'),
      title: '自定义样式',
    );
  }
}

class CheckboxThemeView extends StatelessWidget {
  const CheckboxThemeView({super.key});

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
  return Row(
    children: [
      ECheckbox(
        label: 'Option 1',
        fontColorType: EColorType.warning,
        iconColorType: EColorType.primary,
        onChange: (value) {
          Logger().d('Option 1: $value');
        },
      ),
      ECheckbox(
        label: 'Option 1',
        fontCustomColor: Colors.red,
        iconCustomColor: Colors.blue,
        onChange: (value) {
          Logger().d('Option 1: $value');
        },
      ),
    ],
  );
}
