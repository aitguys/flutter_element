import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class TagSizePreview extends StatelessWidget {
  const TagSizePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('tag_page', 'tag_size.dart'),
      title: '不同尺寸',
    );
  }
}

class TagSizeView extends StatelessWidget {
  const TagSizeView({super.key});

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
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ETag(text: '大型标签', size: ESizeItem.large),
        ETag(text: '默认标签'),
        ETag(text: '小型标签', size: ESizeItem.small),
      ],
    ),
  );
}
