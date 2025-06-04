import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputNumberDisabledPreview extends StatelessWidget {
  const InputNumberDisabledPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputNumber', 'input_number_disabled.dart'),
      title: '禁用和只读',
    );
  }
}

class InputNumberDisabledView extends StatelessWidget {
  const InputNumberDisabledView({super.key});

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
      EInputNumber(
        value: 42,
        onChanged: (_) {},
        disabled: true,
      ),
      const SizedBox(height: 16),
      EInputNumber(
        value: 42,
        onChanged: (_) {},
        readOnly: true,
      ),
    ],
  );
}
