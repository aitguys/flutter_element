import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputNumberCustomIconsPreview extends StatelessWidget {
  const InputNumberCustomIconsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputNumber', 'input_number_custom_icons.dart'),
      title: '自定义图标',
    );
  }
}

class InputNumberCustomIconsView extends StatelessWidget {
  const InputNumberCustomIconsView({super.key});

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
                decreaseIcon: const Icon(Icons.remove_circle_outline, size: 16),
                increaseIcon: const Icon(Icons.add_circle_outline, size: 16),
              ),
            ],
          );
        },
      );
    },
  );
}
