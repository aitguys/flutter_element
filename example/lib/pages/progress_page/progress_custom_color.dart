import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ProgressCustomColorPreview extends StatelessWidget {
  const ProgressCustomColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('progress_page', 'progress_custom_color.dart'),
      title: '自定义进度条的颜色',
    );
  }
}

class ProgressCustomColorView extends StatelessWidget {
  const ProgressCustomColorView({super.key});

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
    builder: (context) => const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EProgress(
          percentage: 30,
          color: Colors.red,
        ),
        SizedBox(height: 16),
        EProgress(
          percentage: 30,
          color: Colors.orange,
        ),
      ],
    ),
  );
}
