import 'package:flutter/material.dart';
import 'alert_basic.dart';
import 'alert_theme.dart';
import 'alert_close.dart';
import 'alert_description.dart';
import 'alert_center.dart';
import 'alert_api.dart';

class AlertPreview extends StatelessWidget {
  const AlertPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('按钮组件'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            AlertBasicPreview(),
            AlertThemePreview(),
            AlertClosePreview(),
            AlertDescriptionPreview(),
            AlertCenterPreview(),
            AlertApiPreview(),
          ],
        ),
      ),
    );
  }
}
