import 'package:flutter/material.dart';
import '../input/input.dart';
import '../select/select.dart';
import '../input_number/input_number.dart';
import '../input_tag/input_tag.dart';
import '../radio/radio.dart';

class EFormLabelPosition {
  static const left = 'left';
  static const top = 'top';
  static const right = 'right';
}

/// 公共的 EFormController 类，用于外部访问表单状态
class EFormController {
  final GlobalKey<_EFormState> _key;

  EFormController() : _key = GlobalKey<_EFormState>();
  // ignore: library_private_types_in_public_api
  GlobalKey<_EFormState> get key => _key;

  /// 校验表单
  bool valid() {
    final formState = _key.currentState;
    if (formState == null) return true;
    return formState.valid();
  }

  /// 清除验证错误
  void clearValidate() {
    _key.currentState?.clearValidate();
  }
}

class _EFormInherited extends InheritedWidget {
  final String labelPosition;
  final dynamic labelWidth; // double 或 'auto'
  final double? autoLabelWidth;
  final TextStyle formItemTextStyle;

  const _EFormInherited({
    required super.child,
    required this.labelPosition,
    required this.labelWidth,
    required this.autoLabelWidth,
    required this.formItemTextStyle,
  });

  static _EFormInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_EFormInherited>();
  }

  @override
  bool updateShouldNotify(_EFormInherited oldWidget) {
    return labelPosition != oldWidget.labelPosition ||
        labelWidth != oldWidget.labelWidth ||
        autoLabelWidth != oldWidget.autoLabelWidth ||
        formItemTextStyle != oldWidget.formItemTextStyle;
  }
}

class EForm extends StatefulWidget {
  final List<Widget> children;
  final String labelPosition;
  final dynamic labelWidth; // double 或 'auto'
  final EFormController controller;
  final TextStyle formItemTextStyle;

  const EForm({
    super.key,
    required this.children,
    this.labelPosition = EFormLabelPosition.left,
    this.labelWidth = 'auto',
    required this.controller,
    this.formItemTextStyle = const TextStyle(fontSize: 14),
  });

  @override
  State<EForm> createState() => _EFormState();
}

class _EFormState extends State<EForm> {
  double? _autoLabelWidth;
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
    for (final item in _itemStates) {
      if (!item.valid()) {
        allValid = false;
      }
    }
    setState(() {});
    return allValid;
  }

  /// 重置表单
  void reset() {
    for (final item in _itemStates) {
      item.reset();
    }
    setState(() {});
  }

  /// 清除验证错误
  void clearValidate() {
    for (final item in _itemStates) {
      item.clearValidate();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
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
    double maxWidth = 0;

    for (final item in _itemStates) {
      if (item.mounted) {
        double fontSize = item.widget.textStyle?.fontSize ??
            widget.formItemTextStyle.fontSize ??
            14;
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

        if (item.widget.isRequired) {
          final starPainter = TextPainter(
            text: TextSpan(
              text: '*',
              style: TextStyle(color: Colors.red, fontSize: fontSize),
            ),
            textDirection: TextDirection.ltr,
          );
          starPainter.layout();
          labelWidth += starPainter.width;
        }

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
      formItemTextStyle: widget.formItemTextStyle,
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
  final TextStyle? textStyle; // 改为可空，如果没有提供则从 EForm 继承
  final String? labelPosition;
  final bool isRequired;
  final dynamic labelWidth; // double 或 'auto'
  final EFormItemValidator? validator;

  const EFormItem({
    super.key,
    required this.label,
    required this.child,
    this.textStyle, // 移除默认值
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
  _EFormState? _formState;

  @override
  void initState() {
    super.initState();
    _formState = context.findAncestorStateOfType<_EFormState>();
    _formState?.registerItem(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formState == null) {
      _formState = context.findAncestorStateOfType<_EFormState>();
      _formState?.registerItem(this);
    }
  }

  @override
  void dispose() {
    _formState?.unregisterItem(this);
    super.dispose();
  }

  /// 获取有效的字体大小，优先使用自身的，否则从 EForm 继承
  TextStyle _getEffectiveTextStyle(BuildContext context) {
    if (widget.textStyle != null) {
      return widget.textStyle!;
    }
    final inherited = _EFormInherited.of(context);
    return inherited?.formItemTextStyle ?? const TextStyle(fontSize: 14);
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
    if (widget.validator != null) {
      error = widget.validator!();
    } else if (widget.isRequired) {
      error = _validateRequired();
    }
    setState(() {
      _errorText = error;
    });
    return error == null;
  }

  /// 验证必填字段
  String? _validateRequired() {
    String? value = _extractValueFromChild();
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  /// 尝试从子组件提取值
  String? _extractValueFromChild() {
    // 尝试从不同类型的子组件中提取值
    if (widget.child is EInput) {
      final input = widget.child as EInput;
      return input.textController?.text;
    } else if (widget.child is ESelect) {
      final select = widget.child as ESelect;
      return select.value?.toString();
    } else if (widget.child is EInputNumber) {
      final inputNumber = widget.child as EInputNumber;
      return inputNumber.value?.toString();
    } else if (widget.child is EInputTag) {
      final inputTag = widget.child as EInputTag;
      return inputTag.value?.join(', ');
    } else if (widget.child is ERadioGroup) {
      final radioGroup = widget.child as ERadioGroup;
      return radioGroup.textController?.text;
    }
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
  double _measureActualLabelWidth({required TextStyle textStyle}) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.label,
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    double labelWidth = textPainter.width + 10;

    if (widget.isRequired) {
      final starPainter = TextPainter(
        text: TextSpan(
          text: '*',
          style: textStyle,
        ),
        textDirection: TextDirection.ltr,
      );
      starPainter.layout();
      labelWidth += starPainter.width + 4;
    }

    return labelWidth;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveLabelPosition = _getEffectiveLabelPosition(context);
    final effectiveLabelWidth = _getEffectiveLabelWidth(context);
    final autoLabelWidth = _getAutoLabelWidth(context);
    final effectiveTextStyle = _getEffectiveTextStyle(context);

    Widget mainContent;
    if (effectiveLabelPosition == EFormLabelPosition.left ||
        effectiveLabelPosition == EFormLabelPosition.right) {
      // 横向布局
      Widget labelWidget = _EFormItemLabelMeasure(
        label: widget.label,
        textStyle: effectiveTextStyle,
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
        final actualLabelWidth =
            _measureActualLabelWidth(textStyle: effectiveTextStyle);
        final shouldUseFixedWidth = actualLabelWidth <= width;

        if (shouldUseFixedWidth) {
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
          labelBox = Container(
            constraints: BoxConstraints(
              minWidth: width + 16,
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
        labelBox = labelWidget;
      }

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

      List<Widget> rowChildren = [
        labelBox,
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.child,
              if (errorWidget != null) errorWidget,
            ],
          ),
        ),
      ];

      mainContent = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rowChildren,
      );
    } else {
      // 纵向布局
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(widget.label, style: effectiveTextStyle),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: widget.isRequired
                    ? const Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(width: 8),
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
        child: mainContent,
      ),
    );
  }
}

/// 用于测量label宽度的组件
class _EFormItemLabelMeasure extends StatelessWidget {
  final String label;
  final TextStyle textStyle;
  final bool isRequired;
  final String? labelPosition;

  const _EFormItemLabelMeasure({
    required this.label,
    required this.textStyle,
    required this.isRequired,
    this.labelPosition,
  });

  @override
  Widget build(BuildContext context) {
    final inherited = _EFormInherited.of(context);
    final effectiveLabelPosition =
        labelPosition ?? (inherited?.labelPosition ?? EFormLabelPosition.left);

    if (effectiveLabelPosition == EFormLabelPosition.right) {
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
                : const SizedBox(width: 10),
          ),
          Text(label, style: textStyle),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: textStyle),
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: isRequired
                ? const Text(
                    '*',
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox(width: 10),
          ),
        ],
      );
    }
  }
}
