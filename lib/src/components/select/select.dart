import 'package:flutter/material.dart';
import 'dart:async';
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

  /// Whether the select is filterable (allows input for searching).
  ///
  /// When false, the input field is non-editable and users can only select
  /// from the dropdown options. Defaults to false.
  final bool filterable;
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
  final double? maxHeight;
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
    this.filterable = false,
    this.size = ESizeItem.medium,
    this.placeholder,
    this.header,
    this.colorType = EColorType.primary,
    this.customColor,
    this.defaultColor = EBasicColors.borderGray,
    this.customHeight,
    this.customFontSize,
    this.customBorderRadius,
    this.maxHeight,
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
    bool? filterable,
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
    double? maxHeight,
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
      filterable: filterable ?? this.filterable,
      size: size ?? this.size,
      placeholder: placeholder ?? this.placeholder,
      header: header ?? this.header,
      colorType: colorType ?? this.colorType,
      customColor: customColor ?? this.customColor,
      defaultColor: defaultColor ?? this.defaultColor,
      customHeight: customHeight ?? this.customHeight,
      customFontSize: customFontSize ?? this.customFontSize,
      customBorderRadius: customBorderRadius ?? this.customBorderRadius,
      maxHeight: maxHeight ?? this.maxHeight,
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
  String _searchText = '';
  List<SelectOption> _filteredOptions = [];
  Timer? _autoSelectTimer;
  Timer? _filterDebounceTimer;
  bool _isAutoSelecting = false;
  bool _isUserTyping = false;
  bool _isOverlayVisible = false; // 跟踪 Overlay 显示状态

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

  // 过滤选项 - 添加防抖机制
  void _filterOptions(String searchText) {
    _searchText = searchText;

    // 取消之前的防抖定时器
    _filterDebounceTimer?.cancel();

    // 设置新的防抖定时器
    _filterDebounceTimer = Timer(const Duration(milliseconds: 150), () {
      if (_isDisposed) return;

      if (searchText.isEmpty) {
        _filteredOptions = widget.options;
      } else {
        _filteredOptions = widget.options
            .where((option) =>
                option.label.toLowerCase().contains(searchText.toLowerCase()) ||
                option.value
                    .toString()
                    .toLowerCase()
                    .contains(searchText.toLowerCase()))
            .toList();
      }

      _updateOverlay();
    });
  }

  // 自动选中匹配的选项
  void _autoSelectMatchedOption(String searchText) {
    if (searchText.isEmpty || _isAutoSelecting || !_isUserTyping) return;

    // 查找完全匹配的选项
    final exactMatch = _filteredOptions.firstWhere(
      (option) =>
          option.label.toLowerCase() == searchText.toLowerCase() ||
          option.value.toString().toLowerCase() == searchText.toLowerCase(),
      orElse: () => const SelectOption(value: '', label: ''),
    );

    if (exactMatch.value.isNotEmpty && !exactMatch.disabled) {
      // 检查是否与当前选中的值相同，如果相同则不自动选中
      if (_selectedValues.isNotEmpty &&
          _selectedValues.first == exactMatch.value) {
        return;
      }

      _isAutoSelecting = true;
      _handleOptionSelected(exactMatch, triggerOnChange: true);
      // 自动选中后去除焦点，避免重复触发
      _focusNode.unfocus();
      _hideOverlay(unfocus: true);
      // 重置标志位
      Future.delayed(const Duration(milliseconds: 100), () {
        _isAutoSelecting = false;
        _isUserTyping = false;
      });
    }
  }

  void _handleOptionSelected(SelectOption option,
      {bool triggerOnChange = true}) {
    if (!_isDisposed) {
      if (widget.multiple) {
        setState(() {
          if (_selectedValues.contains(option.value)) {
            _selectedValues.remove(option.value);
          } else {
            _selectedValues.add(option.value);
          }
          _controller.text = _displayText;
          if (triggerOnChange) {
            widget.onChanged?.call(_selectedValues);
          }
          _updateOverlay();
        });
      } else {
        setState(() {
          // 单选模式下，清空之前的选择，设置新的选择
          _selectedValues.clear();
          _selectedValues.add(option.value);
          _controller.text = option.label; // 显示选中选项的标签
          if (triggerOnChange) {
            widget.onChanged?.call(option.value);
          }
          // 隐藏 Overlay，但不立即收起键盘
          _hideOverlay(unfocus: false);
        });
      }
    }
  }

  void _handleTextChanged(String text) {
    if (!_isDisposed && !_isAutoSelecting) {
      // 多选时仅用最后一项作为筛选
      widget.multiple ? null : _filterOptions(text);
      _updateOverlay();

      // 取消之前的定时器
      _autoSelectTimer?.cancel();

      // 如果输入框为空，清空选择
      if (text.isEmpty) {
        setState(() {
          _selectedValues.clear();
          _controller.text = '';
          widget.onChanged?.call(widget.multiple ? [] : null);
        });
        return;
      }

      // 延迟自动选中，避免频繁触发
      _autoSelectTimer = Timer(const Duration(milliseconds: 100), () {
        if (!_isDisposed && _searchText == text && !_isAutoSelecting) {
          _autoSelectMatchedOption(text);
        }
      });
    }
  }

  void _updateOverlay() {
    if (_overlayEntry != null && _isOverlayVisible) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null || _isOverlayVisible) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;
    final viewInsets = MediaQuery.of(context).viewInsets;

    // Default dropdown max height
    final double dropdownMaxHeight = widget.maxHeight ?? 300.0;
    const double verticalMargin = 8.0;

    // Calculate space below and above
    final double spaceBelow =
        screenHeight - position.dy - size.height - viewInsets.bottom - 20;
    final double spaceAbove = position.dy - verticalMargin - 20;

    // Determine position
    final bool showAbove =
        spaceBelow < dropdownMaxHeight && spaceAbove > spaceBelow;

    // Constrain height if space is very limited
    final double actualMaxHeight = showAbove
        ? spaceAbove.clamp(100.0, dropdownMaxHeight)
        : spaceBelow.clamp(100.0, dropdownMaxHeight);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // 半透明背景层，点击外部可关闭 Overlay
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _hideOverlay(unfocus: true);
              },
            ),
          ),
          // 选项列表
          Positioned(
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              followerAnchor:
                  showAbove ? Alignment.bottomLeft : Alignment.topLeft,
              targetAnchor:
                  showAbove ? Alignment.topLeft : Alignment.bottomLeft,
              offset: Offset(0, showAbove ? -verticalMargin : verticalMargin),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(
                    ElememtSize(size: widget.size).getInputBorderRadius(
                        customBorderRadius: widget.customBorderRadius)),
                child: Container(
                  width: size.width,
                  constraints: widget.customHeight != null
                      ? BoxConstraints(maxHeight: widget.customHeight!)
                      : BoxConstraints(
                          maxHeight: actualMaxHeight,
                        ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.header != null) widget.header!,
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: _filteredOptions.length,
                          itemBuilder: (context, index) {
                            final option = _filteredOptions[index];
                            final isSelected = widget.multiple
                                ? _selectedValues.contains(option.value)
                                : _selectedValues.isNotEmpty &&
                                    _selectedValues.first == option.value;
                            final isDisabled = option.disabled ||
                                widget.disabled ||
                                widget.readOnly;

                            return InkWell(
                              onTap: isDisabled
                                  ? null
                                  : () => _handleOptionSelected(option,
                                      triggerOnChange: true),
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
    _isOverlayVisible = true;
  }

  void _hideOverlay({bool unfocus = true}) {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    _isOverlayVisible = false;
    // 根据参数决定是否收起键盘
    if (unfocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController(text: _displayText);
    _filteredOptions = widget.options; // 初始化过滤后的选项

    _focusNode.addListener(() {
      if (_focusNode.hasFocus && !widget.readOnly && !widget.disabled) {
        _showOverlay();
        // 聚焦时重置用户输入标志位
        _isUserTyping = false;
        // 如果不可过滤，聚焦时显示所有选项
        if (!widget.filterable) {
          _filteredOptions = widget.options;
          _updateOverlay();
        }
      }
      // else if (!_focusNode.hasFocus) {
      //   // 失去焦点时隐藏 Overlay
      //   _hideOverlay(unfocus: true);
      // }
    });

    // 添加文本变化监听（仅在可过滤时启用）
    _controller.addListener(() {
      if (_focusNode.hasFocus &&
          !widget.readOnly &&
          !_isAutoSelecting &&
          widget.filterable) {
        // 标记用户正在输入
        _isUserTyping = true;

        // 如果当前有选中的值，且输入文本与选中项的标签不匹配，则清空选择
        if (_selectedValues.isNotEmpty && !widget.multiple) {
          String currentLabel = '';
          try {
            currentLabel = widget.options
                .firstWhere((option) => option.value == _selectedValues.first)
                .label;
          } catch (e) {
            currentLabel = '';
          }

          // 只有当用户实际修改了文本时才清空选择
          if (_controller.text != currentLabel) {
            setState(() {
              _selectedValues.clear();
            });
            _handleTextChanged(_controller.text);
          }
        } else {
          // 如果没有选中值，直接处理文本变化
          _handleTextChanged(_controller.text);
        }
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

    // 检查 options 是否发生变化
    if (widget.options != oldWidget.options) {
      _filteredOptions = widget.options;
      // 只在有搜索文本时才调用 _filterOptions，避免初始化时展开弹窗
      if (_searchText.isNotEmpty) {
        _filterOptions(_searchText);
      }
    }
  }

  void _handleClear() {
    if (!_isDisposed) {
      setState(() {
        _selectedValues = [];
        _filteredOptions = widget.options; // 重置过滤选项
        if (widget.multiple) {
          widget.onChanged?.call(_selectedValues);
        } else {
          widget.onChanged?.call(null);
        }
        _hideOverlay(unfocus: true);
      });
      // 更新输入框显示内容
      _controller.text = _displayText;
      widget.onClear?.call();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _autoSelectTimer?.cancel();
    _filterDebounceTimer?.cancel();
    _focusNode.dispose();
    _controller.dispose();
    _hideOverlay(unfocus: false);
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
        nonEditable: !widget.filterable,
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
