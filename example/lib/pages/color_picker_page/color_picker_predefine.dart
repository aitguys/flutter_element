import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ColorPickerPredefinePreview extends StatelessWidget {
  const ColorPickerPredefinePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('color_picker_page', 'color_picker_predefine.dart'),
      title: '预设颜色',
    );
  }
}

class ColorPickerPredefineView extends StatelessWidget {
  const ColorPickerPredefineView({super.key});

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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EColorPicker(
            pickerColor: Colors.green,
            showAlpha: true,
            predefine: [
              Colors.red,
              Colors.green,
              Colors.blue,
              Colors.yellow,
              Colors.purple,
              Colors.orange,
              Colors.pink,
              Colors.teal,
            ],
            onColorChanged: (color) {},
            onConfirm: (color) {},
            onCancel: () {},
          ),
        ],
      );
    },
  );
}
