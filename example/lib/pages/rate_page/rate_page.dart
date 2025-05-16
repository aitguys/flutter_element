import 'package:flutter/material.dart';
import 'package:flutter_element/src/components/rate/rate.dart';

class RatePage extends StatefulWidget {
  const RatePage({Key? key}) : super(key: key);

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  double _rate1 = 0;
  double _rate2 = 0;
  double _rate3 = 0;
  double _rate4 = 0;
  double _rate5 = 0;
  double _rate6 = 0;
  double _rate7 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate 评分'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '基础用法',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ERate(
              value: _rate1,
              onChanged: (value) => setState(() => _rate1 = value),
            ),
            const SizedBox(height: 40),
            const Text(
              '不同颜色',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ERate(
              value: _rate2,
              colors: const [
                Color(0xFF99A9BF),
                Color(0xFFF7BA2A),
                Color(0xFFFF9900),
              ],
              onChanged: (value) => setState(() => _rate2 = value),
            ),
            const SizedBox(height: 40),
            const Text(
              '不同尺寸',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ERate(
              value: _rate3,
              size: ERateSize.large,
              onChanged: (value) => setState(() => _rate3 = value),
            ),
            const SizedBox(height: 20),
            ERate(
              value: _rate4,
              size: ERateSize.medium,
              onChanged: (value) => setState(() => _rate4 = value),
            ),
            const SizedBox(height: 20),
            ERate(
              value: _rate5,
              size: ERateSize.small,
              onChanged: (value) => setState(() => _rate5 = value),
            ),
            const SizedBox(height: 40),
            const Text(
              '允许半选',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ERate(
              value: _rate6,
              allowHalf: true,
              onChanged: (value) => setState(() => _rate6 = value),
            ),
            const SizedBox(height: 40),
            const Text(
              '显示文字',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ERate(
              value: _rate7,
              showText: true,
              texts: const ['极差', '失望', '一般', '满意', '惊喜'],
              onChanged: (value) => setState(() => _rate7 = value),
            ),
          ],
        ),
      ),
    );
  }
}
