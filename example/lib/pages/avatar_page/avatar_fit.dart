import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class AvatarFitPreview extends StatelessWidget {
  const AvatarFitPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('avatar_page', 'avatar_fit.dart'),
      title: 'fit 适应容器',
    );
  }
}

class AvatarFitView extends StatelessWidget {
  const AvatarFitView({super.key});

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
        EAvatar(
          src:
              'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
          customSize: 60,
          shape: EAvatarShape.square,
          fit: BoxFit.fill,
        ),
        SizedBox(width: 16),
        EAvatar(
          src:
              'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
          customSize: 60,
          shape: EAvatarShape.square,
          fit: BoxFit.contain,
        ),
        SizedBox(width: 16),
        EAvatar(
          src:
              'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
          customSize: 60,
          shape: EAvatarShape.square,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 16),
        EAvatar(
          src:
              'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
          customSize: 60,
          shape: EAvatarShape.square,
          fit: BoxFit.none,
        ),
        SizedBox(width: 16),
        EAvatar(
          src:
              'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
          customSize: 60,
          shape: EAvatarShape.square,
          fit: BoxFit.scaleDown,
        ),
      ],
    ),
  );
}
