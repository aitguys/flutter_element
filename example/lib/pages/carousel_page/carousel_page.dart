import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carousel 走马灯')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础用法'),
            const SizedBox(height: 16),
            ECarousel(
              height: 150,
              autoplay: true,
              interval: const Duration(seconds: 3),
              items: List.generate(4, (i) => _buildItem(i)),
            ),
            const SizedBox(height: 32),
            const Text('点击指示器切换'),
            const SizedBox(height: 16),
            ECarousel(
              height: 150,
              items: List.generate(4, (i) => _buildItem(i)),
              showIndicator: true,
              arrow: ECarouselArrow.always,
              autoplay: false,
            ),
            const SizedBox(height: 32),
            const Text('垂直方向'),
            const SizedBox(height: 16),
            ECarousel(
              height: 200,
              items: List.generate(4, (i) => _buildItem(i)),
              direction: ECarouselDirection.vertical,
              autoplay: false,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildItem(int i) {
    final colors = [
      Colors.blue[100],
      Colors.green[100],
      Colors.orange[100],
      Colors.purple[100]
    ];
    return Container(
      color: colors[i % colors.length],
      child: Center(
        child: Text(
          '${i + 1}',
          style: const TextStyle(fontSize: 48, color: Colors.black54),
        ),
      ),
    );
  }
}
