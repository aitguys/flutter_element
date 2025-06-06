import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ColorPickerAlphaPreview extends StatelessWidget {
  const ColorPickerAlphaPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('color_picker_page', 'color_picker_alpha.dart'),
      title: '带 Alpha 通道',
    );
  }
}

class ColorPickerAlphaView extends StatefulWidget {
  const ColorPickerAlphaView({super.key});

  @override
  State<ColorPickerAlphaView> createState() => _ColorPickerAlphaViewState();
}

class _ColorPickerAlphaViewState extends State<ColorPickerAlphaView> {
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
            pickerColor: Colors.blue.withValues(alpha: 0.5),
            showAlpha: true,
            onColorChanged: (color) {},
          ),
        ],
      );
    },
  );
}
