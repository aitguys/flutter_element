// example/lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import 'button_page.dart';

void main() {
  runApp(const ElementXApp());
}

class ElementXApp extends StatelessWidget {
  const ElementXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Element'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EButton(
              text: 'Button Examples',
              type: EButtonType.Primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ButtonPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
