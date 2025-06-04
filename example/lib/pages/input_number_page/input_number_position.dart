import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputNumberPositionPreview extends StatelessWidget {
  const InputNumberPositionPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputNumber', 'input_number_position.dart'),
      title: '按钮位置',
    );
  }
}

class InputNumberPositionView extends StatelessWidget {
  const InputNumberPositionView({super.key});

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
          double? value1, value2;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: EInputNumber(
                      value: value1,
                      onChanged: (v) {
                        setState(() => value1 = v);
                      },
                      controlsPosition: EInputNumberControlsPosition.left,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: EInputNumber(
                      value: value2,
                      onChanged: (v) {
                        setState(() => value2 = v);
                      },
                      controlsPosition: EInputNumberControlsPosition.right,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
}
