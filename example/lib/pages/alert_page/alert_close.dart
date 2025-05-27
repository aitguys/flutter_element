import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class AlertClosePreview extends StatelessWidget {
  const AlertClosePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('alert_page', 'alert_close.dart'),
      title: '自定义关闭组件',
    );
  }
}

class AlertCloseView extends StatelessWidget {
  const AlertCloseView({super.key});

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
        Text('自定义关闭组件',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        EAlert(
          title: 'closeButton: Text(\'关闭\'), 自定义关闭组件',
          type: EColorType.info,
          closable: true,
          theme: EThemeType.light,
          closeButton: Text('关闭'),
        ),
        SizedBox(height: 16),
        Text('closable 属性为 false 时，不会显示关闭按钮',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        EAlert(
          title: 'closable: false, 不会显示关闭按钮',
          type: EColorType.info,
          closable: false,
          theme: EThemeType.light,
        ),
        SizedBox(height: 16),
        Text('showIcon 属性为 false 时，不会显示图标',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        EAlert(
          title: 'showIcon: false, 不会显示图标',
          type: EColorType.info,
          showIcon: false,
          theme: EThemeType.light,
        ),
      ],
    ),
  );
}
