import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class RateSizePreview extends StatelessWidget {
  const RateSizePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('rate_page', 'rate_size.dart'),
      title: '不同尺寸',
    );
  }
}

class RateSizeView extends StatelessWidget {
  const RateSizeView({super.key});

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
          double rate1 = 0;
          double rate2 = 0;
          double rate3 = 0;
          return Column(
            children: [
              ERate(
                value: rate1,
                size: ESizeItem.large,
                onChanged: (value) => setState(() => rate1 = value),
              ),
              const SizedBox(height: 20),
              ERate(
                value: rate2,
                size: ESizeItem.medium,
                onChanged: (value) => setState(() => rate2 = value),
              ),
              const SizedBox(height: 20),
              ERate(
                value: rate3,
                size: ESizeItem.small,
                onChanged: (value) => setState(() => rate3 = value),
              ),
              const Text('自定义icon尺寸'),
              const SizedBox(height: 20),
              ERate(
                value: rate3,
                size: ESizeItem.small,
                customSize: 30,
                onChanged: (value) => setState(() => rate3 = value),
              ),
              // 自定义文字尺寸
              const Text('自定义文字尺寸'),
              const SizedBox(height: 20),
              ERate(
                value: rate3,
                size: ESizeItem.small,
                customFontSize: 10,
                showScore: true,
                scoreTemplate: 'Score: {value}',
                onChanged: (value) => setState(() => rate3 = value),
              ),
            ],
          );
        },
      );
    },
  );
}
