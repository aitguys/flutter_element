import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ColorPickerBasicPreview extends StatelessWidget {
  const ColorPickerBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('color_picker_page', 'color_picker_basic.dart'),
      title: '基础用法',
    );
  }
}

class ColorPickerBasicView extends StatefulWidget {
  const ColorPickerBasicView({super.key});

  @override
  State<ColorPickerBasicView> createState() => _ColorPickerBasicViewState();
}

class _ColorPickerBasicViewState extends State<ColorPickerBasicView> {
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
            pickerColor: Colors.blue,
            onColorChanged: (color) {},
          ),
        ],
      );
    },
  );
}
