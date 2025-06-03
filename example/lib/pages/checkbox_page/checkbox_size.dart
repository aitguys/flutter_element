import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';
import 'package:logger/logger.dart';

class CheckboxSizePreview extends StatelessWidget {
  const CheckboxSizePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('checkbox_page', 'checkbox_size.dart'),
      title: '尺寸/字体',
    );
  }
}

class CheckboxSizeView extends StatelessWidget {
  const CheckboxSizeView({super.key});

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
  return Row(
    children: [
      ECheckbox(
        label: 'Option 1',
        size: ESizeItem.large,
        onChange: (value) {
          Logger().d('Option 1: $value');
        },
      ),
      ECheckbox(
        label: 'Option 2',
        size: ESizeItem.medium,
        onChange: (value) {
          Logger().d('Option 2: $value');
        },
      ),
      ECheckbox(
        label: 'Option 2',
        size: ESizeItem.small,
        onChange: (value) {
          Logger().d('Option 2: $value');
        },
      ),
      ECheckbox(
        label: 'Option 2',
        customFontSize: 30,
        onChange: (value) {
          Logger().d('Option 2: $value');
        },
      ),
    ],
  );
}
