import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import 'package:flutter_element/src/components/badge/badge.dart';

class button_badge_preview extends StatelessWidget {
  const button_badge_preview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: button_badge(),
      code:
          'https://aitmed-public.oss-cn-hangzhou.aliyuncs.com/button_badge.dart',
      title: '徽章按钮',
    );
  }
}

Widget button_badge() {
  return Wrap(
    spacing: 8,
    runSpacing: 16,
    children: [
      EBadge(
        value: '99+',
        child: EButton(
          text: 'Primary Button',
          type: EButtonType.primary,
          onPressed: () {},
        ),
      ),
      EBadge(
        value: '99+',
        type: 'danger',
        child: EButton(
          text: 'Success Button',
          type: EButtonType.success,
          onPressed: () {},
        ),
      ),
      EBadge(
        value: '99+',
        type: 'warning',
        child: EButton(
          text: 'Warning Button',
          type: EButtonType.warning,
          onPressed: () {},
        ),
      ),
      EBadge(
        value: '99+',
        type: 'info',
        child: EButton(
          text: 'Danger Button',
          type: EButtonType.danger,
          onPressed: () {},
        ),
      ),
      EBadge(
        value: '99+',
        type: 'success',
        child: EButton(
          text: 'Info Button',
          type: EButtonType.info,
          onPressed: () {},
        ),
      ),
      EBadge(
        value: '99+',
        type: 'primary',
        child: EButton(
          text: 'Default Button',
          type: EButtonType.default_,
          onPressed: () {},
        ),
      ),
    ],
  );
}
