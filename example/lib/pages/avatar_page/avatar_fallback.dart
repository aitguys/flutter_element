import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class AvatarFallbackPreview extends StatelessWidget {
  const AvatarFallbackPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('avatar_page', 'avatar_fallback.dart'),
      title: '加载失败回退',
    );
  }
}

class AvatarFallbackView extends StatelessWidget {
  const AvatarFallbackView({super.key});

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
        EAvatar(
          src: 'https://empty',
          customSize: 60,
          fallback: Image.network(
              'https://cube.elemecdn.com/e/fd/0fc7d20532fdaf769a25683617711png.png'),
        ),
        const SizedBox(width: 16),
        const EAvatar(
          src: 'https://empty',
          customSize: 60,
          icon: Icons.person,
        ),
        const SizedBox(width: 16),
        const EAvatar(
          src: 'https://empty',
          customSize: 60,
          text: 'A',
        ),
      ],
    ),
  );
}
