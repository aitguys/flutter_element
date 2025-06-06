import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ProgressAnimatedPreview extends StatelessWidget {
  const ProgressAnimatedPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('progress_page', 'progress_animated.dart'),
      title: '动画进度条',
    );
  }
}

class ProgressAnimatedView extends StatelessWidget {
  const ProgressAnimatedView({super.key});

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
          indeterminate: true,
          duration: 2,
        ),
        SizedBox(height: 16),
        EProgress(
          type: EProgressType.circle,
          percentage: 30,
          width: 100,
          indeterminate: true,
          duration: 2,
        ),
      ],
    ),
  );
}
