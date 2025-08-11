import 'package:flutter/material.dart';

class EFormLabelPosition {
  static const left = 'left';
  static const top = 'top';
  static const right = 'right';
}

/// 公共的 EFormController 类，用于外部访问表单状态
class EFormController {
  final GlobalKey<_EFormState> _key;

  EFormController() : _key = GlobalKey<_EFormState>();

  GlobalKey<_EFormState> get key => _key;

  /// 校验表单
  bool valid() {
    final formState = _key.currentState;
    print('EFormController.valid() 被调用');
    print('formState: $formState');

    if (formState == null) {
      print('formState 为 null，返回 true');
      return true;
    }

    // 执行所有 EFormItem 的验证
    print('开始执行表单验证');
    final result = formState.valid();
    print('表单验证结果: $result');
    return result;
  }

  /// 重置表单
  void reset() {
    _key.currentState?.reset();
  }

  /// 清除验证错误
  void clearValidate() {
    _key.currentState?.clearValidate();
  }

  /// 重新计算标签宽度（用于调试和测试）
  void recalculateLabelWidth() {
    _key.currentState?._calculateAutoLabelWidth();
  }

  /// 获取当前计算的标签宽度（用于调试和测试）
  double? getCurrentLabelWidth() {
    return _key.currentState?._autoLabelWidth;
  }

  /// 测试单个字段的验证（用于调试和测试）
  bool testSingleValidation() {
    final testItem = _key.currentState?._itemStates.first;
    if (testItem != null) {
      return testItem.valid();
    }
    return false;
  }
}

class _EFormInherited extends InheritedWidget {
  final String labelPosition;
  final dynamic labelWidth; // double 或 'auto'
  final double? autoLabelWidth;

  const _EFormInherited({
    required Widget child,
    required this.labelPosition,
    required this.labelWidth,
    required this.autoLabelWidth,
  }) : super(child: child);

  static _EFormInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_EFormInherited>();
  }

  @override
  bool updateShouldNotify(_EFormInherited oldWidget) {
    return labelPosition != oldWidget.labelPosition ||
        labelWidth != oldWidget.labelWidth ||
        autoLabelWidth != oldWidget.autoLabelWidth;
  }
}

class EForm extends StatefulWidget {
  final List<Widget> children;
  final String labelPosition;
  final dynamic labelWidth; // double 或 'auto'

  /// 新增：表单controller
  final EFormController controller;

  const EForm({
    super.key,
    required this.children,
    this.labelPosition = EFormLabelPosition.left,
    this.labelWidth = 'auto',
    required this.controller,
  });

  @override
  State<EForm> createState() => _EFormState();

  /// 静态方法，便于外部通过controller调用
  // static bool valid(EFormController controller) {
  //   return controller.valid();
  // }
}

class _EFormState extends State<EForm> {
  double? _autoLabelWidth;

  /// 新增：保存所有EFormItem的State
  final List<_EFormItemState> _itemStates = [];

  /// 注册item
  void registerItem(_EFormItemState state) {
    if (!_itemStates.contains(state)) {
      _itemStates.add(state);
    }
  }

  /// 注销item
  void unregisterItem(_EFormItemState state) {
    _itemStates.remove(state);
  }

  /// 校验所有item
  bool valid() {
    bool allValid = true;

    print('开始验证表单，共有 ${_itemStates.length} 个字段');

    // 执行所有 EFormItem 的验证
    for (final item in _itemStates) {
      print('验证字段: ${item.widget.label}');
      if (!item.valid()) {
        allValid = false;
        print('字段 ${item.widget.label} 验证失败');
      } else {
        print('字段 ${item.widget.label} 验证通过');
      }
    }

    // 触发刷新以显示验证结果
    setState(() {});

    print('表单验证完成，结果: ${allValid ? '通过' : '失败'}');
    return allValid;
  }

  /// 重置表单
  void reset() {
    // 重置所有 EFormItem 的状态
    for (final item in _itemStates) {
      item.reset();
    }

    // 触发刷新
    setState(() {});
  }

  /// 清除验证错误
  void clearValidate() {
    // 清除所有 EFormItem 的验证错误
    for (final item in _itemStates) {
      item.clearValidate();
    }

    // 触发刷新
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // 将 controller 的 key 设置到当前状态
    // 注意：这里不能直接设置 currentState，需要通过其他方式
    if (widget.labelWidth == 'auto') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _calculateAutoLabelWidth();
      });
    }
  }

  @override
  void didUpdateWidget(covariant EForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.labelWidth == 'auto') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _calculateAutoLabelWidth();
      });
    }
  }

  void _calculateAutoLabelWidth() {
    // 遍历所有EFormItem，测量label宽度，取最大值
    double maxWidth = 0;

    for (final item in _itemStates) {
      if (item.mounted) {
        // 使用 TextPainter 直接测量标签宽度
        double fontSize = item.widget.fontSize;
        // 判断是否为中文，如果是则字体大小乘2
        if (RegExp(r'[\u4e00-\u9fa5]').hasMatch(item.widget.label)) {
          fontSize = fontSize * 2;
        }
        final textPainter = TextPainter(
          text: TextSpan(
            text: item.widget.label,
            style: TextStyle(fontSize: fontSize),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        double labelWidth = textPainter.width;

        // 如果是必填字段，添加星号宽度
        if (item.widget.isRequired) {
          final starPainter = TextPainter(
            text: TextSpan(
              text: '*',
              style:
                  TextStyle(color: Colors.red, fontSize: item.widget.fontSize),
            ),
            textDirection: TextDirection.ltr,
          );
          starPainter.layout();
          labelWidth += starPainter.width; // 4px 间距
        }

        // 添加足够的 padding 确保长标签有足够空间，防止挤压
        // labelWidth += 48; // 增加 padding 到 48px，确保长标签有足够空间

        if (labelWidth > maxWidth) {
          maxWidth = labelWidth;
        }
      }
    }

    if (_autoLabelWidth != maxWidth && maxWidth > 0) {
      setState(() {
        _autoLabelWidth = maxWidth;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _EFormInherited(
      labelPosition: widget.labelPosition,
      labelWidth: widget.labelWidth,
      autoLabelWidth: _autoLabelWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.children,
      ),
    );
  }
}

typedef EFormItemValidator = String? Function();

class EFormItem extends StatefulWidget {
  final String label;
  final Widget child;
  final double fontSize;
  final String? labelPosition;
  final bool isRequired;
  final dynamic labelWidth; // double 或 'auto'
  final EFormItemValidator? validator;

  const EFormItem({
    super.key,
    required this.label,
    required this.child,
    this.fontSize = 14,
    this.labelPosition,
    this.isRequired = false,
    this.labelWidth,
    this.validator,
  });

  @override
  State<EFormItem> createState() => _EFormItemState();
}

class _EFormItemState extends State<EFormItem> {
  String? _errorText;
  _EFormState? _formState; // 保存对表单状态的引用

  @override
  void initState() {
    super.initState();
    // 注册到form
    _formState = context.findAncestorStateOfType<_EFormState>();
    _formState?.registerItem(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 在 didChangeDependencies 中获取表单状态，这样更安全
    if (_formState == null) {
      _formState = context.findAncestorStateOfType<_EFormState>();
      _formState?.registerItem(this);
    }
  }

  @override
  void dispose() {
    // 注销时使用保存的引用，避免查找祖先
    _formState?.unregisterItem(this);
    super.dispose();
  }

  String _getEffectiveLabelPosition(BuildContext context) {
    final inherited = _EFormInherited.of(context);
    return widget.labelPosition ??
        (inherited?.labelPosition ?? EFormLabelPosition.left);
  }

  dynamic _getEffectiveLabelWidth(BuildContext context) {
    final inherited = _EFormInherited.of(context);
    return widget.labelWidth ?? inherited?.labelWidth ?? 'auto';
  }

  double? _getAutoLabelWidth(BuildContext context) {
    final inherited = _EFormInherited.of(context);
    return inherited?.autoLabelWidth;
  }

  /// 校验本item
  bool valid() {
    String? error;

    print(
        '验证字段: ${widget.label}, isRequired: ${widget.isRequired}, hasValidator: ${widget.validator != null}');

    // 优先执行自定义验证器
    if (widget.validator != null) {
      error = widget.validator!();
      print('自定义验证器结果: $error');
    }
    // 如果没有自定义验证器但有必填要求，执行默认必填验证
    else if (widget.isRequired) {
      error = _validateRequired();
      print('必填验证结果: $error');
    }

    // 更新错误状态
    setState(() {
      _errorText = error;
    });

    print('最终验证结果: ${error == null ? '通过' : '失败: $error'}');
    return error == null;
  }

  /// 验证必填字段
  String? _validateRequired() {
    // 尝试从子组件获取值
    String? value = _extractValueFromChild();

    if (value == null || value.trim().isEmpty) {
      return '该字段不能为空';
    }

    return null;
  }

  /// 尝试从子组件提取值
  String? _extractValueFromChild() {
    // 这里可以扩展更多的逻辑来从不同类型的输入组件获取值
    // 目前返回 null，让用户通过自定义验证器来处理
    return null;
  }

  /// 重置本item
  void reset() {
    setState(() {
      _errorText = null;
    });
  }

  /// 清除本item的验证错误
  void clearValidate() {
    setState(() {
      _errorText = null;
    });
  }

  /// 测量当前标签的实际宽度
  double _measureActualLabelWidth({required double fontSize}) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.label,
        style: TextStyle(fontSize: fontSize),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    double labelWidth = textPainter.width + 10;

    // 如果是必填字段，添加星号宽度
    if (widget.isRequired) {
      final starPainter = TextPainter(
        text: TextSpan(
          text: '*',
          style: TextStyle(color: Colors.red, fontSize: fontSize),
        ),
        textDirection: TextDirection.ltr,
      );
      starPainter.layout();
      labelWidth += starPainter.width + 4; // 4px 间距
    }

    return labelWidth;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveLabelPosition = _getEffectiveLabelPosition(context);
    final effectiveLabelWidth = _getEffectiveLabelWidth(context);
    final autoLabelWidth = _getAutoLabelWidth(context);

    Widget mainContent;
    if (effectiveLabelPosition == EFormLabelPosition.left ||
        effectiveLabelPosition == EFormLabelPosition.right) {
      // 横向布局，label始终在输入框左侧，left/right 只影响label的对齐方式
      Widget labelWidget = _EFormItemLabelMeasure(
        label: widget.label,
        fontSize: widget.fontSize,
        isRequired: widget.isRequired,
        labelPosition: effectiveLabelPosition,
      );

      double? width;
      if (effectiveLabelWidth == 'auto') {
        width = autoLabelWidth;
      } else if (effectiveLabelWidth is double) {
        width = effectiveLabelWidth;
      }

      Widget labelBox;
      if (width != null) {
        // 对于长标签，允许自然扩展；对于短标签，使用固定宽度保持对齐
        final actualLabelWidth =
            _measureActualLabelWidth(fontSize: widget.fontSize);
        final shouldUseFixedWidth = actualLabelWidth <= width;

        if (shouldUseFixedWidth) {
          // 短标签：使用固定宽度保持对齐
          labelBox = Container(
            constraints: BoxConstraints(
              minWidth: width + 16,
              maxWidth: width + 16,
            ),
            child: Align(
              alignment: effectiveLabelPosition == EFormLabelPosition.right
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: labelWidget,
            ),
          );
        } else {
          // 长标签：允许自然扩展，但设置最小宽度
          labelBox = Container(
            constraints: BoxConstraints(
              minWidth: width + 16, // 最小宽度确保基本对齐
              // 不设置 maxWidth，允许长标签自然扩展
            ),
            child: Align(
              alignment: effectiveLabelPosition == EFormLabelPosition.right
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: labelWidget,
            ),
          );
        }
      } else {
        // 如果没有计算出的宽度，使用默认布局
        labelBox = labelWidget;
      }

      // 错误提示
      Widget? errorWidget;
      if (_errorText != null && _errorText!.isNotEmpty) {
        errorWidget = Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 4.0),
          child: Text(
            _errorText!,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        );
      }

      // label始终在左，输入框始终在右
      List<Widget> rowChildren = [
        labelBox,
        const SizedBox(width: 8),
        // 使用 Expanded 确保输入框占用剩余空间，防止标签挤压
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // 关键：使用最小尺寸
            children: [
              widget.child,
              if (errorWidget != null) errorWidget,
            ],
          ),
        ),
      ];

      mainContent = Row(
        crossAxisAlignment: CrossAxisAlignment.start, // 改为顶部对齐，防止长标签被截断
        children: rowChildren,
      );
    } else {
      // top，纵向布局
      // 错误提示
      Widget? errorWidget;
      if (_errorText != null && _errorText!.isNotEmpty) {
        errorWidget = Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 4.0),
          child: Text(
            _errorText!,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        );
      }

      mainContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // 关键：使用最小尺寸
        children: [
          Row(
            children: [
              Text(widget.label, style: TextStyle(fontSize: widget.fontSize)),
              // 占位：无论isRequired是否为true都要有一个占位
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: widget.isRequired
                    ? const Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(
                        width: 8, // 与星号宽度大致一致
                      ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          widget.child,
          if (errorWidget != null) errorWidget,
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: IntrinsicHeight(
        // 使用 IntrinsicHeight 确保高度一致
        child: mainContent,
      ),
    );
  }
}

/// 用于测量label宽度的组件
class _EFormItemLabelMeasure extends StatelessWidget {
  final String label;
  final double fontSize;
  final bool isRequired;
  final String? labelPosition;

  const _EFormItemLabelMeasure({
    required this.label,
    required this.fontSize,
    required this.isRequired,
    this.labelPosition,
  });

  @override
  Widget build(BuildContext context) {
    // 判断labelPosition
    final inherited = _EFormInherited.of(context);
    final effectiveLabelPosition =
        labelPosition ?? (inherited?.labelPosition ?? EFormLabelPosition.left);

    if (effectiveLabelPosition == EFormLabelPosition.right) {
      // 星号在最左侧
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: isRequired
                ? const Text(
                    '*',
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox(
                    width: 10, // 与星号宽度大致一致
                  ),
          ),
          Text(label, style: TextStyle(fontSize: fontSize)),
        ],
      );
    } else {
      // 星号在label右侧
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(fontSize: fontSize)),
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: isRequired
                ? const Text(
                    '*',
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox(
                    width: 10, // 与星号宽度大致一致
                  ),
          ),
        ],
      );
    }
  }
}
