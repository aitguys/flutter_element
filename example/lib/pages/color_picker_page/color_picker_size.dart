import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ColorPickerSizePreview extends StatelessWidget {
  const ColorPickerSizePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('color_picker_page', 'color_picker_size.dart'),
      title: '不同尺寸',
    );
  }
}

class ColorPickerSizeView extends StatelessWidget {
  const ColorPickerSizeView({super.key});

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
      return Row(
        children: [
          EColorPicker(
            pickerColor: Colors.green,
            size: ESizeItem.large,
            onColorChanged: (color) {},
          ),
          const SizedBox(width: 16),
          EColorPicker(
            pickerColor: Colors.green,
            size: ESizeItem.medium,
            onColorChanged: (color) {},
          ),
          const SizedBox(width: 16),
          EColorPicker(
            pickerColor: Colors.green,
            size: ESizeItem.small,
            onColorChanged: (color) {},
          ),
          const SizedBox(width: 16),
          EColorPicker(
            pickerColor: Colors.green,
            size: ESizeItem.small,
            customSize: 20,
            onColorChanged: (color) {},
          ),
        ],
      );
    },
  );
}
