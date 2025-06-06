import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class AvatarBasicPreview extends StatelessWidget {
  const AvatarBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('avatar_page', 'avatar_basic.dart'),
      title: '基础用法',
    );
  }
}

class AvatarBasicView extends StatelessWidget {
  const AvatarBasicView({super.key});

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
              'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
          customSize: 50,
        ),
        SizedBox(width: 16),
        EAvatar(
          src:
              'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png',
          customSize: 50,
          shape: EAvatarShape.square,
        ),
      ],
    ),
  );
}
