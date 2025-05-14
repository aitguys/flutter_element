import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class StepsPage extends StatefulWidget {
  const StepsPage({Key? key}) : super(key: key);

  @override
  State<StepsPage> createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {
  int _active = 0;

  final List<EStep> _steps = [
    const EStep(
      title: '步骤 1',
      description: '这是一段很长的描述性文字',
      icon: Icons.edit,
    ),
    const EStep(
      title: '步骤 2',
      description: '这是一段很长的描述性文字',
    ),
    const EStep(
      title: '步骤 3',
      description: '这是一段很长的描述性文字',
    ),
    const EStep(
      title: '步骤 4',
      description: '这是一段很长的描述性文字',
    ),
  ];

  void _next() {
    if (_active < _steps.length - 1) {
      setState(() {
        _active++;
      });
    }
  }

  void _prev() {
    if (_active > 0) {
      setState(() {
        _active--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Steps 步骤条'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础用法',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ESteps(
              steps: _steps,
              active: _active,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _active > 0 ? _prev : null,
                  child: const Text('上一步'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _active < _steps.length - 1 ? _next : null,
                  child: const Text('下一步'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('垂直方向',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ESteps(
              steps: _steps,
              active: _active,
              direction: EStepDirection.vertical,
            ),
            const SizedBox(height: 32),
            const Text('居中对齐',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ESteps(
              steps: _steps,
              active: _active,
              alignCenter: true,
            ),
            const SizedBox(height: 32),
            const Text('点状步骤条',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ESteps(
              steps: _steps,
              active: _active,
              progressDot: true,
            ),
          ],
        ),
      ),
    );
  }
}
