import 'package:flutter/material.dart';
import 'checkbox_basic.dart';
import 'checkbox_theme.dart';
import 'checkbox_size.dart';
import 'checkbox_disable.dart';
import 'checkbox_group.dart';
import 'checkbox_border.dart';
import 'checkbox_select_all.dart';

class CheckboxPreview extends StatelessWidget {
  const CheckboxPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox 组件'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CheckboxBasicPreview(),
            CheckboxThemePreview(),
            CheckboxSizePreview(),
            CheckboxDisablePreview(),
            CheckboxGroupPreview(),
            CheckboxBorderPreview(),
            CheckboxSelectAllPreview(),
          ],
        ),
      ),
    );
  }
}
