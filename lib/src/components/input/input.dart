import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';

enum EInputSize { small, medium, large }

class EInput extends StatefulWidget {
  final String? value;
  final ValueChanged<String>? onChanged;
  final String? placeholder;
  final bool clearable;
  final bool disabled;
  final bool readOnly;
  final Widget? prefix;
  final Widget? suffix;
  final EInputSize size;
  final double? width;
  final double? height;
  final VoidCallback? onFocus;
  final VoidCallback? onBlur;

  const EInput({
    Key? key,
    this.value,
    this.onChanged,
    this.placeholder = '',
    this.clearable = false,
    this.disabled = false,
    this.readOnly = false,
    this.prefix,
    this.suffix,
    this.size = EInputSize.medium,
    this.width,
    this.height,
    this.onFocus,
    this.onBlur,
  }) : super(key: key);

  @override
  State<EInput> createState() => _EInputState();
}

class _EInputState extends State<EInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(EInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != _controller.text) {
      _controller.text = widget.value ?? '';
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
    });
    widget.onChanged?.call('');
  }

  double get _height {
    if (widget.height != null) {
      return widget.height!;
    }
    switch (widget.size) {
      case EInputSize.small:
        return 32;
      case EInputSize.large:
        return 48;
      case EInputSize.medium:
      default:
        return 40;
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case EInputSize.small:
        return 14;
      case EInputSize.large:
        return 18;
      case EInputSize.medium:
      default:
        return 16;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasValue = _controller.text.isNotEmpty;
    return SizedBox(
      height: _height,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.disabled
                  ? EBasicColors.borderGray
                  : _isFocused
                      ? EColorTypes.primary
                      : EBasicColors.borderGray,
            ),
            borderRadius: BorderRadius.circular(6),
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
                  style: TextStyle(fontSize: _fontSize),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    isCollapsed: true,
                    hintText: widget.placeholder,
                  ),
                  onChanged: widget.onChanged,
                ),
              ),
              if (widget.clearable &&
                  hasValue &&
                  !widget.disabled &&
                  !_controller.text.isEmpty)
                GestureDetector(
                  onTap: _handleClear,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Icon(Icons.close,
                          size: 16, color: EColorTypes.primary),
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
    );
  }
}
