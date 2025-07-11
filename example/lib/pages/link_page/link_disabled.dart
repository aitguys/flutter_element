import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class LinkDisabledPreview extends StatelessWidget {
  const LinkDisabledPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('link_page', 'link_disabled.dart'),
      title: '禁用状态',
    );
  }
}

class LinkDisabledView extends StatelessWidget {
  const LinkDisabledView({super.key});

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
          disabled: true,
          onPressed: () {},
        ),
        ELink(
          text: 'Primary Link',
          colorType: EColorType.primary,
          disabled: true,
          onPressed: () {},
        ),
        ELink(
          text: 'Success Link',
          colorType: EColorType.success,
          disabled: true,
          onPressed: () {},
        ),
        ELink(
          text: 'Warning Link',
          colorType: EColorType.warning,
          disabled: true,
          onPressed: () {},
        ),
        ELink(
          text: 'Danger Link',
          colorType: EColorType.danger,
          disabled: true,
          onPressed: () {},
        ),
        ELink(
          text: 'Info Link',
          colorType: EColorType.info,
          disabled: true,
          onPressed: () {},
        ),
      ],
    ),
  );
}
