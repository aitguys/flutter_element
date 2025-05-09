import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import 'package:flutter_element/src/components/card/card.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

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
            Row(
              children: [
                Container(
                  width: 120,
                  child: ECard(
                    header: const Text('Always'),
                    shadow: ECardShadow.always,
                    child: const SizedBox(height: 60),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 120,
                  child: ECard(
                    header: const Text('Hover'),
                    shadow: ECardShadow.hover,
                    child: const SizedBox(height: 60),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 120,
                  child: ECard(
                    header: const Text('Never'),
                    shadow: ECardShadow.never,
                    child: const SizedBox(height: 60),
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
