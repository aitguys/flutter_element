import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';
import 'package:logger/logger.dart';

class CheckboxBorderPreview extends StatelessWidget {
  const CheckboxBorderPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('checkbox_page', 'checkbox_border.dart'),
      title: '边框',
    );
  }
}

class CheckboxBorderView extends StatelessWidget {
  const CheckboxBorderView({super.key});

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
        border: true,
        onChange: (value) {
          Logger().d('Option 1 with border: $value');
        },
      ),
      const SizedBox(width: 16),
      ECheckbox(
        label: 'Option 2',
        border: true,
        onChange: (value) {
          Logger().d('Option 2 with border: $value');
        },
      ),
    ],
  );
}
