import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputTagDelimiterPreview extends StatelessWidget {
  const InputTagDelimiterPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputTag', 'input_tag_delimiter.dart'),
      title: '分隔符',
    );
  }
}

class InputTagDelimiterView extends StatelessWidget {
  const InputTagDelimiterView({super.key});

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
                trigger: EInputTagTrigger.space,
                delimiter: ',',
                onChanged: (v) => setState(() => value = v ?? []),
              ),
            ],
          );
        },
      );
    },
  );
}
