import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class CardBasicPreview extends StatelessWidget {
  const CardBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('card_page', 'card_basic.dart'),
      title: '基础用法',
    );
  }
}

class CardBasicView extends StatelessWidget {
  const CardBasicView({super.key});

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
      header: const Text('Card name',
          style: TextStyle(fontWeight: FontWeight.bold)),
      footer: const Text('Footer content'),
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
