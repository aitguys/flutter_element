import 'package:flutter/material.dart';
import 'package:flutter_element_example/logger/logger.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ColorPickerApiPreview extends StatelessWidget {
  const ColorPickerApiPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('color_picker_page', 'color_picker_api.dart'),
      title: 'API',
    );
  }
}

class ColorPickerApiView extends StatelessWidget {
  const ColorPickerApiView({super.key});

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
            onColorChanged: (color) {
              Loglevel.d('onColorChanged - color: $color');
            },
            onConfirm: (color) {
              Loglevel.d('onConfirm - color: $color');
            },
            onCancel: () {
              Loglevel.d('onCancel');
            },
          ),
        ],
      );
    },
  );
}
