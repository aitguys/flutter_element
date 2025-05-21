import 'package:flutter/material.dart';

/// Footer 底部组件
///
/// 用于页面底部的布局组件
class Footer extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 底部高度
  final double? height;

  /// 背景颜色
  final Color? backgroundColor;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  const Footer({
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
