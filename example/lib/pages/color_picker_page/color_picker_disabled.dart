import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ColorPickerDisabledPreview extends StatelessWidget {
  const ColorPickerDisabledPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('color_picker_page', 'color_picker_disabled.dart'),
      title: '禁用',
    );
  }
}

class ColorPickerDisabledView extends StatelessWidget {
  const ColorPickerDisabledView({super.key});

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
            disabled: true,
            onColorChanged: (color) {},
          ),
        ],
      );
    },
  );
}
