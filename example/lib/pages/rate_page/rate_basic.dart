import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class RateBasicPreview extends StatelessWidget {
  const RateBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('rate_page', 'rate_basic.dart'),
      title: '基础用法',
    );
  }
}

class RateBasicView extends StatelessWidget {
  const RateBasicView({super.key});

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
          return Column(
            children: [
              const Text('基础用法'),
              ERate(
                value: rate,
                onChanged: (value) => setState(() => rate = value),
                scoreTemplate: 'Score: {value}',
              ),
              const SizedBox(height: 20),
              // 设置最大值
              const Text('设置最大值'),
              ERate(
                value: rate,
                onChanged: (value) => setState(() => rate = value),
                scoreTemplate: 'Score: {value}',
                max: 10,
              ),
            ],
          );
        },
      );
    },
  );
}
