import 'package:flutter/material.dart';

/// A segmented control option with label, value, and optional icon.
class FlSegmentedOption<T> {
  /// The text label to display.
  final String label;
  /// The value associated with this option.
  final T value;
  /// Optional icon to display before the label.
  final Widget? icon;
  /// Whether this option is disabled.
  final bool disabled;

  const FlSegmentedOption({
    required this.label,
    required this.value,
    this.icon,
    this.disabled = false,
  });
}

/// A segmented control widget that displays a group of selectable options.
class FlSegmented<T> extends StatefulWidget {
  /// The list of options to display.
  final List<FlSegmentedOption<T>> options;
  /// The currently selected value.
  final T? value;
  /// Callback when selection changes.
  final ValueChanged<T>? onChange;
  /// Whether to use full width.
  final bool block;
  /// The size of the control.
  final Size? size;
  /// Text style for unselected options.
  final TextStyle? textStyle;
  /// Text style for selected option.
  final TextStyle? selectedTextStyle;
  /// Background color of the control.
  final Color? backgroundColor;
  /// Background color of selected option.
  final Color? selectedBackgroundColor;
  /// Border color of the control.
  final Color? borderColor;
  /// Border radius of the control.
  final double borderRadius;
  /// Padding around each option.
  final EdgeInsetsGeometry? padding;

  const FlSegmented({
    super.key,
    required this.options,
    this.value,
    this.onChange,
    this.block = false,
    this.size,
    this.textStyle,
    this.selectedTextStyle,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.borderColor,
    this.borderRadius = 4.0,
    this.padding,
  });

  @override
  State<FlSegmented<T>> createState() => _FlSegmentedState<T>();
}

class _FlSegmentedState<T> extends State<FlSegmented<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedIndex = 0;
  final GlobalKey _segmentedKey = GlobalKey();
  final List<GlobalKey> _optionKeys = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    if (widget.value != null) {
      _selectedIndex =
          widget.options.indexWhere((option) => option.value == widget.value);
      if (_selectedIndex == -1) _selectedIndex = 0;
    }

    _optionKeys.addAll(
      List.generate(widget.options.length, (index) => GlobalKey()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    if (widget.options[index].disabled) return;

    setState(() {
      _selectedIndex = index;
    });

    widget.onChange?.call(widget.options[index].value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTextStyle = theme.textTheme.bodyMedium!;
    final defaultSelectedTextStyle = defaultTextStyle.copyWith(
      color: theme.colorScheme.primary,
    );

    return Container(
      key: _segmentedKey,
      width: widget.block ? double.infinity : null,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: widget.borderColor ?? theme.dividerColor,
        ),
      ),
      child: Row(
        mainAxisSize: widget.block ? MainAxisSize.max : MainAxisSize.min,
        children: widget.options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final isSelected = index == _selectedIndex;
          final isDisabled = option.disabled;

          return Expanded(
            key: _optionKeys[index],
            child: GestureDetector(
              onTap: isDisabled ? null : () => _onTap(index),
              child: Container(
                padding: widget.padding ??
                    const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (widget.selectedBackgroundColor ??
                          theme.colorScheme.primary.withValues(alpha: 0.1))
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(widget.borderRadius - 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (option.icon != null) ...[
                      IconTheme(
                        data: IconThemeData(
                          color: isSelected
                              ? (widget.selectedTextStyle?.color ??
                                  theme.colorScheme.primary)
                              : (widget.textStyle?.color ??
                                  defaultTextStyle.color),
                          size: 16,
                        ),
                        child: option.icon!,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      option.label,
                      style: (isSelected
                              ? widget.selectedTextStyle
                              : widget.textStyle) ??
                          (isSelected
                                  ? defaultSelectedTextStyle
                                  : defaultTextStyle)
                              .copyWith(
                            color: isDisabled ? theme.disabledColor : null,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
