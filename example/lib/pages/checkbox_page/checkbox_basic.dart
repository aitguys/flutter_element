import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';
import 'package:logger/logger.dart';

class CheckboxBasicPreview extends StatelessWidget {
  const CheckboxBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('checkbox_page', 'checkbox_basic.dart'),
      title: '基础用法',
    );
  }
}

class CheckboxBasicView extends StatelessWidget {
  const CheckboxBasicView({super.key});

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
        onChange: (value) {
          Logger().d('Option 1: $value');
        },
      ),
      const SizedBox(width: 16),
      ECheckbox(
        label: 'Option 2',
        onChange: (value) {
          Logger().d('Option 2: $value');
        },
      ),
    ],
  );
}
