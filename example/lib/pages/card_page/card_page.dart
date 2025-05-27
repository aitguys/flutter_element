import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card 卡片')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础用法'),
            const SizedBox(height: 16),
            ECard(
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
            const SizedBox(height: 32),
            const Text('简单卡片'),
            const SizedBox(height: 16),
            ECard(
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
            const SizedBox(height: 32),
            const Text('有图片内容的卡片'),
            const SizedBox(height: 16),
            ECard(
              width: 400,
              header: const Text('Yummy hamburger'),
              child: Image.network(
                'https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png',
                width: 400,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 32),
            const Text('带有阴影效果的卡片'),
            const SizedBox(height: 16),
            const Row(
              children: [
                SizedBox(
                  width: 120,
                  child: ECard(
                    header: Text('Always'),
                    shadow: ECardShadow.always,
                    child: SizedBox(height: 60),
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(
                  width: 120,
                  child: ECard(
                    header: Text('Hover'),
                    shadow: ECardShadow.hover,
                    child: SizedBox(height: 60),
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(
                  width: 120,
                  child: ECard(
                    header: Text('Never'),
                    shadow: ECardShadow.never,
                    child: SizedBox(height: 60),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
