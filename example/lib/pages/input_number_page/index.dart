import 'package:flutter/material.dart';
import 'input_number_basic.dart';
import 'input_number_controls.dart';
import 'input_number_clearable.dart';
import 'input_number_prefix_suffix.dart';
import 'input_number_custom_icons.dart';
import 'input_number_disabled.dart';
import 'input_number_size.dart';
import 'input_number_position.dart';
import 'input_number_style.dart';
import 'input_number_api.dart';

class InputNumberPreview extends StatelessWidget {
  const InputNumberPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          InputNumberBasicPreview(),
          InputNumberControlsPreview(),
          InputNumberClearablePreview(),
          InputNumberPrefixSuffixPreview(),
          InputNumberCustomIconsPreview(),
          InputNumberDisabledPreview(),
          InputNumberSizePreview(),
          InputNumberPositionPreview(),
          InputNumberStylePreview(),
          InputNumberApiPreview(),
        ],
      ),
    );
  }
}
