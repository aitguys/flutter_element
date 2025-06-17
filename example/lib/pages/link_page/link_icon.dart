import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class LinkIconPreview extends StatelessWidget {
  const LinkIconPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('link_page', 'link_icon.dart'),
      title: '图标链接',
    );
  }
}

class LinkIconView extends StatelessWidget {
  const LinkIconView({super.key});

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
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 20,
      children: [
        ELink(
          text: 'Edit',
          type: EColorType.primary,
          icon: Icons.edit,
          onPressed: () {},
        ),
        ELink(
          text: 'Delete',
          type: EColorType.danger,
          icon: Icons.delete,
          onPressed: () {},
        ),
        ELink(
          text: 'View',
          type: EColorType.info,
          icon: Icons.visibility,
          onPressed: () {},
        ),
      ],
    ),
  );
}
