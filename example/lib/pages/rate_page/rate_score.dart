import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class RateScorePreview extends StatelessWidget {
  const RateScorePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('rate_page', 'rate_score.dart'),
      title: '显示分数',
    );
  }
}

class RateScoreView extends StatelessWidget {
  const RateScoreView({super.key});

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
            showScore: true,
            scoreTemplate: 'Score: {value}',
            onChanged: (value) => setState(() => rate = value),
          );
        },
      );
    },
  );
}
