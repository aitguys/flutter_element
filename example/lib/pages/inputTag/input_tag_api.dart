import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputTagApiPreview extends StatelessWidget {
  const InputTagApiPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputTag', 'input_tag_api.dart'),
      title: 'API/事件',
    );
  }
}

class InputTagApiView extends StatelessWidget {
  const InputTagApiView({super.key});

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
                placeholder: 'api',
                clearable: true,
                prefix: const Icon(Icons.people),
                suffix: const Icon(Icons.search),
                max: 3,
                onChanged: (v) => setState(() => value = v ?? []),
                onFocus: () => debugPrint('onFocus'),
                onBlur: () => debugPrint('onBlur'),
                onAddTag: (tag, v) => debugPrint('onAddTag: $tag, $v'),
                onRemoveTag: (tag, v) => debugPrint('onRemoveTag: $tag, $v'),
                onClear: () => debugPrint('onClear'),
              ),
            ],
          );
        },
      );
    },
  );
}
