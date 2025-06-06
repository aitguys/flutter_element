import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

/// A slider component that allows users to select a value within a range.
/// It follows Element Plus design guidelines and provides features like:
/// - Customizable range (min/max)
/// - Step increments
/// - Tooltip display
/// - Input box for direct value entry
/// - Stop marks at step points
/// - Vertical orientation
/// - Disabled state
/// - Range selection (two thumbs)
///
/// Example:
/// ```dart
/// ESlider(
///   value: 50,
///   min: 0,
///   max: 100,
///   step: 1,
///   showInput: true,
///   showTooltip: true,
///   onChange: (value) {
///     print('Slider value: $value');
///   },
/// )
/// ```
class ESlider extends StatefulWidget {
  /// The current value of the slider.
  /// For range slider, use [startValue] and [endValue] instead.
  final double? value;

  /// The start value for range slider.
  final double? startValue;

  /// The end value for range slider.
  final double? endValue;

  /// The minimum value of the slider.
  /// Default is 0.
  final double min;

  /// The maximum value of the slider.
  /// Default is 100.
  final double max;

  /// The step increment of the slider.
  /// Default is 1.
  final double step;

  /// Whether the slider is disabled.
  /// When disabled, the slider cannot be interacted with.
  final bool disabled;

  /// Whether to show an input box for direct value entry.
  final bool showInput;

  /// Whether to show stop marks at step points.
  final bool showStops;

  /// Whether to show a tooltip with the current value.
  final bool showTooltip;

  /// Whether to enable range selection with two thumbs.
  final bool range;

  /// Whether to display the slider vertically.
  final bool vertical;

  /// The height of the slider when in vertical mode.
  final double? height;

  /// The size of the slider.
  /// Affects the track and thumb sizes.
  final ESizeItem size;

  /// Custom marks to show on the slider.
  /// Key is the value, value is the mark text.
  final Map<double, String>? marks;

  /// Custom tooltip format function.
  final String Function(double)? formatTooltip;

  /// Callback when the slider value changes.
  final Function(double)? onChange;

  /// Callback when the slider value is changing.
  final Function(double)? onInput;

  /// Callback when the slider value changes in range mode.
  final Function(double, double)? onRangeChange;

  /// The width of the slider.
  final double? width;

  const ESlider({
    super.key,
    this.value,
    this.startValue,
    this.endValue,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.disabled = false,
    this.showInput = false,
    this.showStops = false,
    this.showTooltip = true,
    this.range = false,
    this.vertical = false,
    this.height,
    this.size = ESizeItem.medium,
    this.marks,
    this.formatTooltip,
    this.onChange,
    this.onInput,
    this.onRangeChange,
    this.width,
  }) : assert(
          (range && startValue != null && endValue != null) ||
              (!range && value != null),
          'Must provide value for single slider or startValue/endValue for range slider',
        );

  @override
  State<ESlider> createState() => _ESliderState();
}

class _ESliderState extends State<ESlider> with SingleTickerProviderStateMixin {
  late double _value;
  late double _startValue;
  late double _endValue;
  bool _isDragging = false;
  bool _isStartDragging = false;
  bool _isEndDragging = false;
  bool _isHovering = false;
  bool _showTooltipValue = false;
  double _tooltipValue = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _dragStartValue = 0;
  final GlobalKey _sliderKey = GlobalKey();
  double _sliderLeft = 0;
  @override
  void initState() {
    super.initState();
    if (widget.range) {
      _startValue = widget.startValue!;
      _endValue = widget.endValue!;
    } else {
      _value = widget.value!;
    }
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSliderPosition();
    });
  }

  void _updateSliderPosition() {
    final RenderBox? box =
        _sliderKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      final position = box.localToGlobal(Offset.zero);
      setState(() {
        _sliderLeft = position.dx;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ESlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.range) {
      if (widget.startValue != oldWidget.startValue) {
        _startValue = widget.startValue!;
      }
      if (widget.endValue != oldWidget.endValue) {
        _endValue = widget.endValue!;
      }
    } else if (widget.value != oldWidget.value) {
      _value = widget.value!;
    }
  }

  //
  double get _sliderWidth => widget.width ?? double.infinity;
  double get _thumbSize => widget.size == ESizeItem.small ? 12 : 16;

  void _showTooltip(double value) {
    if (!widget.showTooltip) return;
    setState(() {
      _showTooltipValue = true;
      _tooltipValue = value;
    });
  }

  void _hideTooltip() {
    setState(() {
      _showTooltipValue = false;
    });
  }

  void _updateValueWithAnimation(double newValue, {bool isStart = false}) {
    if (widget.disabled) return;

    // Clamp and snap to step
    newValue = newValue.clamp(widget.min, widget.max);
    final steppedValue =
        ((newValue - widget.min) / widget.step).round() * widget.step +
            widget.min;

    if (widget.range) {
      if (isStart) {
        if (steppedValue <= _endValue) {
          setState(() => _startValue = steppedValue);
          widget.onInput?.call(_startValue);
        }
      } else {
        if (steppedValue >= _startValue) {
          setState(() => _endValue = steppedValue);
          widget.onInput?.call(_endValue);
        }
      }
    } else {
      setState(() => _value = steppedValue);
      widget.onInput?.call(_value);
    }
  }

  void _onDragStart(DragStartDetails details) {
    if (widget.disabled) return;
    _isDragging = true;

    if (widget.range) {
      final value = _getValueFromGlobalX(details.globalPosition.dx);
      _isStartDragging =
          (value - _startValue).abs() < (value - _endValue).abs();
      _dragStartValue = _isStartDragging ? _startValue : _endValue;
      _showTooltip(_dragStartValue);
    } else {
      _dragStartValue = _value;
      _showTooltip(_value);
    }
    _animationController.forward(from: 0);
    setState(() {});
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (widget.disabled) return;
    final newValue = _getValueFromGlobalX(details.globalPosition.dx);

    _updateValueWithAnimation(
      newValue,
      isStart: widget.range && _isStartDragging,
    );

    _showTooltip(
      widget.range ? (_isStartDragging ? _startValue : _endValue) : _value,
    );
  }

  double _getValueFromGlobalX(double globalX) {
    final relativeX = globalX - _sliderLeft;
    final percentage = (relativeX / _sliderWidth).clamp(0.0, 1.0);
    return widget.min + percentage * (widget.max - widget.min);
  }

  void _onDragEnd(DragEndDetails details) {
    _isDragging = false;
    _isStartDragging = false;
    _isEndDragging = false;
    _hideTooltip();
    _animationController.reverse();

    if (widget.range) {
      widget.onRangeChange?.call(_startValue, _endValue);
    } else {
      widget.onChange?.call(_value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final percentage = widget.range
        ? (_endValue - _startValue) / (widget.max - widget.min)
        : (_value - widget.min) / (widget.max - widget.min);

    final isDisabled = widget.disabled;
    final trackColor =
        isDisabled ? EBasicColors.borderGray : EBasicColors.borderGray;
    final activeColor =
        isDisabled ? EBasicColors.textGray : EColorTypes.primary;

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onHorizontalDragStart: _onDragStart,
              onHorizontalDragUpdate: _onDragUpdate,
              onHorizontalDragEnd: _onDragEnd,
              child: MouseRegion(
                onEnter: (_) {
                  if (!isDisabled) setState(() => _isHovering = true);
                },
                onExit: (_) {
                  if (!isDisabled) setState(() => _isHovering = false);
                },
                cursor: isDisabled
                    ? SystemMouseCursors.basic
                    : SystemMouseCursors.click,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return SizedBox(
                      key: _sliderKey,
                      width: _sliderWidth,
                      height: widget.vertical
                          ? (widget.height ?? 200)
                          : ElememtSize(size: widget.size)
                              .getSliderTrackHeight(),
                      child: child,
                    );
                  },
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    clipBehavior: Clip.none,
                    children: [
                      // Background track
                      Container(
                        height: ElememtSize(size: widget.size)
                            .getSliderTrackHeight(),
                        decoration: BoxDecoration(
                          color: trackColor,
                          borderRadius: BorderRadius.circular(
                            ElememtSize(size: widget.size)
                                    .getSliderTrackHeight() /
                                2,
                          ),
                        ),
                      ),
                      // Active track
                      if (widget.range)
                        Positioned(
                          left: _startValue /
                              widget.max *
                              (_sliderWidth - _thumbSize),
                          width: percentage * (_sliderWidth - _thumbSize),
                          child: Container(
                            height: ElememtSize(size: widget.size)
                                .getSliderTrackHeight(),
                            decoration: BoxDecoration(
                              color: activeColor,
                              borderRadius: BorderRadius.circular(
                                ElememtSize(size: widget.size)
                                        .getSliderTrackHeight() /
                                    2,
                              ),
                            ),
                          ),
                        )
                      else
                        FractionallySizedBox(
                          widthFactor: percentage,
                          child: Container(
                            height: ElememtSize(size: widget.size)
                                .getSliderTrackHeight(),
                            decoration: BoxDecoration(
                              color: activeColor,
                              borderRadius: BorderRadius.circular(
                                ElememtSize(size: widget.size)
                                        .getSliderTrackHeight() /
                                    2,
                              ),
                            ),
                          ),
                        ),
                      // Stop marks
                      if (widget.showStops)
                        ...List.generate(
                          ((widget.max - widget.min) / widget.step).floor(),
                          (index) {
                            final stopValue = widget.min + index * widget.step;
                            final stopPercentage = (stopValue - widget.min) /
                                (widget.max - widget.min);
                            return Positioned(
                              left:
                                  stopPercentage * (_sliderWidth - _thumbSize) -
                                      2,
                              child: Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: activeColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      // Thumbs
                      if (widget.range) ...[
                        _buildThumb(_startValue, true),
                        _buildThumb(_endValue, false),
                      ] else
                        _buildThumb(_value, false),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        if (widget.showInput)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: 60,
              child: TextField(
                controller: TextEditingController(
                  text: widget.range
                      ? '${_startValue.toStringAsFixed(0)}-${_endValue.toStringAsFixed(0)}'
                      : _value.toStringAsFixed(0),
                ),
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (value) {
                  if (widget.range) {
                    final values = value.split('-');
                    if (values.length == 2) {
                      final start = double.tryParse(values[0]);
                      final end = double.tryParse(values[1]);
                      if (start != null && end != null) {
                        setState(() {
                          _startValue = start.clamp(widget.min, widget.max);
                          _endValue = end.clamp(widget.min, widget.max);
                        });
                        widget.onRangeChange?.call(_startValue, _endValue);
                      }
                    }
                  } else {
                    final newValue = double.tryParse(value);
                    if (newValue != null) {
                      setState(() {
                        _value = newValue.clamp(widget.min, widget.max);
                      });
                      widget.onChange?.call(_value);
                    }
                  }
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildThumb(double value, bool isStart) {
    final percentage = (value - widget.min) / (widget.max - widget.min);
    final isDraggingThis = widget.range
        ? (isStart ? _isStartDragging : _isEndDragging)
        : _isDragging;
    final thumbBorderColor = widget.disabled
        ? EBasicColors.borderGray
        : (isDraggingThis || _isHovering
            ? EColorTypes.primary
            : EBasicColors.borderGray);
    final List<BoxShadow> thumbShadow = widget.disabled
        ? []
        : [
            BoxShadow(
              color: EColorTypes.primary.withValues(
                alpha: isDraggingThis || _isHovering ? 0.15 : 0.08,
              ),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ];

    return Positioned(
      left: percentage * (_sliderWidth - _thumbSize),
      child: MouseRegion(
        cursor: widget.disabled
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: _thumbSize,
              height: _thumbSize,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: thumbBorderColor,
                  width: 2,
                ),
                boxShadow: thumbShadow,
              ),
            ),
            if (_showTooltipValue && isDraggingThis)
              Positioned(
                bottom: _thumbSize + 8,
                left: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: EColorTypes.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    widget.formatTooltip?.call(_tooltipValue) ??
                        _tooltipValue.toStringAsFixed(0),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
