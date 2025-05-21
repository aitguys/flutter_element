import 'package:flutter/material.dart';

/// LayoutRow 行组件
///
/// 用于水平布局的组件
class LayoutRow extends StatelessWidget {
  /// 子组件列表
  final List<Widget> children;

  /// 主轴对齐方式
  final MainAxisAlignment? mainAxisAlignment;

  /// 交叉轴对齐方式
  final CrossAxisAlignment? crossAxisAlignment;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 列间距
  final double? gutter;

  const LayoutRow({
    Key? key,
    required this.children,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.padding,
    this.gutter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> spacedChildren = [];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1 && gutter != null) {
        spacedChildren.add(SizedBox(width: gutter));
      }
    }

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: spacedChildren,
      ),
    );
  }
}
