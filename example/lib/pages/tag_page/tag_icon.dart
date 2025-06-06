import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class TagIconPreview extends StatelessWidget {
  const TagIconPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('tag_page', 'tag_icon.dart'),
      title: '带图标',
    );
  }
}

class TagIconView extends StatelessWidget {
  const TagIconView({super.key});

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
    builder: (context) => const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ETag(
          text: '标签',
          icon: Icon(Icons.check_circle),
          type: EColorType.success,
        ),
        ETag(
          text: '标签',
          icon: Icon(Icons.info),
          type: EColorType.info,
        ),
        ETag(
          text: '标签',
          icon: Icon(Icons.warning),
          type: EColorType.warning,
        ),
        ETag(
          text: '标签',
          icon: Icon(Icons.error),
          type: EColorType.danger,
        ),
      ],
    ),
  );
}
