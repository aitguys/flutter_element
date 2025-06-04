import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputNumberControlsPreview extends StatelessWidget {
  const InputNumberControlsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputNumber', 'input_number_controls.dart'),
      title: '步进幅度和范围限制',
    );
  }
}

class InputNumberControlsView extends StatelessWidget {
  const InputNumberControlsView({super.key});

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
  return Builder(
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          double? value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EInputNumber(
                value: value,
                onChanged: (v) {
                  setState(() => value = v);
                },
                step: 2,
                min: 0,
                max: 10000,
              ),
            ],
          );
        },
      );
    },
  );
}
