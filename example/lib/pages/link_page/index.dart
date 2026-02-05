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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '链接组件',
          style: TextStyle(fontSize: 15),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 16),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: const Column(
            children: [
              LinkBasicPreview(),
              LinkDisabledPreview(),
              LinkIconPreview(),
              LinkUnderlinePreview(),
              LinkHrefPreview(),
            ],
          ),
        ),
      ),
    );
  }
}
