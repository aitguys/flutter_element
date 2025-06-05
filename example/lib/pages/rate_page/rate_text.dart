import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class RateTextPreview extends StatelessWidget {
  const RateTextPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('rate_page', 'rate_text.dart'),
      title: '显示文字',
    );
  }
}

class RateTextView extends StatelessWidget {
  const RateTextView({super.key});

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
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          double rate = 0;
          return ERate(
            value: rate,
            showText: true,
            texts: const ['极差', '失望', '一般', '满意', '惊喜'],
            onChanged: (value) => setState(() => rate = value),
          );
        },
      );
    },
  );
}
