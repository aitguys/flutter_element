import 'package:flutter/material.dart';
import 'image_basic.dart';
import 'image_fit.dart';
import 'image_radius.dart';
import 'image_placeholder.dart';
import 'image_preview.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ImageBasicPreview(),
          ImageFitPreview(),
          ImageRadiusPreview(),
          ImagePlaceholderPreview(),
          ImagePreviewPreview(),
        ],
      ),
    );
  }
}
