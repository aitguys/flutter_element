import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class AlertBasicPreview extends StatelessWidget {
  const AlertBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('alert_page', 'alert_basic.dart'),
      title: '基础用法',
    );
  }
}

class AlertBasicView extends StatelessWidget {
  const AlertBasicView({super.key});

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
        EAlert(
          title: 'type: EColorType.info',
          type: EColorType.info,
          closable: true,
        ),
        SizedBox(height: 16),
        EAlert(
          title: 'type: EColorType.success',
          type: EColorType.success,
        ),
        SizedBox(height: 16),
        EAlert(
          title: 'type: EColorType.warning',
          type: EColorType.warning,
        ),
        SizedBox(height: 16),
        EAlert(
          title: 'type: EColorType.danger',
          type: EColorType.danger,
        ),
        SizedBox(height: 16),
        EAlert(
          title: '自定义颜色： customColor: Colors.purple,',
          customColor: Colors.purple,
        ),
      ],
    ),
  );
}
