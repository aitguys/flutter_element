import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class AlertThemePreview extends StatelessWidget {
  const AlertThemePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('alert_page', 'alert_theme.dart'),
      title: '主题切换',
    );
  }
}

class AlertThemeView extends StatelessWidget {
  const AlertThemeView({super.key});

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
        Text('Alert 组件提供了两个不同的主题：light 和 dark。通过设置 effect 属性来改变主题，默认为 dark',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        EAlert(
          title: 'type: EColorType.info',
          type: EColorType.info,
          closable: true,
          theme: EThemeType.light,
        ),
        SizedBox(height: 16),
        EAlert(
          title: 'type: EColorType.success',
          type: EColorType.success,
          theme: EThemeType.light,
        ),
        SizedBox(height: 16),
        EAlert(
          title: 'type: EColorType.warning',
          type: EColorType.warning,
          theme: EThemeType.light,
        ),
        SizedBox(height: 16),
        EAlert(
          title: 'type: EColorType.danger',
          type: EColorType.danger,
          theme: EThemeType.light,
        ),
        SizedBox(height: 16),
        EAlert(
          title: '自定义颜色： customColor: Colors.purple,',
          customColor: Colors.purple,
          theme: EThemeType.light,
        ),
      ],
    ),
  );
}
