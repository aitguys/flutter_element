import 'package:flutter/material.dart';

/// Col 列组件
///
/// 用于栅格布局的列组件
class Col extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 栅格占据的列数
  final int? span;

  /// 栅格左侧的间隔格数
  final int? offset;

  /// 栅格向右移动格数
  final int? push;

  /// 栅格向左移动格数
  final int? pull;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  const Col({
    Key? key,
    required this.child,
    this.span,
    this.offset,
    this.push,
    this.pull,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 计算宽度比例
    double flex = span != null ? span!.toDouble() : 1.0;

    // 计算偏移量
    double offsetWidth = offset != null ? offset!.toDouble() : 0.0;
    double pushWidth = push != null ? push!.toDouble() : 0.0;
    double pullWidth = pull != null ? pull!.toDouble() : 0.0;

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double totalWidth = constraints.maxWidth;
          double colWidth = (totalWidth / 24) * flex;
          double marginLeft =
              (totalWidth / 24) * (offsetWidth + pushWidth - pullWidth);

          return Container(
            width: colWidth,
            margin: EdgeInsets.only(left: marginLeft),
            child: child,
          );
        },
      ),
    );
  }
}
