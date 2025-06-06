import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ImageBasicPreview extends StatelessWidget {
  const ImageBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('image_page', 'image_basic.dart'),
      title: '基础用法',
    );
  }
}

class ImageBasicView extends StatelessWidget {
  const ImageBasicView({super.key});

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
    builder: (context) => const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EImage(
          src: 'assets/image/logo.png',
          width: 120,
          height: 120,
          preview: true,
        ),
      ],
    ),
  );
}
