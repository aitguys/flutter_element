import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class CardImagePreview extends StatelessWidget {
  const CardImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('card_page', 'card_image.dart'),
      title: '有图片内容的卡片',
    );
  }
}

class CardImageView extends StatelessWidget {
  const CardImageView({super.key});

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
    builder: (context) => ECard(
      width: 400,
      header: const Text('Yummy hamburger'),
      child: Image.network(
        'https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png',
        width: 400,
        fit: BoxFit.cover,
      ),
    ),
  );
}
