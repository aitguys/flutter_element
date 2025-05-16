import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import 'package:flutter_element/src/components/progress/progress.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress 进度条')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('线形进度条'),
            const SizedBox(height: 16),
            EProgress(percentage: 30, width: 200),
            const SizedBox(height: 16),
            EProgress(percentage: 70, width: 200, color: Colors.orange),
            const SizedBox(height: 16),
            EProgress(
                percentage: 100, width: 200, status: EProgressStatus.success),
            const SizedBox(height: 16),
            EProgress(
                percentage: 50, width: 200, status: EProgressStatus.warning),
            const SizedBox(height: 16),
            EProgress(
                percentage: 80, width: 200, status: EProgressStatus.exception),
            const SizedBox(height: 32),
            const Text('不同尺寸'),
            const SizedBox(height: 16),
            EProgress(percentage: 60, width: 200, strokeWidth: 12),
            const SizedBox(height: 32),
            const Text('环形进度条'),
            const SizedBox(height: 16),
            Row(
              children: [
                EProgress(
                    type: EProgressType.circle, percentage: 40, width: 80),
                const SizedBox(width: 24),
                EProgress(
                    type: EProgressType.circle,
                    percentage: 100,
                    width: 80,
                    status: EProgressStatus.success),
                const SizedBox(width: 24),
                EProgress(
                    type: EProgressType.circle,
                    percentage: 80,
                    width: 80,
                    status: EProgressStatus.exception),
              ],
            ),
            const SizedBox(height: 32),
            const Text('自定义文本'),
            const SizedBox(height: 16),
            EProgress(percentage: 75, width: 200, text: '75/100'),
          ],
        ),
      ),
    );
  }
}
