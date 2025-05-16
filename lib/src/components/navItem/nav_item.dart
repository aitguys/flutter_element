import 'package:flutter/material.dart';

class FlNavItem extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final Widget? child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double height;
  final EdgeInsetsGeometry margin;

  const FlNavItem({
    Key? key,
    this.prefix,
    this.suffix,
    this.child,
    this.padding = EdgeInsets.zero,
    this.onTap,
    this.backgroundColor,
    this.height = 48.0,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      child: Material(
        color: backgroundColor ?? Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                if (prefix != null) ...[
                  prefix!,
                  const SizedBox(width: 8),
                ],
                Expanded(child: child ?? const SizedBox()),
                if (suffix != null) ...[
                  const SizedBox(width: 8),
                  suffix!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
