import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';
import 'package:logger/logger.dart';

class CheckboxDisablePreview extends StatelessWidget {
  const CheckboxDisablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('checkbox_page', 'checkbox_disable.dart'),
      title: '禁用状态',
    );
  }
}

class CheckboxDisableView extends StatelessWidget {
  const CheckboxDisableView({super.key});

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
        label: 'Disabled',
        disabled: true,
        onChange: (value) {
          Logger().d('Disabled: $value');
        },
      ),
      const SizedBox(width: 16),
      ECheckbox(
        label: 'Not disabled',
        onChange: (value) {
          Logger().d('Not disabled: $value');
        },
      ),
    ],
  );
}
