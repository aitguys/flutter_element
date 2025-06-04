import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputTagPrefixSuffixPreview extends StatelessWidget {
  const InputTagPrefixSuffixPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputTag', 'input_tag_prefix_suffix.dart'),
      title: '自定义 prefix 和 suffix',
    );
  }
}

class InputTagPrefixSuffixView extends StatelessWidget {
  const InputTagPrefixSuffixView({super.key});

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
                clearable: true,
                prefix: const Icon(Icons.people),
                suffix: const Icon(Icons.search),
                onChanged: (v) => setState(() => value = v ?? []),
              ),
            ],
          );
        },
      );
    },
  );
}
