import 'package:flutter/material.dart';
import 'card_basic.dart';
import 'card_simple.dart';
import 'card_image.dart';
import 'card_shadow.dart';

class CardPreview extends StatelessWidget {
  const CardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          CardBasicPreview(),
          CardSimplePreview(),
          CardImagePreview(),
          CardShadowPreview(),
        ],
      ),
    );
  }
}
