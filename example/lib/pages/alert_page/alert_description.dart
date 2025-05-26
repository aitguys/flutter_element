import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class AlertDescriptionPreview extends StatelessWidget {
  const AlertDescriptionPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('alert_page', 'alert_description.dart'),
      title: '辅助性文字介绍',
    );
  }
}

class AlertDescriptionView extends StatelessWidget {
  const AlertDescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _viewerContent(),
    );
  }
}

Widget _viewerContent() {
  return Builder(
    builder: (context) => const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EAlert(
          title: '带辅助性文字介绍',
          description:
              '这是一句绕口令：黑灰化肥会挥发发灰黑化肥挥发；灰黑化肥会挥发发黑灰化肥发挥。 黑灰化肥会挥发发灰黑化肥黑灰挥发化为灰……',
          type: EColorType.success,
        ),
      ],
    ),
  );
}
