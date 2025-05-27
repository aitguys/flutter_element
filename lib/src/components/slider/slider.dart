import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

/// Defines the available sizes for the slider component.
enum ESliderSize {
  /// Small size with smaller track and thumb
  small,

  /// Medium size (default)
  medium,

  /// Large size with larger track and thumb
  large,
}

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
  final double value;

  /// The minimum value of the slider.
  /// Default is 0.
  final double? min;

  /// The maximum value of the slider.
  /// Default is 100.
  final double? max;

  /// The step increment of the slider.
  /// Default is 1.
  final double? step;

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
  final ESliderSize size;

  /// Custom CSS class for the tooltip.
  final String? tooltipClass;

  /// The placement of the tooltip relative to the slider.
  final String? placement;

  /// Callback function when the slider value changes.
  /// This is called when the user finishes dragging the slider.
  final Function(double)? onChange;

  /// Callback function when the slider value is being changed.
  /// This is called continuously while the user is dragging the slider.
  final Function(double)? onInput;

  /// Custom function to format the tooltip text.
  /// If not provided, the value is displayed as an integer.
  final String Function(double)? formatTooltip;

  const ESlider({
    super.key,
    required this.value,
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
    this.size = ESliderSize.medium,
    this.tooltipClass,
    this.placement,
    this.onChange,
    this.onInput,
    this.formatTooltip,
  });

  @override
  State<ESlider> createState() => _ESliderState();
}

class _ESliderState extends State<ESlider> {
  late double _value;
  bool _isDragging = false;
  bool _isHover = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(ESlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _value = widget.value;
    }
  }

  double get _sliderHeight => 32;
  double get _trackHeight => 4;
  double get _sliderWidth => widget.vertical ? 4 : 300;
  double get _thumbSize => 16;

  void _showTooltip(double value) {
    if (!widget.showTooltip || _overlayEntry != null) return;
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, -30),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: EColorTypes.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                widget.formatTooltip?.call(value) ?? value.toStringAsFixed(0),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _updateValue(double newValue) {
    if (widget.disabled) return;
    final step = widget.step ?? 1;
    final min = widget.min ?? 0;
    final max = widget.max ?? 100;
    newValue = newValue.clamp(min, max);
    newValue = (newValue / step).round() * step;
    setState(() {
      _value = newValue;
    });
    widget.onInput?.call(newValue);
  }

  void _onDragEnd() {
    _isDragging = false;
    _hideTooltip();
    widget.onChange?.call(_value);
  }

  @override
  Widget build(BuildContext context) {
    final min = widget.min ?? 0;
    final max = widget.max ?? 100;
    final percentage = (_value - min) / (max - min);
    final isDisabled = widget.disabled;
    final trackColor =
        isDisabled ? EBasicColors.borderGray : EBasicColors.borderGray;
    final activeColor =
        isDisabled ? EBasicColors.textGray : EColorTypes.primary;
    final thumbBorderColor = isDisabled
        ? EBasicColors.borderGray
        : (_isDragging || _isHover
            ? EColorTypes.primary
            : EBasicColors.borderGray);
    final thumbShadow = isDisabled
        ? []
        : [
            BoxShadow(
              color: EColorTypes.primary
                  .withValues(alpha: _isDragging || _isHover ? 0.15 : 0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ];
    // thumb定位，防止超出轨道
    final thumbLeft = (_sliderWidth - _thumbSize) * percentage;
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          if (isDisabled) return;
          _isDragging = true;
          _showTooltip(_value);
          setState(() {});
        },
        onHorizontalDragUpdate: (details) {
          if (isDisabled) return;
          final RenderBox box = context.findRenderObject() as RenderBox;
          final localPosition = box.globalToLocal(details.globalPosition);
          final newValue =
              min + (localPosition.dx / box.size.width) * (max - min);
          _updateValue(newValue);
        },
        onHorizontalDragEnd: (_) {
          _onDragEnd();
          setState(() {});
        },
        child: MouseRegion(
          onEnter: (_) {
            if (!isDisabled) setState(() => _isHover = true);
          },
          onExit: (_) {
            if (!isDisabled) setState(() => _isHover = false);
          },
          child: Container(
            width: _sliderWidth,
            height: widget.vertical ? (widget.height ?? 200) : _sliderHeight,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // 轨道
                Container(
                  height: _trackHeight,
                  decoration: BoxDecoration(
                    color: trackColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // 已选轨道
                FractionallySizedBox(
                  widthFactor: percentage,
                  child: Container(
                    height: _trackHeight,
                    decoration: BoxDecoration(
                      color: activeColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // 滑块
                Positioned(
                  left: thumbLeft,
                  child: Container(
                    width: _thumbSize,
                    height: _thumbSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: thumbBorderColor,
                        width: 2,
                      ),
                      boxShadow: thumbShadow.isEmpty
                          ? null
                          : List<BoxShadow>.from(thumbShadow),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hideTooltip();
    super.dispose();
  }
}
