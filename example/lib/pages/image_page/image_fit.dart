import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ImageFitPreview extends StatelessWidget {
  const ImageFitPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('image_page', 'image_fit.dart'),
      title: '不同 fit',
    );
  }
}

class ImageFitView extends StatelessWidget {
  const ImageFitView({super.key});

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
    builder: (context) => const Row(
      children: [
        EImage(
          src:
              'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
          width: 80,
          height: 80,
          fit: BoxFit.fill,
        ),
        SizedBox(width: 16),
        EImage(
          src:
              'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
          width: 80,
          height: 80,
          fit: BoxFit.contain,
        ),
        SizedBox(width: 16),
        EImage(
          src:
              'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 16),
        EImage(
          src:
              'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
          width: 80,
          height: 80,
          fit: BoxFit.none,
        ),
        SizedBox(width: 16),
        EImage(
          src:
              'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
          width: 80,
          height: 80,
          fit: BoxFit.scaleDown,
        ),
      ],
    ),
  );
}
