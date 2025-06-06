import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class AvatarTypePreview extends StatelessWidget {
  const AvatarTypePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('avatar_page', 'avatar_type.dart'),
      title: '展示类型',
    );
  }
}

class AvatarTypeView extends StatelessWidget {
  const AvatarTypeView({super.key});

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
        EAvatar(icon: Icons.person, customSize: 40),
        SizedBox(width: 16),
        EAvatar(
          src:
              'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',
          customSize: 40,
        ),
        SizedBox(width: 16),
        EAvatar(text: 'user', customSize: 40),
      ],
    ),
  );
}
