import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

/// ERadio 组件，支持独立使用或与 ERadioGroup 组合使用，支持不同尺寸、状态和样式。
class ERadio extends StatefulWidget {
  final String? value;
  final String? label;
  final bool disabled;
  final bool border;
  final EColorType fontColorType;
  final Color? fontCustomColor;
  final EColorType iconColorType;
  final Color? iconCustomColor;
  final ESizeItem? size;
  final double? customFontSize;
  final String? name;

  /// 仅当作为 ERadioGroup 子项时由 ERadioGroup 注入
  final String? groupValue;
  final bool? groupDisabled;
  final ValueChanged<String>? groupOnChanged;
  final ESizeItem? groupSize;
  final double? groupCustomFontSize;
  final EColorType? groupFontColorType;
  final Color? groupFontCustomColor;
  final EColorType? groupIconColorType;
  final Color? groupIconCustomColor;

  const ERadio({
    super.key,
    this.value,
    this.label,
    this.disabled = false,
    this.border = false,
    this.fontColorType = EColorType.primary,
    this.fontCustomColor,
    this.iconColorType = EColorType.primary,
    this.iconCustomColor,
    this.size,
    this.customFontSize,
    this.name,
    // 以下参数仅 ERadioGroup 注入
    this.groupValue,
    this.groupDisabled,
    this.groupOnChanged,
    this.groupSize,
    this.groupCustomFontSize,
    this.groupFontColorType,
    this.groupFontCustomColor,
    this.groupIconColorType,
    this.groupIconCustomColor,
  });

  @override
  State<ERadio> createState() => _ERadioState();
}

class _ERadioState extends State<ERadio> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // 优先使用 group 传递的参数，否则用自身
    final isChecked = (widget.groupValue ?? widget.value) == widget.value;
    final isDisabled = widget.disabled || (widget.groupDisabled ?? false);
    final size = widget.size ?? widget.groupSize ?? ESizeItem.medium;
    final customFontSize = widget.customFontSize ?? widget.groupCustomFontSize;
    final fontColorType = widget.fontColorType;
    final fontCustomColor = widget.fontCustomColor;
    final iconColorType = widget.iconColorType;
    final iconCustomColor =
        widget.iconCustomColor ?? widget.groupIconCustomColor;

    Widget radio = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: isDisabled
            ? null
            : () {
                if (widget.groupOnChanged != null) {
                  widget.groupOnChanged!(widget.value ?? '');
                }
              },
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: widget.border
              ? BoxDecoration(
                  border: Border.all(
                    color: isDisabled
                        ? EBasicColors.borderGray
                        : isChecked
                            ? getColorByType(
                                type: iconColorType,
                                customColor: iconCustomColor)
                            : _isHovered
                                ? getColorByType(
                                        type: iconColorType,
                                        customColor: iconCustomColor)
                                    .withValues(alpha: 0.5)
                                : EBasicColors.borderGray,
                  ),
                  borderRadius: BorderRadius.circular(4),
                )
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: ElememtSize(size: size).getCheckboxSize() * 0.7 + 4,
                height: ElememtSize(size: size).getCheckboxSize() * 0.7 + 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDisabled
                        ? EBasicColors.borderGray
                        : isChecked
                            ? getColorByType(
                                type: iconColorType,
                                customColor: iconCustomColor)
                            : _isHovered
                                ? getColorByType(
                                        type: iconColorType,
                                        customColor: iconCustomColor)
                                    .withValues(alpha: 0.5)
                                : EBasicColors.borderGray,
                    width: 1,
                  ),
                ),
                child: isChecked
                    ? Center(
                        child: Container(
                          width:
                              ElememtSize(size: size).getCheckboxSize() * 0.7,
                          height:
                              ElememtSize(size: size).getCheckboxSize() * 0.7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDisabled
                                ? EBasicColors.borderGray
                                : getColorByType(
                                    type: iconColorType,
                                    customColor: iconCustomColor),
                          ),
                        ),
                      )
                    : null,
              ),
              if (widget.label != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    widget.label!,
                    style: TextStyle(
                      fontSize: ElememtSize(size: size)
                          .getInputFontSize(customFontSize: customFontSize),
                      color: isDisabled
                          ? Colors.black
                          : getColorByType(
                              type: fontColorType,
                              customColor: fontCustomColor),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    return radio;
  }
}

/// 一组单选框，管理选中状态
///
/// 用法：
///
/// ```dart
/// ERadioGroup(
///   value: '1',
///   onChanged: (value) => print('Selected: $value'),
///   children: [
///     ERadio(value: '1', label: '选项1'),
///     ERadio(value: '2', label: '选项2'),
///     ERadio(value: '3', label: '选项3'),
///   ],
/// )
/// ```
class ERadioGroup extends StatefulWidget {
  final TextEditingController? textController;
  final bool disabled;
  final ValueChanged<String>? onChanged;
  final ESizeItem size;
  final double? customFontSize;
  final EColorType fontColorType;
  final Color? fontCustomColor;
  final EColorType iconColorType;
  final Color? iconCustomColor;
  final List<Widget> children;

  const ERadioGroup({
    super.key,
    this.textController,
    this.disabled = false,
    this.onChanged,
    this.size = ESizeItem.medium,
    this.customFontSize,
    this.fontColorType = EColorType.primary,
    this.fontCustomColor,
    this.iconColorType = EColorType.primary,
    this.iconCustomColor,
    required this.children,
  });

  @override
  State<ERadioGroup> createState() => _ERadioGroupState();

  ERadioGroup copyWith({
    TextEditingController? textController,
    bool? disabled,
    ValueChanged<String>? onChanged,
    ESizeItem? size,
    double? customFontSize,
    EColorType? fontColorType,
    Color? fontCustomColor,
    EColorType? iconColorType,
    Color? iconCustomColor,
    List<Widget>? children,
  }) {
    return ERadioGroup(
      textController: textController ?? this.textController,
      disabled: disabled ?? this.disabled,
      onChanged: onChanged ?? this.onChanged,
      size: size ?? this.size,
      customFontSize: customFontSize ?? this.customFontSize,
      fontColorType: fontColorType ?? this.fontColorType,
      fontCustomColor: fontCustomColor ?? this.fontCustomColor,
      iconColorType: iconColorType ?? this.iconColorType,
      iconCustomColor: iconCustomColor ?? this.iconCustomColor,
      children: children ?? this.children,
    );
  }
}

class _ERadioGroupState extends State<ERadioGroup> {
  String? _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = widget.textController?.text;
  }

  @override
  void didUpdateWidget(covariant ERadioGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果外部 value 变化，内部也要同步
    if (widget.textController?.text != oldWidget.textController?.text) {
      setState(() {
        _groupValue = widget.textController?.text;
      });
    }
  }

  void _onChanged(String value) {
    if (_groupValue != value) {
      setState(() {
        _groupValue = value;
      });
      // 新增：同步更新 textController 的值
      if (widget.textController != null) {
        widget.textController!.text = value;
      }
      if (widget.onChanged != null) {
        widget.onChanged!(value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 遍历 children，注入 group 相关参数
    List<Widget> radios = widget.children.map((child) {
      if (child is ERadio) {
        return ERadio(
          value: child.value,
          label: child.label,
          disabled: child.disabled,
          border: child.border,
          fontColorType: child.fontColorType,
          fontCustomColor: child.fontCustomColor,
          iconColorType: child.iconColorType,
          iconCustomColor: child.iconCustomColor,
          size: child.size,
          customFontSize: child.customFontSize,
          name: child.name,
          groupValue: _groupValue,
          groupDisabled: widget.disabled,
          groupOnChanged: _onChanged,
          groupSize: widget.size,
          groupCustomFontSize: widget.customFontSize,
          groupFontColorType: widget.fontColorType,
          groupFontCustomColor: widget.fontCustomColor,
          groupIconColorType: widget.iconColorType,
          groupIconCustomColor: widget.iconCustomColor,
        );
      }
      return child;
    }).toList();

    return Wrap(
      spacing: 16,
      children: radios,
    );
  }
}
