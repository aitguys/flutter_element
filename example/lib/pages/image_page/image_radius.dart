import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ImageRadiusPreview extends StatelessWidget {
  const ImageRadiusPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('image_page', 'image_radius.dart'),
      title: '圆角图片',
    );
  }
}

class ImageRadiusView extends StatelessWidget {
  const ImageRadiusView({super.key});

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
          src: 'https://element-plus.org/images/element-plus-logo.svg',
          width: 120,
          height: 120,
          borderRadius: 10,
        ),
      ],
    ),
  );
}
