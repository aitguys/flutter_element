import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class AffixPage extends StatelessWidget {
  const AffixPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EAffix 测试')),
      body: ListView(
        children: [
          Container(height: 300, color: Colors.grey[100]),
          EAffix(
            offsetTop: 0,
            zIndex: 10,
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16),
              child: const Text('Affix Top',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(height: 600, color: Colors.grey[200]),
          EAffix(
            offsetBottom: 0,
            zIndex: 10,
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(16),
              child: const Text('Affix Bottom',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(height: 300, color: Colors.grey[100]),
        ],
      ),
    );
  }
}
