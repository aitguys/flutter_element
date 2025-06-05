import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class RateColorsPreview extends StatelessWidget {
  const RateColorsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('rate_page', 'rate_colors.dart'),
      title: '不同颜色',
    );
  }
}

class RateColorsView extends StatelessWidget {
  const RateColorsView({super.key});

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
              const Text('自定义不同颜色'),
              ERate(
                value: rate,
                colors: const [
                  Color(0xFF99A9BF),
                  Color(0xFFF7BA2A),
                  Color(0xFFFF9900),
                ],
                onChanged: (value) => setState(() => rate = value),
              ),
              const SizedBox(height: 20),
              const Text('根据颜色类型设置颜色'),
              ERate(
                value: rate,
                colorType: EColorType.success,
                onChanged: (value) => setState(() => rate = value),
              ),
              // 自定义单个颜色
              const SizedBox(height: 20),
              const Text('自定义单个颜色'),
              ERate(
                value: rate,
                colors: const [Color(0xFF99A9BF)],
                onChanged: (value) => setState(() => rate = value),
              ),
            ],
          );
        },
      );
    },
  );
}
