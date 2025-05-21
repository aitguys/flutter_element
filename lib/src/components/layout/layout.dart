import 'package:flutter/material.dart';
import 'src/container.dart';
import 'src/header.dart';
import 'src/aside.dart';
import 'src/main.dart';
import 'src/footer.dart';
import 'src/row.dart';
import 'src/col.dart';

/// FlutterElement Layout 组件
///
/// 用于快速构建页面布局的组件
class FlutterElementLayout {
  /// Container 容器组件
  static LayoutContainer container({
    Key? key,
    required Widget child,
    bool? direction,
    String? directionStr,
    double? height,
    double? width,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    return LayoutContainer(
      key: key,
      child: child,
      direction: direction,
      directionStr: directionStr,
      height: height,
      width: width,
      backgroundColor: backgroundColor,
      padding: padding,
      margin: margin,
    );
  }

  /// Header 头部组件
  static Header header({
    Key? key,
    required Widget child,
    double? height,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
  }) {
    return Header(
      key: key,
      child: child,
      height: height,
      backgroundColor: backgroundColor,
      padding: padding,
    );
  }

  /// Aside 侧边栏组件
  static Aside aside({
    Key? key,
    required Widget child,
    double? width,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
  }) {
    return Aside(
      key: key,
      child: child,
      width: width,
      backgroundColor: backgroundColor,
      padding: padding,
    );
  }

  /// Main 主要内容区组件
  static Main main({
    Key? key,
    required Widget child,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
  }) {
    return Main(
      key: key,
      child: child,
      backgroundColor: backgroundColor,
      padding: padding,
    );
  }

  /// Footer 底部组件
  static Footer footer({
    Key? key,
    required Widget child,
    double? height,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
  }) {
    return Footer(
      key: key,
      child: child,
      height: height,
      backgroundColor: backgroundColor,
      padding: padding,
    );
  }

  /// Row 行组件
  static LayoutRow row({
    Key? key,
    required List<Widget> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    EdgeInsetsGeometry? padding,
    double? gutter,
  }) {
    return LayoutRow(
      key: key,
      children: children,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      padding: padding,
      gutter: gutter,
    );
  }

  /// Col 列组件
  static Col col({
    Key? key,
    required Widget child,
    int? span,
    int? offset,
    int? push,
    int? pull,
    EdgeInsetsGeometry? padding,
  }) {
    return Col(
      key: key,
      child: child,
      span: span,
      offset: offset,
      push: push,
      pull: pull,
      padding: padding,
    );
  }
}
