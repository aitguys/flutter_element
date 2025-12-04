import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class CardShadowPreview extends StatelessWidget {
  const CardShadowPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('card_page', 'card_shadow.dart'),
      title: '带有阴影效果的卡片',
    );
  }
}

class CardShadowView extends StatelessWidget {
  const CardShadowView({super.key});

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
        SizedBox(
          width: 120,
          child: ECard(
            showShadowWhenHover: false,
            header: Text('Always'),
            bodyStyle: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.red,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: SizedBox(height: 60),
          ),
        ),
        SizedBox(width: 16),
        SizedBox(
          width: 120,
          child: ECard(
            header: Text('Hover'),
            child: SizedBox(height: 60),
          ),
        ),
        SizedBox(width: 16),
      ],
    ),
  );
}
