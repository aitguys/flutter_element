import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';
import 'package:logger/logger.dart';

class CheckboxGroupPreview extends StatelessWidget {
  const CheckboxGroupPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('checkbox_page', 'checkbox_group.dart'),
      title: '组合/组',
    );
  }
}

class CheckboxGroupView extends StatelessWidget {
  const CheckboxGroupView({super.key});

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
  return ECheckboxGroup(
    value: const ['Option A'],
    onChange: (values) {
      Logger().d('Selected values: $values');
    },
    children: const [
      ECheckbox(label: 'Option A'),
      ECheckbox(label: 'Option B'),
      ECheckbox(label: 'Option C'),
      ECheckbox(label: 'Disabled', disabled: true),
      ECheckbox(label: 'Selected and disabled', disabled: true),
    ],
  );
}
