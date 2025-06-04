import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';
import '../input/input.dart';

/// Defines the available sizes for the input number component.
enum EInputNumberSize {
  /// Small size (32px height, 14px font)
  small,

  /// Medium size (40px height, 16px font)
  medium,

  /// Large size (48px height, 18px font)
  large,
}

/// Defines the position of the increment/decrement controls.
enum EInputNumberControlsPosition {
  /// Controls appear on the left side of the input
  left,

  /// Controls appear on the right side of the input
  right,
  both
}

/// An input component for entering numbers with increment/decrement controls.
/// It follows Element Plus design guidelines and provides features like:
/// - Minimum and maximum value constraints
/// - Step increment/decrement
/// - Decimal precision control
/// - Strict step mode
/// - Disabled and read-only states
/// - Clearable input
/// - Custom prefix and suffix
/// - Custom control icons
/// - Focus and blur callbacks
///
/// Example:
/// ```dart
/// EInputNumber(
///   value: 1,
///   min: 0,
///   max: 100,
///   step: 1,
///   precision: 2,
///   controlsPosition: EInputNumberControlsPosition.right,
///   onChanged: (value) {
///     print('Value: $value');
///   },
/// )
/// ```
class EInputNumber extends StatefulWidget {
  /// The current value of the input.
  final double? value;

  /// Callback function when the value changes.
  final ValueChanged<double?>? onChanged;

  /// The minimum allowed value.
  final double? min;

  /// The maximum allowed value.
  final double? max;

  /// The step increment/decrement value.
  /// Default is 1.
  final double step;

  /// The number of decimal places to display.
  /// If null, no decimal places are shown.
  final int? precision;

  /// Whether to strictly enforce step increments.
  /// When true, the value will always be a multiple of the step.
  final bool stepStrictly;

  /// Placeholder text when the input is empty.
  final String? placeholder;

  /// Whether the input is disabled.
  /// When disabled, the input cannot be interacted with.
  final bool disabled;

  /// Whether the input is read-only.
  /// When read-only, the value can be displayed but not changed.
  final bool readOnly;

  /// Whether to show a clear button when the input has content.
  final bool clearable;

  /// The size of the input number component.
  /// Affects the height and font size.
  final ESizeItem size;

  /// The position of the increment/decrement controls.
  /// Default is [EInputNumberControlsPosition.right].
  final EInputNumberControlsPosition controlsPosition;

  /// Widget to display before the input.
  final Widget? prefix;

  /// Widget to display after the input.
  final Widget? suffix;

  /// Custom icon for the decrease button.
  /// If not provided, a minus sign (-) is used.
  final Widget? decreaseIcon;

  /// Custom icon for the increase button.
  /// If not provided, a plus sign (+) is used.
  final Widget? increaseIcon;

  /// Callback function when the input gains focus.
  final VoidCallback? onFocus;

  /// Callback function when the input loses focus.
  final VoidCallback? onBlur;

  /// The color type of the input.
  final EColorType colorType;

  /// A custom color to use for the input.
  final Color? customColor;

  /// The default color for the input's border.
  final Color defaultColor;

  /// A custom height for the input.
  final double? customHeight;

  /// A custom font size for the input text.
  final double? customFontSize;

  /// A custom border radius for the input.
  final double? customBorderRadius;

  const EInputNumber({
    super.key,
    this.value,
    this.onChanged,
    this.onFocus,
    this.onBlur,
    this.min,
    this.max,
    this.step = 1,
    this.precision,
    this.stepStrictly = false,
    this.placeholder,
    this.disabled = false,
    this.readOnly = false,
    this.clearable = false,
    this.size = ESizeItem.medium,
    this.controlsPosition = EInputNumberControlsPosition.both,
    this.prefix,
    this.suffix,
    this.decreaseIcon,
    this.increaseIcon,
    this.colorType = EColorType.primary,
    this.customColor,
    this.defaultColor = EBasicColors.borderGray,
    this.customHeight,
    this.customFontSize,
    this.customBorderRadius,
  });

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

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasValue = _controller.text.isNotEmpty;

    return EInput(
      textController: _controller,
      placeholder: widget.placeholder,
      clearable: widget.clearable,
      disabled: widget.disabled,
      readOnly: widget.readOnly,
      prefix: widget.prefix,
      suffix: widget.suffix,
      colorType: widget.colorType,
      customColor: widget.customColor,
      defaultColor: widget.defaultColor,
      size: widget.size,
      customHeight: widget.customHeight,
      customFontSize: widget.customFontSize,
      customBorderRadius: widget.customBorderRadius,
      onFocus: widget.onFocus,
      onBlur: widget.onBlur,
      onChanged: (value) {
        double? newValue = double.tryParse(value);
        if (newValue != null) {
          if (widget.min != null && newValue < widget.min!) {
            newValue = widget.min!;
          }
          if (widget.max != null && newValue > widget.max!) {
            newValue = widget.max!;
          }
          if (widget.stepStrictly) {
            newValue = (newValue / widget.step).round() * widget.step;
          }
          if (widget.precision != null) {
            newValue =
                double.parse(newValue.toStringAsFixed(widget.precision!));
          }
          widget.onChanged?.call(newValue);
        }
      },
      prepend: widget.controlsPosition == EInputNumberControlsPosition.left ||
              widget.controlsPosition == EInputNumberControlsPosition.both
          ? _buildDecreaseButton()
          : null,
      append: widget.controlsPosition == EInputNumberControlsPosition.right ||
              widget.controlsPosition == EInputNumberControlsPosition.both
          ? _buildIncreaseButton()
          : null,
    );
  }

  Widget _buildDecreaseButton() {
    return IconButton(
      icon: widget.decreaseIcon ?? const Icon(Icons.remove, size: 16),
      onPressed: widget.disabled || widget.readOnly ? null : _handleDecrease,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      hoverColor: Colors.transparent,
    );
  }

  Widget _buildIncreaseButton() {
    return IconButton(
      icon: widget.increaseIcon ?? const Icon(Icons.add, size: 16),
      onPressed: widget.disabled || widget.readOnly ? null : _handleIncrease,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      hoverColor: Colors.transparent,
    );
  }
}
