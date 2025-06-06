import 'package:flutter/material.dart';
import 'link_basic.dart';
import 'link_disabled.dart';
import 'link_icon.dart';
import 'link_underline.dart';
import 'link_href.dart';

class LinkPreview extends StatelessWidget {
  const LinkPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          LinkBasicPreview(),
          LinkDisabledPreview(),
          LinkIconPreview(),
          LinkUnderlinePreview(),
          LinkHrefPreview(),
        ],
      ),
    );
  }
}
