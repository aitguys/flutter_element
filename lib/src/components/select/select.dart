import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';
import '../input/input.dart';

/// Select 组件的选项
class SelectOption {
  final String value;
  final String label;
  final bool disabled;
  final dynamic extra;

  const SelectOption({
    required this.value,
    required this.label,
    this.disabled = false,
    this.extra,
  });
}

class ESelect extends StatefulWidget {
  final dynamic value;
  final List<SelectOption> options;
  final bool disabled;
  final bool readOnly;
  final bool clearable;
  final bool multiple;
  final ESizeItem size;
  final String? placeholder;
  final Widget? header;
  final EColorType colorType;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? prepend;
  final Widget? append;
  final Color? customColor;
  final Color defaultColor;
  final double? customHeight;
  final double? customFontSize;
  final double? customBorderRadius;
  final bool showPlaceholderOnTop;
  final ValueChanged<dynamic>? onChanged;
  final VoidCallback? onClear;

  const ESelect({
    super.key,
    this.value,
    required this.options,
    this.disabled = false,
    this.readOnly = false,
    this.clearable = false,
    this.multiple = false,
    this.size = ESizeItem.medium,
    this.placeholder,
    this.header,
    this.colorType = EColorType.primary,
    this.customColor,
    this.defaultColor = EBasicColors.borderGray,
    this.customHeight,
    this.customFontSize,
    this.customBorderRadius,
    this.showPlaceholderOnTop = false,
    this.onChanged,
    this.onClear,
    this.suffix,
    this.prefix,
    this.prepend,
    this.append,
  });

  @override
  State<ESelect> createState() => _ESelectState();

  ESelect copyWith({
    dynamic value,
    List<SelectOption>? options,
    bool? disabled,
    bool? readOnly,
    bool? clearable,
    bool? multiple,
    ESizeItem? size,
    String? placeholder,
    Widget? header,
    EColorType? colorType,
    Widget? suffix,
    Widget? prefix,
    Widget? prepend,
    Widget? append,
    Color? customColor,
    Color? defaultColor,
    double? customHeight,
    double? customFontSize,
    double? customBorderRadius,
    bool? showPlaceholderOnTop,
    ValueChanged<dynamic>? onChanged,
    VoidCallback? onClear,
  }) {
    return ESelect(
      value: value ?? this.value,
      options: options ?? this.options,
      disabled: disabled ?? this.disabled,
      readOnly: readOnly ?? this.readOnly,
      clearable: clearable ?? this.clearable,
      multiple: multiple ?? this.multiple,
      size: size ?? this.size,
      placeholder: placeholder ?? this.placeholder,
      header: header ?? this.header,
      colorType: colorType ?? this.colorType,
      customColor: customColor ?? this.customColor,
      defaultColor: defaultColor ?? this.defaultColor,
      customHeight: customHeight ?? this.customHeight,
      customFontSize: customFontSize ?? this.customFontSize,
      customBorderRadius: customBorderRadius ?? this.customBorderRadius,
      showPlaceholderOnTop: showPlaceholderOnTop ?? this.showPlaceholderOnTop,
      onChanged: onChanged ?? this.onChanged,
      onClear: onClear ?? this.onClear,
      suffix: suffix ?? this.suffix,
      prefix: prefix ?? this.prefix,
      prepend: prepend ?? this.prepend,
      append: append ?? this.append,
    );
  }
}

class _ESelectState extends State<ESelect> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  late FocusNode _focusNode;
  late TextEditingController _controller;
  List<String> _selectedValues = [];
  bool _isDisposed = false;

  // 计算显示文本
  String get _displayText {
    if (widget.multiple) {
      if (_selectedValues.isEmpty) return '';
      return _selectedValues
          .map((value) => widget.options
              .firstWhere((option) => option.value == value,
                  orElse: () => SelectOption(label: value, value: value))
              .label)
          .join(', ');
    } else {
      // 优先使用 _selectedValues（内部状态），如果没有则使用 widget.value
      String? currentValue =
          _selectedValues.isNotEmpty ? _selectedValues.first : widget.value;
      if (currentValue == null || currentValue.isEmpty) return '';

      try {
        return widget.options
            .firstWhere((option) => option.value == currentValue,
                orElse: () =>
                    SelectOption(label: currentValue, value: currentValue))
            .label;
      } catch (e) {
        return currentValue.toString();
      }
    }
  }

  void _handleOptionSelected(SelectOption option) {
    print('option: $option');
    if (!_isDisposed) {
      if (widget.multiple) {
        setState(() {
          if (_selectedValues.contains(option.value)) {
            _selectedValues.remove(option.value);
          } else {
            _selectedValues.add(option.value);
          }
          _controller.text = _displayText;
          widget.onChanged?.call(_selectedValues);
          _updateOverlay();
        });
        // 更新输入框显示内容
      } else {
        setState(() {
          // 单选模式下，清空之前的选择，设置新的选择
          _selectedValues.clear();
          _selectedValues.add(option.value);
          _controller.text = _displayText;
          widget.onChanged?.call(option.value);
          _hideOverlay();
        });
        // 更新输入框显示内容
      }
    }
  }

  void _updateOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _hideOverlay();
              },
            ),
          ),
          Positioned(
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(
                  0,
                  ElememtSize(size: widget.size)
                      .getInputHeight(customHeight: widget.customHeight)),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(
                    ElememtSize(size: widget.size).getInputBorderRadius(
                        customBorderRadius: widget.customBorderRadius)),
                child: Container(
                  width: size.width,
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.header != null) widget.header!,
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.options.length,
                          itemBuilder: (context, index) {
                            final option = widget.options[index];
                            final isSelected = widget.multiple
                                ? _selectedValues.contains(option.value)
                                : option.value == widget.value;
                            final isDisabled = option.disabled ||
                                widget.disabled ||
                                widget.readOnly;

                            return InkWell(
                              onTap: isDisabled
                                  ? null
                                  : () => _handleOptionSelected(option),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                color: isSelected
                                    ? getColorByType(
                                            type: widget.colorType,
                                            customColor: widget.customColor)
                                        .withValues(alpha: 0.1)
                                    : null,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        option.label,
                                        style: TextStyle(
                                          fontSize:
                                              ElememtSize(size: widget.size)
                                                  .getInputFontSize(
                                                      customFontSize: widget
                                                          .customFontSize),
                                          color: isDisabled
                                              ? const Color.fromARGB(
                                                  255, 146, 148, 155)
                                              : isSelected
                                                  ? getColorByType(
                                                      type: widget.colorType,
                                                      customColor:
                                                          widget.customColor)
                                                  : EBasicColors.textGray,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check,
                                        size: ElememtSize(size: widget.size)
                                            .getInputFontSize(
                                                customFontSize:
                                                    widget.customFontSize),
                                        color: getColorByType(
                                            type: widget.colorType,
                                            customColor: widget.customColor),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController(text: _displayText);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && !widget.readOnly) {
        _showOverlay();
      }
    });

    // 初始化选中值
    if (widget.multiple && widget.value != null) {
      _selectedValues = List<String>.from(widget.value);
    } else if (!widget.multiple &&
        widget.value != null &&
        widget.value.toString().isNotEmpty) {
      _selectedValues = [widget.value.toString()];
    }

    // 设置初始显示文本
    _controller.text = _displayText;
  }

  @override
  void didUpdateWidget(ESelect oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 检查 value 是否发生变化
    if (widget.value != oldWidget.value) {
      if (widget.multiple && widget.value != null) {
        _selectedValues = List<String>.from(widget.value);
      } else if (!widget.multiple &&
          widget.value != null &&
          widget.value.toString().isNotEmpty) {
        _selectedValues = [widget.value.toString()];
      } else {
        // 如果 value 为空或 null，清空内部状态
        _selectedValues.clear();
      }

      // 更新输入框显示内容
      if (!_isDisposed) {
        _controller.text = _displayText;
      }
    }
  }

  void _handleClear() {
    if (!_isDisposed) {
      setState(() {
        _selectedValues = [];
        if (widget.multiple) {
          widget.onChanged?.call(_selectedValues);
        } else {
          widget.onChanged?.call(null);
        }
        _hideOverlay();
      });
      // 更新输入框显示内容
      _controller.text = _displayText;
      widget.onClear?.call();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _focusNode.dispose();
    _controller.dispose();
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: EInput(
        textController: _controller,
        focusNode: _focusNode,
        disabled: widget.disabled,
        readOnly: widget.readOnly,
        clearable: widget.clearable,
        placeholder: widget.placeholder,
        colorType: widget.colorType,
        customColor: widget.customColor,
        borderColor: widget.defaultColor,
        size: widget.size,
        customHeight: widget.customHeight,
        customFontSize: widget.customFontSize,
        customBorderRadius: widget.customBorderRadius,
        showPlaceholderOnTop: widget.showPlaceholderOnTop,
        onClear: _handleClear,
        suffix: widget.suffix ??
            Icon(
              Icons.arrow_drop_down,
              size: ElememtSize(size: widget.size)
                  .getInputFontSize(customFontSize: widget.customFontSize),
              color: EBasicColors.textGray,
            ),
        prefix: widget.prefix,
        prepend: widget.prepend,
        append: widget.append,
      ),
    );
  }
}
