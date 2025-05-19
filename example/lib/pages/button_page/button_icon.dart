import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class button_icon_preview extends StatelessWidget {
  const button_icon_preview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: button_icon(),
      code:
          'https://aitmed-public.oss-cn-hangzhou.aliyuncs.com/button_icon.dart',
      title: '图标按钮',
    );
  }
}

Widget button_icon() {
  return Wrap(
    spacing: 8,
    runSpacing: 16,
    children: [
      EButton(
        text: 'Primary Button',
        type: EButtonType.Primary,
        icon: Icons.add,
        onPressed: () {},
      ),
      EButton(
        text: 'Success Button',
        type: EButtonType.Success,
        icon: Icons.add,
        onPressed: () {},
      ),
      EButton(
        text: 'Warning Button',
        type: EButtonType.Warning,
        icon: Icons.add,
        onPressed: () {},
      ),
      EButton(
        text: 'Danger Button',
        type: EButtonType.Danger,
        icon: Icons.add,
        onPressed: () {},
      ),
      EButton(
        type: EButtonType.Info,
        icon: Icons.add,
        onPressed: () {},
      ),
      EButton(
        type: EButtonType.Default,
        icon: Icons.add,
        onPressed: () {},
        round: true,
      ),
    ],
  );
}
