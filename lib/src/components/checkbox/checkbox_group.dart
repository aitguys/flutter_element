import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';
import 'checkbox.dart';

class ECheckboxGroup extends StatefulWidget {
  final List<String> value;
  final ESizeItem size;
  final bool disabled;
  final bool readOnly;
  final int? min;
  final int? max;
  final Function(List<String>)? onChange;
  final List<Widget> children;
  const ECheckboxGroup({
    super.key,
    required this.value,
    this.size = ESizeItem.medium,
    this.disabled = false,
    this.readOnly = false,
    this.min,
    this.max,
    this.onChange,
    this.children = const [],
  });

  @override
  State<ECheckboxGroup> createState() => _ECheckboxGroupState();

  ECheckboxGroup copyWith({
    Key? key,
    List<String>? value,
    ESizeItem? size,
    bool? disabled,
    bool? readOnly,
    int? min,
    int? max,
    Function(List<String>)? onChange,
    List<Widget>? children,
  }) {
    return ECheckboxGroup(
      key: key ?? this.key,
      value: value ?? this.value,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      readOnly: readOnly ?? this.readOnly,
      min: min ?? this.min,
      max: max ?? this.max,
      onChange: onChange ?? this.onChange,
      children: children ?? this.children,
    );
  }
}

class _ECheckboxGroupState extends State<ECheckboxGroup> {
  late List<String> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues = List.from(widget.value);
  }

  @override
  void didUpdateWidget(ECheckboxGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _selectedValues = List.from(widget.value);
    }
  }

  void _handleChange(String value, bool checked) {
    if (widget.disabled || widget.readOnly) return;

    final newValues = List<String>.from(_selectedValues);
    if (checked) {
      if (widget.max != null && newValues.length >= widget.max!) {
        return;
      }
      if (!newValues.contains(value)) {
        newValues.add(value);
      }
    } else {
      if (widget.min != null && newValues.length <= widget.min!) {
        return;
      }
      newValues.remove(value);
    }

    setState(() {
      _selectedValues = newValues;
    });

    if (widget.onChange != null) {
      widget.onChange!(_selectedValues);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: widget.children.map((child) {
        if (child is ECheckbox) {
          // 优先使用 ECheckboxGroup 的 size，这样可以统一设置所有 checkbox 的大小
          // 如果子组件的 size 与 group 的 size 不同，则使用子组件的 size（允许子组件覆盖）
          final effectiveSize = child.size != widget.size ? child.size : widget.size;
          return ECheckbox(
            key: child.key,
            label: child.label,
            disabled: widget.disabled || child.disabled,
            readOnly: widget.readOnly || child.readOnly,
            border: child.border,
            size: effectiveSize,
            checked: _selectedValues.contains(child.label),
            fontColorType: child.fontColorType,
            fontCustomColor: child.fontCustomColor,
            iconColorType: child.iconColorType,
            iconCustomColor: child.iconCustomColor,
            customFontSize: child.customFontSize,
            customIconSize: child.customIconSize,
            labelWrap: child.labelWrap,
            onChange: (checked) {
              if (child.label != null) {
                _handleChange(child.label.toString(), checked);
              }
            },
          );
        }
        return child;
      }).toList(),
    );
  }
}
