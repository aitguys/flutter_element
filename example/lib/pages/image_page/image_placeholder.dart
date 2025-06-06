import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ImagePlaceholderPreview extends StatelessWidget {
  const ImagePlaceholderPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('image_page', 'image_placeholder.dart'),
      title: '占位/加载失败',
    );
  }
}

class ImagePlaceholderView extends StatelessWidget {
  const ImagePlaceholderView({super.key});

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
      children: [
        EImage(
          src: 'https://not-exist-url.png',
          width: 80,
          height: 80,
          placeholder: Container(
            width: 80,
            height: 80,
            color: Colors.grey[200],
            child: const Center(child: Text('加载中')),
          ),
        ),
        const SizedBox(width: 16),
        EImage(
          src: 'https://not-exist-url.png',
          width: 80,
          height: 80,
          placeholder: Container(
            width: 80,
            height: 80,
            color: Colors.red[200],
            child: const Center(child: Text('加载中')),
          ),
          errorWidget: Container(
            width: 80,
            height: 80,
            color: Colors.red[100],
            child: const Center(child: Text('加载失败')),
          ),
        ),
      ],
    ),
  );
}
