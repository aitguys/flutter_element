import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

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

  /// 高度属性，高度为 null/auto 时由内容自动决定
  final double? height;

  /// Text style for unselected options.

  /// Text style for selected option.

  /// Background color of the control.
  final Color? backgroundColor;

  final EColorType selectedColorType;

  /// Background color of selected option.
  final Color? selectedBackgroundColor;

  final Color? contentColor;
  final Color? selectedContentColor;

  /// Border color of the control.
  final Color? borderColor;

  /// Border radius of the control.
  final double borderRadius;

  /// Whether the segmented control is round.
  final bool isRound;

  /// The width of the segmented control. If null or 'auto', the width is determined by content.
  final double? width;
  final TextStyle? textStyle;
  final TextStyle? selectedTextStyle;
  final IconThemeData? iconTheme;
  final IconThemeData? selectedIconTheme;

  const FlSegmented(
      {super.key,
      required this.options,
      this.value,
      this.onChange,
      this.block = false,
      this.size,
      this.height = 40, // 新增 height 属性，默认 auto
      this.backgroundColor,
      this.selectedBackgroundColor,
      this.borderColor,
      this.selectedColorType = EColorType.primary,
      this.contentColor,
      this.selectedContentColor,
      this.borderRadius = 4.0,
      this.isRound = false, // 新增 isRound 属性，默认 false
      this.width, // 新增 width 属性，默认 auto
      this.textStyle,
      this.selectedTextStyle,
      this.iconTheme,
      this.selectedIconTheme});

  @override
  State<FlSegmented<T>> createState() => _FlSegmentedState<T>();
}

class _FlSegmentedState<T> extends State<FlSegmented<T>>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  int _selectedIndex = 0;
  final GlobalKey _segmentedKey = GlobalKey();
  final List<GlobalKey> _optionKeys = [];

  // For animation of left/width
  double _backgroundLeft = 0;
  double _backgroundWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.value != null) {
      _selectedIndex =
          widget.options.indexWhere((option) => option.value == widget.value);
      if (_selectedIndex == -1) _selectedIndex = 0;
    }
    _optionKeys.addAll(
      List.generate(widget.options.length, (index) => GlobalKey()),
    );
    // Wait for first frame to get correct positions
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateBackgroundPosition();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Called when the screen size changes (e.g., orientation, resize)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateBackgroundPosition();
    });
  }

  @override
  void didUpdateWidget(covariant FlSegmented<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null) {
      final idx =
          widget.options.indexWhere((option) => option.value == widget.value);
      if (idx != -1 && idx != _selectedIndex) {
        setState(() {
          _selectedIndex = idx;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateBackgroundPosition();
        });
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateBackgroundPosition();
      });
    }
  }

  void _onTap(int index) {
    if (widget.options[index].disabled) return;

    setState(() {
      _selectedIndex = index;
    });

    widget.onChange?.call(widget.options[index].value);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateBackgroundPosition();
    });
  }

  void _updateBackgroundPosition() {
    if (!mounted) return;
    final key = _optionKeys.length > _selectedIndex
        ? _optionKeys[_selectedIndex]
        : null;
    final parentBox = _segmentedKey.currentContext?.findRenderObject();
    if (key != null &&
        key.currentContext != null &&
        parentBox is RenderBox &&
        key.currentContext!.findRenderObject() is RenderBox) {
      final box = key.currentContext!.findRenderObject() as RenderBox;
      final parentOffset = parentBox.localToGlobal(Offset.zero);
      final childOffset = box.localToGlobal(Offset.zero);
      final left = childOffset.dx - parentOffset.dx;
      final width = box.size.width;
      setState(() {
        _backgroundLeft = left;
        _backgroundWidth = width;
      });
    }
  }

  double _getBorderRadius() {
    if (widget.isRound) {
      // Use a large value for round effect, e.g. 999
      return 999.0;
    }
    return widget.borderRadius;
  }

  Color _calculateContentColor(bool isSelected, bool isDisabled) {
    return isSelected
        ? calculateContentColor(
            getBackGroundColorByTypeAndTheme(
                type: widget.selectedColorType,
                customColor: widget.contentColor),
            isDisabled: isDisabled)
        : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTextStyle = theme.textTheme.bodyMedium!;
    final defaultSelectedTextStyle = defaultTextStyle.copyWith(
      color: theme.colorScheme.primary,
    );

    Widget content = LayoutBuilder(
      builder: (context, constraints) {
        final optionCount = widget.options.length;
        // Determine the totalWidth based on width property, block, and size
        double? totalWidth;
        if (widget.width != null) {
          totalWidth = widget.width;
        } else if (widget.block) {
          totalWidth = constraints.maxWidth.isFinite
              ? constraints.maxWidth
              : (widget.size?.width ?? 0);
        } else if (widget.size?.width != null) {
          totalWidth = widget.size!.width;
        } else {
          totalWidth = null; // auto
        }

        final double optionWidth =
            widget.block && totalWidth != null && totalWidth > 0
                ? totalWidth / optionCount
                : double.infinity;

        // If block, we can calculate left/width directly
        double? left, width;
        if (widget.block && totalWidth != null && totalWidth > 0) {
          left = optionWidth * _selectedIndex;
          width = optionWidth;
        } else {
          left = _backgroundLeft;
          width = _backgroundWidth;
        }

        // 监听布局变化，防止屏幕缩放时浮层不更新
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateBackgroundPosition();
        });

        return Container(
          key: _segmentedKey,
          width: totalWidth,
          height: widget.height, // 支持外部设置高度
          decoration: BoxDecoration(
            color: widget.backgroundColor ??
                const Color.fromRGBO(245, 247, 250, 1),
            borderRadius: BorderRadius.circular(
                widget.isRound ? 999.0 : widget.borderRadius),
            // border: Border.all(
            //   color: widget.borderColor ?? theme.dividerColor,
            // ),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Animated background for selected option
              AnimatedPositioned(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                left: left,
                top: 0,
                bottom: 0,
                width: width,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: getColorByType(
                        type: widget.selectedColorType,
                        customColor: widget.selectedBackgroundColor),
                    borderRadius: BorderRadius.circular(_getBorderRadius() - 1),
                  ),
                ),
              ),
              Row(
                mainAxisSize: widget.block || totalWidth != null
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                children: widget.options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  final isSelected = index == _selectedIndex;
                  final isDisabled = option.disabled;

                  return Expanded(
                    key: _optionKeys[index],
                    child: GestureDetector(
                      onTap: isDisabled ? null : () => _onTap(index),
                      child: AnimatedDefaultTextStyle(
                        style: TextStyle(
                          color: calculateContentColor(
                              getBackGroundColorByTypeAndTheme(
                                  type: widget.selectedColorType,
                                  customColor: widget.contentColor)),
                        ),
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeInOut,
                        child: Container(
                          width: widget.block || totalWidth != null
                              ? double.infinity
                              : null,
                          padding: EdgeInsets.zero,
                          // 默认 padding 为 0
                          // Remove color here, handled by animated background
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (option.icon != null) ...[
                                IconTheme(
                                  data: isSelected
                                      ? widget.selectedIconTheme ??
                                          IconThemeData(
                                            color: _calculateContentColor(
                                                isSelected, isDisabled),
                                            size: 16,
                                          )
                                      : widget.iconTheme ??
                                          IconThemeData(
                                            color: _calculateContentColor(
                                                isSelected, isDisabled),
                                            size: 16,
                                          ),
                                  child: option.icon!,
                                ),
                                const SizedBox(width: 4),
                              ],
                              Text(
                                option.label,
                                style: isSelected
                                    ? widget.selectedTextStyle ??
                                        TextStyle(
                                          color: _calculateContentColor(
                                              isSelected, isDisabled),
                                        )
                                    : widget.textStyle ??
                                        TextStyle(
                                          color: _calculateContentColor(
                                              isSelected, isDisabled),
                                        ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );

    return content;
  }
}
