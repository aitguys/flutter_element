import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputTagTriggerPreview extends StatelessWidget {
  const InputTagTriggerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputTag', 'input_tag_trigger.dart'),
      title: '触发方式',
    );
  }
}

class InputTagTriggerView extends StatelessWidget {
  const InputTagTriggerView({super.key});

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
                placeholder: 'enter 触发',
                trigger: EInputTagTrigger.enter,
                onChanged: (v) => setState(() => value1 = v ?? []),
              ),
              const SizedBox(height: 16),
              EInputTag(
                value: value2,
                placeholder: 'space 触发',
                trigger: EInputTagTrigger.space,
                onChanged: (v) => setState(() => value2 = v ?? []),
              ),
            ],
          );
        },
      );
    },
  );
}
