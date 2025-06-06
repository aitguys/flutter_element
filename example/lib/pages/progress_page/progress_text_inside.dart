import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ProgressTextInsidePreview extends StatelessWidget {
  const ProgressTextInsidePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('progress_page', 'progress_text_inside.dart'),
      title: '进度条内显示百分比标识',
    );
  }
}

class ProgressTextInsideView extends StatelessWidget {
  const ProgressTextInsideView({super.key});

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
          strokeWidth: 20,
          textInside: true,
        ),
      ],
    ),
  );
}
