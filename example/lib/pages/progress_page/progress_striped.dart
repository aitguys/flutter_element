import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ProgressStripedPreview extends StatelessWidget {
  const ProgressStripedPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('progress_page', 'progress_striped.dart'),
      title: '条纹进度条',
    );
  }
}

class ProgressStripedView extends StatelessWidget {
  const ProgressStripedView({super.key});

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
          striped: true,
          duration: 2,
        ),
        SizedBox(height: 16),
        EProgress(
          percentage: 100,
          striped: true,
          stripedFlow: true,
          color: Colors.orange,
          duration: 1,
        ),
      ],
    ),
  );
}
