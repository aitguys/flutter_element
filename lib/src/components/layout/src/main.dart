import 'package:flutter/material.dart';

/// Main 主要内容区组件
///
/// 用于页面主要内容的布局组件
class Main extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 背景颜色
  final Color? backgroundColor;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  const Main({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      padding: padding,
      child: child,
    );
  }
}
