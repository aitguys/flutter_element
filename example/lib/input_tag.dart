import 'package:flutter/material.dart';
import 'package:flutter_element/src/components/input_tag/input_tag.dart';

class InputTagPage extends StatefulWidget {
  const InputTagPage({Key? key}) : super(key: key);

  @override
  State<InputTagPage> createState() => _InputTagPageState();
}

class _InputTagPageState extends State<InputTagPage> {
  List<String> _value = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EInputTag 测试')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Text('基础用法'),
            EInputTag(
              value: _value,
              onChanged: (value) => setState(() => _value = value ?? []),
            ),
          ],
        ),
      ),
    );
  }
}
