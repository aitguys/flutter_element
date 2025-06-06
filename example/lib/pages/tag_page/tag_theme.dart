import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class TagThemePreview extends StatelessWidget {
  const TagThemePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('tag_page', 'tag_theme.dart'),
      title: '主题',
    );
  }
}

class TagThemeView extends StatelessWidget {
  const TagThemeView({super.key});

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
        ETag(text: '默认标签'),
        ETag(text: '圆角标签', isRound: true),
        ETag(text: '标记标签', type: EColorType.primary, isCircle: true),
      ],
    ),
  );
}
