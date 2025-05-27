import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';
import 'package:logger/logger.dart';

class InputNumberPage extends StatefulWidget {
  const InputNumberPage({super.key});

  @override
  State<InputNumberPage> createState() => _InputNumberPageState();
}

class _InputNumberPageState extends State<InputNumberPage> {
  double? value1;
  double? value2;
  double? value3;
  double? value4;
  double? value5;
  double? value6;
  double? value7;
  double? value8;
  double? value9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EInputNumber 测试')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Text('步进测试'),
            EInputNumber(
              value: value9,
              onChanged: (v) => setState(() => value9 = v),
              step: 2,
              min: 0,
              max: 10000,
            ),
            const Text('基础用法'),
            EInputNumber(
              value: value1,
              onChanged: (v) {
                Logger().d('onChange: $v');
                setState(() => value1 = v);
              },
            ),
            const SizedBox(height: 24),
            const Text('可清空'),
            EInputNumber(
              value: value2,
              onChanged: (v) => setState(() => value2 = v),
              clearable: true,
            ),
            const SizedBox(height: 24),
            const Text('带前缀/后缀'),
            EInputNumber(
              value: value3,
              onChanged: (v) => setState(() => value3 = v),
              prefix: const Icon(Icons.search, size: 18),
              suffix:
                  const Icon(Icons.check_circle, size: 18, color: Colors.green),
            ),
            const SizedBox(height: 24),
            const Text('禁用'),
            EInputNumber(
              value: 42,
              onChanged: (_) {},
              disabled: true,
            ),
            const SizedBox(height: 24),
            const Text('只读'),
            EInputNumber(
              value: 42,
              onChanged: (_) {},
              readOnly: true,
            ),
            const SizedBox(height: 24),
            const Text('不同尺寸'),
            Row(
              children: [
                Expanded(
                  child: EInputNumber(
                    value: value4,
                    onChanged: (v) => setState(() => value4 = v),
                    size: EInputNumberSize.small,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: EInputNumber(
                    value: value5,
                    onChanged: (v) => setState(() => value5 = v),
                    size: EInputNumberSize.large,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('按钮位置'),
            Row(
              children: [
                Expanded(
                  child: EInputNumber(
                    value: value6,
                    onChanged: (v) => setState(() => value6 = v),
                    controlsPosition: EInputNumberControlsPosition.left,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: EInputNumber(
                    value: value7,
                    onChanged: (v) => setState(() => value7 = v),
                    controlsPosition: EInputNumberControlsPosition.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('自定义图标'),
            EInputNumber(
              value: value8,
              onChanged: (v) => setState(() => value8 = v),
              decreaseIcon: const Icon(Icons.remove_circle_outline, size: 16),
              increaseIcon: const Icon(Icons.add_circle_outline, size: 16),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
