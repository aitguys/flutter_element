import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class LinkBasicPreview extends StatelessWidget {
  const LinkBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('link_page', 'link_basic.dart'),
      title: '基础用法',
    );
  }
}

class LinkBasicView extends StatelessWidget {
  const LinkBasicView({super.key});

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
      spacing: 20,
      runSpacing: 20,
      children: [
        ELink(
          text: 'Default Link',
          colorType: EColorType.default_,
          onPressed: () {},
        ),
        ELink(
          text: 'Primary Link',
          colorType: EColorType.primary,
          onPressed: () {},
        ),
        ELink(
          text: 'Success Link',
          colorType: EColorType.success,
          onPressed: () {},
        ),
        ELink(
          text: 'Warning Link',
          colorType: EColorType.warning,
          onPressed: () {},
        ),
        ELink(
          text: 'Danger Link',
          colorType: EColorType.danger,
          onPressed: () {},
        ),
        ELink(
          text: 'Info Link',
          colorType: EColorType.info,
          onPressed: () {},
        ),
      ],
    ),
  );
}
