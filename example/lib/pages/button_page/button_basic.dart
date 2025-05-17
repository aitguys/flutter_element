import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class button_basic_preview extends StatelessWidget {
  const button_basic_preview({super.key});

  @override
  Widget build(BuildContext context) {
    return button_basic();
  }
}

class button_basic extends StatelessWidget {
  const button_basic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 16,
              children: [
                EButton(
                  text: 'Primary Button',
                  type: EButtonType.Primary,
                  isDisabled: true,
                  onPressed: () {
                    print('点击了');
                  },
                ),
                EButton(
                  text: 'Success Button',
                  type: EButtonType.Success,
                  onPressed: () {},
                ),
                EButton(
                  text: 'Warning Button',
                  type: EButtonType.Warning,
                  onPressed: () {},
                ),
                EButton(
                  text: 'Danger Button',
                  type: EButtonType.Danger,
                  onPressed: () {},
                ),
                EButton(
                  text: 'Info Button',
                  type: EButtonType.Info,
                  onPressed: () {},
                ),
                EButton(
                  text: 'Default Button',
                  type: EButtonType.Default,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ));
  }
}
