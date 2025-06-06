import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class TagBasicPreview extends StatelessWidget {
  const TagBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('tag_page', 'tag_basic.dart'),
      title: '基础用法',
    );
  }
}

class TagBasicView extends StatelessWidget {
  const TagBasicView({super.key});

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
        ETag(text: '标签一'),
        ETag(text: '标签二', type: EColorType.success),
        ETag(text: '标签三', type: EColorType.info),
        ETag(text: '标签四', type: EColorType.warning),
        ETag(text: '标签五', type: EColorType.danger),
      ],
    ),
  );
}
