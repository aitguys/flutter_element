import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';

class EInput extends StatefulWidget {
  final TextEditingController? textController;

  final String? placeholder;
  final bool clearable;
  final bool disabled;
  final bool readOnly;
  final Widget? prefix;
  final Widget? suffix;
  final EColorType colorType;
  final ESizeItem size;
  final Color? customColor;
  final Color defaultColor;
  final double? customHeight;
  final double? customFontSize;
  final double? customBorderRadius;
  final bool showPlaceholderOnTop;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFocus;
  final VoidCallback? onBlur;

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
    this.colorType = EColorType.primary,
    this.customColor,
    this.defaultColor = EBasicColors.borderGray,
    this.size = ESizeItem.medium,
    this.customHeight,
    this.customFontSize,
    this.customBorderRadius,
    this.onFocus,
    this.onBlur,
    this.showPlaceholderOnTop = false,
  });

  @override
  State<EInput> createState() => _EInputState();
}

class _EInputState extends State<EInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isHovered = false;
  bool _isFocused = false;
  bool _hasValue = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.textController ?? TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_handleTextChange);
    _hasValue = _controller.text.isNotEmpty;
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
      _controller = widget.textController ?? TextEditingController();
      _controller.addListener(_handleTextChange);
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
    setState(() {
      _controller.clear();
      _hasValue = false;
    });
    widget.onChanged?.call('');
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: ElememtSize(size: widget.size)
              .getInputHeight(customHeight: widget.customHeight),
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.disabled
                      ? widget.defaultColor!
                      : _isFocused
                          ? getColorByType(
                              type: widget.colorType,
                              customColor: widget.customColor)
                          : widget.defaultColor,
                ),
                borderRadius: BorderRadius.circular(
                    ElememtSize(size: widget.size).getInputBorderRadius(
                        customBorderRadius: widget.customBorderRadius)),
                color: widget.disabled ? Colors.grey[100] : Colors.white,
              ),
              child: Row(
                children: [
                  if (widget.prefix != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: widget.prefix,
                    ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      enabled: !widget.disabled,
                      readOnly: widget.readOnly,
                      style: TextStyle(
                          fontSize: ElememtSize(size: widget.size)
                              .getInputFontSize(
                                  customFontSize: widget.customFontSize)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        isCollapsed: true,
                        hintText: widget.showPlaceholderOnTop && _isFocused
                            ? null
                            : widget.placeholder,
                      ),
                      onChanged: widget.onChanged,
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
                  if (widget.suffix != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: widget.suffix,
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
