import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

/// A text input component that follows Element Plus design guidelines.
///
/// The [EInput] widget provides a customizable text input field with various
/// features like clearable input, prefix/suffix icons, and different states.
///
/// ## Example
///
/// ```dart
/// EInput(
///   placeholder: 'Enter your name',
///   clearable: true,
///   prefix: Icon(Icons.person),
///   onChanged: (value) => print('Input: $value'),
/// )
///
/// // 多行输入示例
/// EInput(
///   placeholder: 'Enter your message',
///   minLines: 3,
///   maxLines: 5,
///   onChanged: (value) => print('Message: $value'),
/// )
/// ```
class EInput extends StatefulWidget {
  /// The controller for the text input.
  ///
  /// If not provided, a new [TextEditingController] will be created.
  final TextEditingController? textController;

  /// The placeholder text to display when the input is empty.
  final String? placeholder;

  /// Whether to show a clear button when the input has text.
  ///
  /// When true, a clear button will appear when the input has text,
  /// allowing users to quickly clear the input.
  final bool clearable;

  /// Whether the input is disabled.
  ///
  /// When true, the input cannot be edited and will show a disabled style.
  final bool disabled;

  /// Whether the input is read-only.
  ///
  /// When true, the input can be focused but cannot be edited.
  final bool readOnly;

  /// Whether the input is a password input.
  ///
  /// When true, the input will be masked as password.
  final bool password;

  /// A widget to display before the input text.
  ///
  /// Typically an [Icon] or other small widget.
  final Widget? prefix;

  /// A widget to display after the input text.
  ///
  /// Typically an [Icon] or other small widget.
  final Widget? suffix;
  final Widget? prepend;
  final Widget? append;

  /// The color type of the input.
  ///
  /// This determines the color scheme used for the input's border and focus state.
  /// Defaults to [EColorType.primary].
  final EColorType colorType;

  /// The size of the input.
  ///
  /// This affects the height, font size, and border radius of the input.
  /// Defaults to [ESizeItem.medium].
  final ESizeItem size;

  /// A custom color to use for the input.
  ///
  /// If provided, this overrides the color determined by [colorType].
  final Color? customColor;

  /// The default color for the input's border.
  ///
  /// This is used when the input is not focused and not disabled.
  /// Defaults to [EBasicColors.borderGray].
  final Color borderColor;

  /// A custom height for the input.
  ///
  /// If provided, this overrides the height determined by [size].
  final double? customHeight;

  /// A custom font size for the input text.
  ///
  /// If provided, this overrides the font size determined by [size].
  final double? customFontSize;

  /// A custom border radius for the input.
  ///
  /// If provided, this overrides the border radius determined by [size].
  final double? customBorderRadius;

  /// Whether to show the placeholder text above the input when focused.
  ///
  /// When true, the placeholder will move above the input when it is focused.
  final bool showPlaceholderOnTop;

  /// Callback function when the input text changes.
  ///
  /// The callback receives the new text value.
  final ValueChanged<String>? onChanged;

  /// Callback function when the input gains focus.
  final VoidCallback? onFocus;

  /// Callback function when the input loses focus.
  final VoidCallback? onBlur;
  final VoidCallback? onClear;
  final FocusNode? focusNode;

  /// The minimum number of lines for the input.
  ///
  /// This determines the minimum height of the input field.
  /// Defaults to 1.
  final int? minLines;

  /// The maximum number of lines for the input.
  ///
  /// This determines the maximum height of the input field.
  /// Defaults to 1.
  final int? maxLines;

  /// Creates an [EInput] widget.
  ///
  /// The [placeholder] argument defaults to an empty string.
  const EInput({
    super.key,
    this.textController,
    this.onChanged,
    this.placeholder = '',
    this.clearable = false,
    this.disabled = false,
    this.readOnly = false,
    this.prefix,
    this.suffix,
    this.prepend,
    this.append,
    this.colorType = EColorType.primary,
    this.size = ESizeItem.medium,
    this.customColor,
    this.borderColor = EBasicColors.borderGray,
    this.customHeight,
    this.customFontSize,
    this.customBorderRadius,
    this.onFocus,
    this.onBlur,
    this.showPlaceholderOnTop = false,
    this.password = false,
    this.focusNode,
    this.onClear,
    this.minLines,
    this.maxLines,
  });

  @override
  State<EInput> createState() => _EInputState();

  /// 创建一个新的 EInput 实例，支持覆盖特定属性
  EInput copyWith({
    Key? key,
    TextEditingController? textController,
    ValueChanged<String>? onChanged,
    String? placeholder,
    bool? clearable,
    bool? disabled,
    bool? readOnly,
    Widget? prefix,
    Widget? suffix,
    Widget? prepend,
    Widget? append,
    EColorType? colorType,
    ESizeItem? size,
    Color? customColor,
    Color? borderColor,
    double? customHeight,
    double? customFontSize,
    double? customBorderRadius,
    VoidCallback? onFocus,
    VoidCallback? onBlur,
    bool? showPlaceholderOnTop,
    bool? password,
    FocusNode? focusNode,
    VoidCallback? onClear,
    int? minLines,
    int? maxLines,
  }) {
    return EInput(
      key: key ?? this.key,
      textController: textController ?? this.textController,
      onChanged: onChanged ?? this.onChanged,
      placeholder: placeholder ?? this.placeholder,
      clearable: clearable ?? this.clearable,
      disabled: disabled ?? this.disabled,
      readOnly: readOnly ?? this.readOnly,
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
      prepend: prepend ?? this.prepend,
      append: append ?? this.append,
      colorType: colorType ?? this.colorType,
      size: size ?? this.size,
      customColor: customColor ?? this.customColor,
      borderColor: borderColor ?? this.borderColor,
      customHeight: customHeight ?? this.customHeight,
      customFontSize: customFontSize ?? this.customFontSize,
      customBorderRadius: customBorderRadius ?? this.customBorderRadius,
      onFocus: onFocus ?? this.onFocus,
      onBlur: onBlur ?? this.onBlur,
      showPlaceholderOnTop: showPlaceholderOnTop ?? this.showPlaceholderOnTop,
      password: password ?? this.password,
      focusNode: focusNode ?? this.focusNode,
      onClear: onClear ?? this.onClear,
      minLines: minLines ?? this.minLines,
      maxLines: maxLines ?? this.maxLines,
    );
  }
}

class _EInputState extends State<EInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  // ignore: unused_field
  bool _isHovered = false;
  bool _isFocused = false;
  bool _hasValue = false;
  bool _isPasswordVisible = false;
  @override
  void initState() {
    super.initState();
    _controller = widget.textController ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_handleTextChange);
    _hasValue = _controller.text.isNotEmpty;
    _isPasswordVisible = widget.password;
  }

  void _handleTextChange() {
    if (_hasValue != _controller.text.isNotEmpty) {
      setState(() {
        _hasValue = _controller.text.isNotEmpty;
      });
    }
  }

  @override
  void didUpdateWidget(EInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.textController != oldWidget.textController &&
        widget.textController != _controller) {
      _controller.removeListener(_handleTextChange);
      if (oldWidget.textController == null) {
        _controller.dispose();
      }
      _controller = widget.textController ?? TextEditingController();
      _controller.addListener(_handleTextChange);
      _hasValue = _controller.text.isNotEmpty;
    }

    // 处理FocusNode更新
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_handleFocusChange);
      if (oldWidget.focusNode == null) {
        _focusNode.dispose();
      }
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_handleFocusChange);
    }

    // 同步外部 textController 的文本内容变化
    if (widget.textController != null &&
        widget.textController!.text != _controller.text) {
      _controller.text = widget.textController!.text;
      _hasValue = _controller.text.isNotEmpty;
    }
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    if (_focusNode.hasFocus) {
      widget.onFocus?.call();
    } else {
      widget.onBlur?.call();
    }
  }

  void _handleClear() {
    if (widget.readOnly) return;
    setState(() {
      _controller.clear();
      _hasValue = false;
    });
    widget.onChanged?.call('');
    widget.onClear?.call();
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    if (widget.textController == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: widget.customHeight ?? 
              (widget.maxLines != null && widget.maxLines! > 1 
                  ? null 
                  : ElememtSize(size: widget.size).getInputHeight()),
          child: MouseRegion(
            onEnter: (_) => setState(() {
              _isHovered = true;
            }),
            onExit: (_) => setState(() {
              _isHovered = false;
            }),
            child: Container(
              padding: EdgeInsets.only(
                  left: widget.prepend != null ? 0 : 0,
                  right: widget.append != null ? 0 : 0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.readOnly? 
                    Colors.grey[100]!: 
                    widget.disabled
                      ? widget.borderColor
                      : _isFocused
                          ? getColorByType(
                              type: widget.colorType,
                              customColor: widget.customColor)
                          : widget.borderColor,
                ),
                borderRadius: BorderRadius.circular(
                    ElememtSize(size: widget.size).getInputBorderRadius(
                        customBorderRadius: widget.customBorderRadius)),
                color: widget.disabled ? Colors.grey[100] : Colors.white,
              ),
              child: Row(
                children: [
                  if (widget.prepend != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              ElememtSize(size: widget.size)
                                  .getInputBorderRadius(
                                      customBorderRadius:
                                          widget.customBorderRadius)),
                          bottomLeft: Radius.circular(
                              ElememtSize(size: widget.size)
                                  .getInputBorderRadius(
                                      customBorderRadius:
                                          widget.customBorderRadius)),
                        ),
                        color: Colors.grey[100],
                      ),
                      height: double.infinity,
                      child: widget.prepend!,
                    ),
                  const SizedBox(width: 8),
                  if (widget.prefix != null)
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: widget.prefix,
                    ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      focusNode: _focusNode,
                      enabled: !widget.disabled,
                      readOnly: widget.readOnly,
                      cursorOpacityAnimates: false,
                      obscureText: _isPasswordVisible,
                      maxLines: widget.maxLines ?? 1,
                      minLines: widget.minLines ?? 1,
                      style: TextStyle(
                          fontSize: ElememtSize(size: widget.size)
                              .getInputFontSize(
                                  customFontSize: widget.customFontSize)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        isCollapsed: widget.maxLines == null || widget.maxLines == 1,
                        hintText: widget.readOnly? null: widget.showPlaceholderOnTop && _isFocused
                            ? null
                            : widget.placeholder,
                      ),
                      onChanged: widget.onChanged,
                      onTap: widget.readOnly
                          ? () {
                              widget.onFocus?.call();
                            }
                          : null,
                      enableInteractiveSelection: true,
                    ),
                  ),
                  if (widget.clearable && _hasValue && !widget.disabled)
                    GestureDetector(
                      onTap: _handleClear,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: getColorByType(
                                type: widget.colorType,
                                customColor: widget.customColor),
                          ),
                        ),
                      ),
                    ),
                  if (widget.password)
                    GestureDetector(
                      onTap: () => setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      }),
                      child: !_isPasswordVisible
                          ? Icon(
                              Icons.visibility,
                              size: 16,
                              color: getColorByType(
                                  type: widget.colorType,
                                  customColor: widget.customColor),
                            )
                          : Icon(
                              Icons.visibility_off,
                              size: 16,
                              color: getColorByType(
                                  type: widget.colorType,
                                  customColor: widget.customColor),
                            ),
                    ),
                  const SizedBox(width: 4),
                  if (widget.suffix != null)
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: widget.suffix,
                    ),
                  const SizedBox(width: 8),
                  if (widget.append != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                              ElememtSize(size: widget.size)
                                  .getInputBorderRadius(
                                      customBorderRadius:
                                          widget.customBorderRadius)),
                          bottomRight: Radius.circular(
                              ElememtSize(size: widget.size)
                                  .getInputBorderRadius(
                                      customBorderRadius:
                                          widget.customBorderRadius)),
                        ),
                        color: Colors.grey[100],
                      ),
                      height: double.infinity,
                      child: widget.append!,
                    ),
                ],
              ),
            ),
          ),
        ),
        if (widget.showPlaceholderOnTop && (_isFocused || _hasValue))
          Positioned(
            left: 8,
            top: -8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              color: Colors.white,
              child: Text(
                widget.placeholder ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: _isFocused
                      ? getColorByType(
                          type: widget.colorType,
                          customColor: widget.customColor)
                      : Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
      ],
    );
  }
}
