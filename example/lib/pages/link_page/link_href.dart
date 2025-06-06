import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';
import '../../logger/logger.dart';

class LinkHrefPreview extends StatelessWidget {
  const LinkHrefPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('link_page', 'link_href.dart'),
      title: '链接属性',
    );
  }
}

class LinkHrefView extends StatelessWidget {
  const LinkHrefView({super.key});

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
      children: [
        ELink(
          text: '点击跳转',
          type: EColorType.default_,
          underline: false,
          target: '_blank',
          href: 'https://www.flutter-element.com',
          onPressed: () {},
        ),
        const SizedBox(width: 16),
        ELink(
          text: '点击跳触发onPress',
          type: EColorType.primary,
          underline: false,
          onPressed: () {
            Loglevel.d('onPressed');
          },
        ),
      ],
    ),
  );
}
