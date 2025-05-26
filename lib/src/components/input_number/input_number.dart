import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';

enum EInputNumberSize { small, medium, large }

enum EInputNumberControlsPosition { left, right }

class EInputNumber extends StatefulWidget {
  final double? value;
  final ValueChanged<double?>? onChanged;
  final double? min;
  final double? max;
  final double step;
  final int? precision;
  final bool stepStrictly;
  final String? placeholder;
  final bool disabled;
  final bool readOnly;
  final bool clearable;
  final EInputNumberSize size;
  final EInputNumberControlsPosition controlsPosition;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? decreaseIcon;
  final Widget? increaseIcon;
  final VoidCallback? onFocus;
  final VoidCallback? onBlur;

  const EInputNumber({
    Key? key,
    this.value,
    this.onChanged,
    this.min,
    this.max,
    this.step = 1,
    this.precision,
    this.stepStrictly = false,
    this.placeholder,
    this.disabled = false,
    this.readOnly = false,
    this.clearable = false,
    this.size = EInputNumberSize.medium,
    this.controlsPosition = EInputNumberControlsPosition.right,
    this.prefix,
    this.suffix,
    this.decreaseIcon,
    this.increaseIcon,
    this.onFocus,
    this.onBlur,
  }) : super(key: key);

  @override
  State<EInputNumber> createState() => _EInputNumberState();
}

class _EInputNumberState extends State<EInputNumber> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value?.toString() ?? '');
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(EInputNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value &&
        widget.value?.toString() != _controller.text) {
      _controller.text = widget.value?.toString() ?? '';
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
    widget.onChanged?.call(null);
  }

  void _handleDecrease() {
    if (widget.disabled || widget.readOnly) return;
    double? currentValue = double.tryParse(_controller.text);
    currentValue ??= widget.min ?? 0;
    double newValue = currentValue - widget.step;
    if (widget.min != null && newValue < widget.min!) newValue = widget.min!;
    if (widget.stepStrictly) {
      newValue = (newValue / widget.step).round() * widget.step;
    }
    if (widget.precision != null) {
      newValue = double.parse(newValue.toStringAsFixed(widget.precision!));
    }
    setState(() {
      _controller.text = newValue.toString();
    });
    widget.onChanged?.call(newValue);
  }

  void _handleIncrease() {
    if (widget.disabled || widget.readOnly) return;
    double? currentValue = double.tryParse(_controller.text);
    currentValue ??= widget.min ?? 0;
    double newValue = currentValue + widget.step;
    if (widget.max != null && newValue > widget.max!) newValue = widget.max!;
    if (widget.stepStrictly) {
      newValue = (newValue / widget.step).round() * widget.step;
    }
    if (widget.precision != null) {
      newValue = double.parse(newValue.toStringAsFixed(widget.precision!));
    }
    setState(() {
      _controller.text = newValue.toString();
    });
    widget.onChanged?.call(newValue);
  }

  double get _height {
    switch (widget.size) {
      case EInputNumberSize.small:
        return 32;
      case EInputNumberSize.large:
        return 48;
      case EInputNumberSize.medium:
      // default:
        return 40;
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case EInputNumberSize.small:
        return 14;
      case EInputNumberSize.large:
        return 18;
      case EInputNumberSize.medium:
      // default:
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
        onEnter: (_) {
          setState(() {
            _isHovered = true;
            print('onEnter: $_isHovered');
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
            print('onExit: $_isHovered');
          });
        },
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
              // if (widget.controlsPosition == EInputNumberControlsPosition.left)
              _buildDecreaseButton(),
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
                  onChanged: (value) {
                    double? newValue = double.tryParse(value);
                    if (newValue != null) {
                      if (widget.min != null && newValue < widget.min!)
                        newValue = widget.min!;
                      if (widget.max != null && newValue > widget.max!)
                        newValue = widget.max!;
                      if (widget.stepStrictly) {
                        newValue =
                            (newValue / widget.step).round() * widget.step;
                      }
                      if (widget.precision != null) {
                        newValue = double.parse(
                            newValue.toStringAsFixed(widget.precision!));
                      }
                      widget.onChanged?.call(newValue);
                    }
                  },
                ),
              ),
              if (widget.clearable &&
                  hasValue &&
                  !widget.disabled &&
                  !widget.readOnly)
                GestureDetector(
                  onTap: _handleClear,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: const Icon(Icons.close,
                          size: 16, color: EColorTypes.primary),
                    ),
                  ),
                ),
              if (widget.suffix != null)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: widget.suffix,
                ),
              // if (widget.controlsPosition == EInputNumberControlsPosition.right)
              _buildIncreaseButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDecreaseButton() {
    return IconButton(
      icon: widget.decreaseIcon ?? const Icon(Icons.remove, size: 16),
      onPressed: widget.disabled || widget.readOnly ? null : _handleDecrease,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildIncreaseButton() {
    return IconButton(
      icon: widget.increaseIcon ?? const Icon(Icons.add, size: 16),
      onPressed: widget.disabled || widget.readOnly ? null : _handleIncrease,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}
