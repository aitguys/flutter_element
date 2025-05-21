import 'package:flutter/material.dart';

/// Aside 侧边栏组件
///
/// 用于页面侧边的布局组件
class Aside extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 侧边栏宽度
  final double? width;

  /// 背景颜色
  final Color? backgroundColor;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  const Aside({
    Key? key,
    required this.child,
    this.width,
    this.backgroundColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 200.0,
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      padding: padding,
      child: child,
    );
  }
}
