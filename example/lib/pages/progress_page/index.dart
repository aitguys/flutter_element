import 'package:flutter/material.dart';
import 'progress_basic.dart';
import 'progress_text_inside.dart';
import 'progress_custom_color.dart';
import 'progress_circle.dart';
import 'progress_animated.dart';
import 'progress_striped.dart';

class ProgressPreview extends StatelessWidget {
  const ProgressPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ProgressBasicPreview(),
          ProgressTextInsidePreview(),
          ProgressCustomColorPreview(),
          ProgressCirclePreview(),
          ProgressAnimatedPreview(),
          ProgressStripedPreview(),
        ],
      ),
    );
  }
}
