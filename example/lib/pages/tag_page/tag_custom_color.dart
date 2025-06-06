import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class TagCustomColorPreview extends StatelessWidget {
  const TagCustomColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('tag_page', 'tag_custom_color.dart'),
      title: '自定义颜色',
    );
  }
}

class TagCustomColorView extends StatelessWidget {
  const TagCustomColorView({super.key});

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
    builder: (context) => Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        const ETag(
          text: '自定义颜色',
          color: Colors.white,
          backgroundColor: Colors.purple,
        ),
        ETag(
          text: '自定义边框',
          color: Colors.purple,
          backgroundColor: Colors.purple.withValues(alpha: 0.1),
        ),
      ],
    ),
  );
}
