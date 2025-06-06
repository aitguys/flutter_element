import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class CardSimplePreview extends StatelessWidget {
  const CardSimplePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('card_page', 'card_simple.dart'),
      title: '简单卡片',
    );
  }
}

class CardSimpleView extends StatelessWidget {
  const CardSimpleView({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            4,
            (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text('List item ${i + 1}'),
                )),
      ),
    ),
  );
}
