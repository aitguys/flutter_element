import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputTagSizePreview extends StatelessWidget {
  const InputTagSizePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputTag', 'input_tag_size.dart'),
      title: '不同尺寸',
    );
  }
}

class InputTagSizeView extends StatelessWidget {
  const InputTagSizeView({super.key});

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
      List<String> value1 = [], value2 = [];
      return StatefulBuilder(
        builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EInputTag(
                value: value1,
                size: ESizeItem.small,
                placeholder: 'small',
                onChanged: (v) => setState(() => value1 = v ?? []),
              ),
              const SizedBox(height: 16),
              EInputTag(
                value: value2,
                size: ESizeItem.large,
                placeholder: 'large',
                onChanged: (v) => setState(() => value2 = v ?? []),
              ),
            ],
          );
        },
      );
    },
  );
}
