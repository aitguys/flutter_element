import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputNumberStylePreview extends StatelessWidget {
  const InputNumberStylePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputNumber', 'input_number_style.dart'),
      title: '自定义样式',
    );
  }
}

class InputNumberStyleView extends StatelessWidget {
  const InputNumberStyleView({super.key});

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
                colorType: EColorType.success,
                customColor: Colors.green,
                defaultColor: Colors.green,
                customHeight: 40,
                customFontSize: 16,
                customBorderRadius: 10,
              ),
            ],
          );
        },
      );
    },
  );
}
