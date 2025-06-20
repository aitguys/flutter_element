import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';
import '../../logger/logger.dart';
import 'package:get/get.dart';

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
  final showUnderline = false.obs;
  return Builder(
    builder: (context) => Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(
          () => ELink(
            text: '点击跳转',
            colorType: EColorType.primary,
            underline: showUnderline.value,
            target: '_blank',
            href: 'https://www.flutter-element.com',
            onPressed: () {},
            onHover: (isHovered) {
              Loglevel.d('onHover: $isHovered');
              showUnderline.value = isHovered;
            },
          ),
        ),
        const SizedBox(width: 16),
        ELink(
          text: '点击跳触发onPress',
          colorType: EColorType.primary,
          underline: false,
          onPressed: () {
            Loglevel.d('onPressed');
          },
        ),
      ],
    ),
  );
}
