import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputTagCustomColorPreview extends StatelessWidget {
  const InputTagCustomColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputTag', 'input_tag_custom_color.dart'),
      title: '自定义颜色',
    );
  }
}

class InputTagCustomColorView extends StatelessWidget {
  const InputTagCustomColorView({super.key});

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
      List<String> value = [];
      return StatefulBuilder(
        builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EInputTag(
                value: value,
                customColor: Colors.red,
                defaultColor: Colors.blue,
                onChanged: (v) => setState(() => value = v ?? []),
              ),
            ],
          );
        },
      );
    },
  );
}
