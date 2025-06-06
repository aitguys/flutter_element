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
    builder: (context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ELink(
          text: 'Default Link',
          type: EColorType.default_,
          onPressed: () {},
        ),
        ELink(
          text: 'Primary Link',
          type: EColorType.primary,
          onPressed: () {},
        ),
        ELink(
          text: 'Success Link',
          type: EColorType.success,
          onPressed: () {},
        ),
        ELink(
          text: 'Warning Link',
          type: EColorType.warning,
          onPressed: () {},
        ),
        ELink(
          text: 'Danger Link',
          type: EColorType.danger,
          onPressed: () {},
        ),
        ELink(
          text: 'Info Link',
          type: EColorType.info,
          onPressed: () {},
        ),
      ],
    ),
  );
}
