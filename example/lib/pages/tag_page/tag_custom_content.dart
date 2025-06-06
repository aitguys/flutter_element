import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class TagCustomContentPreview extends StatelessWidget {
  const TagCustomContentPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('tag_page', 'tag_custom_content.dart'),
      title: '自定义内容',
    );
  }
}

class TagCustomContentView extends StatelessWidget {
  const TagCustomContentView({super.key});

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
        ETag(text: '标签', child: Text('自定义内容')),
        ETag(
          text: '标签',
          icon: Icon(Icons.check_circle),
          type: EColorType.success,
          child: Text('自定义内容'),
        ),
      ],
    ),
  );
}
