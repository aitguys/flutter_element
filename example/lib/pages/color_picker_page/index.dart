import 'package:flutter/material.dart';
import 'color_picker_alpha.dart';
import 'color_picker_predefine.dart';
import 'color_picker_size.dart';
import 'color_picker_disabled.dart';
import 'color_picker_basic.dart';
import 'color_picker_api.dart';

class ColorPickerPreview extends StatelessWidget {
  const ColorPickerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ColorPickerBasicPreview(),
          ColorPickerAlphaPreview(),
          ColorPickerPredefinePreview(),
          ColorPickerSizePreview(),
          ColorPickerDisabledPreview(),
          ColorPickerApiPreview(),
        ],
      ),
    );
  }
}
