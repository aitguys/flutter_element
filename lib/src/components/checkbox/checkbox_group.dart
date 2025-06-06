import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';
import 'checkbox.dart';

class ECheckboxGroup extends StatefulWidget {
  final List<String> value;
  final ESizeItem size;
  final bool disabled;
  final int? min;
  final int? max;
  final Function(List<String>)? onChange;
  final List<Widget> children;
  const ECheckboxGroup({
    super.key,
    required this.value,
    this.size = ESizeItem.medium,
    this.disabled = false,
    this.min,
    this.max,
    this.onChange,
    this.children = const [],
  });

  @override
  State<ECheckboxGroup> createState() => _ECheckboxGroupState();
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
    if (widget.disabled) return;

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
          return ECheckbox(
            key: child.key,
            label: child.label,
            disabled: widget.disabled || child.disabled,
            border: child.border,
            size: widget.size,
            checked: _selectedValues.contains(child.label),
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
