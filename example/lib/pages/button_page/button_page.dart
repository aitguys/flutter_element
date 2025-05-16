import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import 'package:flutter_element/src/components/badge/badge.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Examples'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('按钮类型 - Default'),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              Text('按钮类型 - Plain'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EButton(
                    text: 'Primary Button',
                    type: EButtonType.Primary,
                    isPlain: true,
                    isDisabled: true,
                    onPressed: () {},
                  ),
                  EButton(
                    text: 'Success Button',
                    type: EButtonType.Success,
                    size: EButtonSize.small,
                    isPlain: true,
                    onPressed: () {},
                  ),
                  EButton(
                    text: 'Warning Button',
                    type: EButtonType.Warning,
                    isPlain: true,
                    size: EButtonSize.large,
                    icon: Icons.add,
                    onPressed: () {},
                  ),
                  EButton(
                    text: 'Danger Button',
                    type: EButtonType.Danger,
                    isPlain: true,
                    onPressed: () {},
                  ),
                  EButton(
                    text: 'Info Button',
                    type: EButtonType.Info,
                    isPlain: true,
                    onPressed: () {},
                  ),
                  EButton(
                    text: 'Default Button',
                    type: EButtonType.Default,
                    isPlain: true,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('按钮类型 - Round'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EButton(
                    text: 'Primary Button',
                    type: EButtonType.Primary,
                    round: true,
                    onPressed: () {},
                  ),
                  EButton(
                    text: 'Success Button',
                    type: EButtonType.Success,
                    round: true,
                    onPressed: () {},
                  ),
                  EButton(
                    text: 'Warning Button',
                    type: EButtonType.Warning,
                    round: true,
                    onPressed: () {},
                  ),
                  EButton(
                    text: 'Danger Button',
                    type: EButtonType.Danger,
                    round: true,
                    onPressed: () {},
                  ),
                  EButton(
                    text: 'Info Button',
                    type: EButtonType.Info,
                    round: true,
                    onPressed: () {},
                  ),
                  EButton(
                    text: 'Default Button',
                    type: EButtonType.Default,
                    round: true,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('按钮类型 - Icon'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ),
              const SizedBox(height: 16),
              Text('自定义颜色'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EButton(
                    text: 'Primary Button',
                    type: EButtonType.Primary,
                    color: Colors.purple,
                    onPressed: () {},
                  ),
                  EButton(
                    text: 'Primary Button',
                    color: Colors.purple,
                    isPlain: true,
                    onPressed: () {},
                  ),
                  EButton(
                    text: 'Primary Button',
                    color: Colors.purple,
                    round: true,
                    onPressed: () {},
                  ),
                  EButton(
                    color: Colors.purple,
                    icon: Icons.add,
                    onPressed: () {},
                  ),
                ],
              ),
              // 自定义children
              const SizedBox(height: 16),
              Text('自定义children'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EButton(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(height: 8),
                          Text('Primary Button'),
                          Text('Primary Button'),
                        ],
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              // isloading
              const SizedBox(height: 16),
              Text('isloading'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EButton(
                    text: 'Primary Button',
                    type: EButtonType.Primary,
                    loading: true,
                  ),
                  EButton(
                    text: 'Primary Button',
                    type: EButtonType.Primary,
                    loading: true,
                    loadingIcon: Icons.add,
                  ),
                ],
              ),
              // Badge 测试
              const SizedBox(height: 16),
              Text('按钮徽章 Badge'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EButton(
                    text: '消息',
                    showBadge: true,
                    badge: EBadge(value: 12, type: 'primary'),
                    onPressed: () {},
                  ),
                  EButton(
                    text: '评论',
                    showBadge: true,
                    badge: EBadge(value: 200, max: 99, type: 'danger'),
                    onPressed: () {},
                  ),
                  EButton(
                    text: '小红点',
                    showBadge: true,
                    badge: EBadge(isDot: true, type: 'warning'),
                    onPressed: () {},
                  ),
                  EButton(
                    text: '自定义颜色',
                    showBadge: true,
                    badge: EBadge(value: '新', color: Colors.purple),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
