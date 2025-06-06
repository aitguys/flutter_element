import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ProgressCirclePreview extends StatelessWidget {
  const ProgressCirclePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('progress_page', 'progress_circle.dart'),
      title: '环形进度条',
    );
  }
}

class ProgressCircleView extends StatelessWidget {
  const ProgressCircleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _viewerContent(),
        ),
      ),
    );
  }
}

Widget _viewerContent() {
  return Builder(
    builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EProgress(
          percentage: 30,
          type: EProgressType.circle,
          width: 100,
        ),
        const SizedBox(height: 16),
        const EProgress(
          percentage: 30,
          type: EProgressType.circle,
          width: 100,
          colorType: EColorType.success,
        ),
        const SizedBox(height: 16),
        EProgress(
          percentage: 30,
          type: EProgressType.circle,
          width: 100,
          customBuilder: (percentage) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${percentage.toStringAsFixed(0)}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Progressing...',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
