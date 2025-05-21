import 'package:flutter/material.dart';

/// Header 头部组件
///
/// 用于页面顶部的布局组件
class Header extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 头部高度
  final double? height;

  /// 背景颜色
  final Color? backgroundColor;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  const Header({
    Key? key,
    required this.child,
    this.height,
    this.backgroundColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60.0,
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      padding: padding,
      child: child,
    );
  }
}
