import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ProgressBasicPreview extends StatelessWidget {
  const ProgressBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('progress_page', 'progress_basic.dart'),
      title: '基础用法',
    );
  }
}

class ProgressBasicView extends StatelessWidget {
  const ProgressBasicView({super.key});

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
        ),
        const SizedBox(height: 16),
        const EProgress(
          percentage: 40,
          colorType: EColorType.danger,
        ),
        const SizedBox(height: 16),
        EProgress(
          percentage: 30,
          customBuilder: (percentage) => Text(
            '您的进度已经有 ${percentage.toStringAsFixed(0)}% 了',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        const EProgress(
          percentage: 30,
          showText: false,
        ),
      ],
    ),
  );
}
