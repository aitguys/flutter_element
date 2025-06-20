import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class LinkUnderlinePreview extends StatelessWidget {
  const LinkUnderlinePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('link_page', 'link_underline.dart'),
      title: '无下划线',
    );
  }
}

class LinkUnderlineView extends StatelessWidget {
  const LinkUnderlineView({super.key});

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
    builder: (context) => const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ELink(
          text: 'Default Link',
          colorType: EColorType.default_,
          underline: false,
        ),
        ELink(
          text: 'Primary Link',
          colorType: EColorType.primary,
          underline: false,
        ),
        ELink(
          text: 'Success Link',
          colorType: EColorType.success,
          underline: false,
        ),
      ],
    ),
  );
}
