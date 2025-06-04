import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputNumberBasicPreview extends StatelessWidget {
  const InputNumberBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputNumber', 'input_number_basic.dart'),
      title: '基础用法',
    );
  }
}

class InputNumberBasicView extends StatelessWidget {
  const InputNumberBasicView({super.key});

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
          double? value = 2;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EInputNumber(
                value: value,
                onChanged: (v) {
                  setState(() => value = v);
                },
              ),
            ],
          );
        },
      );
    },
  );
}
