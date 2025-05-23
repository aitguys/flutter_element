import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class AlertCenterPreview extends StatelessWidget {
  const AlertCenterPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('alert_page', 'alert_center.dart'),
      title: '居中对齐',
    );
  }
}

class AlertCenterView extends StatelessWidget {
  const AlertCenterView({super.key});

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
          title: '居中对齐的文案',
          description: '这是一句绕口令：黑灰化肥会挥发发灰黑化肥挥发；灰黑化肥会挥发发黑灰化肥发挥。',
          type: EColorType.info,
          center: true,
        ),
      ],
    ),
  );
}
