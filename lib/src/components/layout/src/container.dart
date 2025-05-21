import 'package:flutter/material.dart';

/// LayoutContainer 容器组件
///
/// 用于布局的容器组件，支持水平和垂直两种布局方式
class LayoutContainer extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 布局方向，true 为水平，false 为垂直
  final bool? direction;

  /// 布局方向字符串，'horizontal' 或 'vertical'
  final String? directionStr;

  /// 容器高度
  final double? height;

  /// 容器宽度
  final double? width;

  /// 背景颜色
  final Color? backgroundColor;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  const LayoutContainer({
    Key? key,
    required this.child,
    this.direction,
    this.directionStr,
    this.height,
    this.width,
    this.backgroundColor,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isHorizontal = direction ?? (directionStr == 'horizontal');

    Widget container = Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      padding: padding,
      margin: margin,
      child: child,
    );

    return isHorizontal
        ? Row(
            children: [Expanded(child: container)],
          )
        : Column(
            children: [Expanded(child: container)],
          );
  }
}
