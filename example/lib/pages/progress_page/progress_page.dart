import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress 进度条')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('线形进度条'),
            SizedBox(height: 16),
            EProgress(percentage: 30, width: 200),
            SizedBox(height: 16),
            EProgress(percentage: 70, width: 200, color: Colors.orange),
            SizedBox(height: 16),
            EProgress(
                percentage: 100, width: 200, status: EProgressStatus.success),
            SizedBox(height: 16),
            EProgress(
                percentage: 50, width: 200, status: EProgressStatus.warning),
            SizedBox(height: 16),
            EProgress(
                percentage: 80, width: 200, status: EProgressStatus.exception),
            SizedBox(height: 32),
            Text('不同尺寸'),
            SizedBox(height: 16),
            EProgress(percentage: 60, width: 200, strokeWidth: 12),
            SizedBox(height: 32),
            Text('环形进度条'),
            SizedBox(height: 16),
            Row(
              children: [
                EProgress(
                    type: EProgressType.circle, percentage: 40, width: 80),
                SizedBox(width: 24),
                EProgress(
                    type: EProgressType.circle,
                    percentage: 100,
                    width: 80,
                    status: EProgressStatus.success),
                SizedBox(width: 24),
                EProgress(
                    type: EProgressType.circle,
                    percentage: 80,
                    width: 80,
                    status: EProgressStatus.exception),
              ],
            ),
            SizedBox(height: 32),
            Text('自定义文本'),
            SizedBox(height: 16),
            EProgress(percentage: 75, width: 200, text: '75/100'),
          ],
        ),
      ),
    );
  }
}
