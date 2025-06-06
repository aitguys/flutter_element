import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

class ERate extends StatefulWidget {
  /// The current rating value.
  /// Default is 0.
  final double value;

  /// The maximum rating value.
  /// Default is 5.
  final double max;

  /// Whether the rate component is disabled.
  /// When disabled, the component cannot be interacted with.
  final bool disabled;

  /// Whether to allow half-star ratings.
  /// When true, users can select half stars by clicking on the left half of a star.
  final bool allowHalf;

  /// Whether to show text descriptions for each rating value.
  /// Requires [texts] to be provided.
  final bool showText;

  /// Whether to show the current score.
  /// The score can be formatted using [scoreTemplate].
  final bool showScore;

  /// Whether the rating can be cleared by clicking on the current value.
  final bool clearable;

  /// The size of the rate component.
  /// Affects the icon and font sizes.
  final ESizeItem size;
  // custom size
  final double? customSize;
  // customFontSize
  final double? customFontSize;

  /// The color type of the rate component.
  final EColorType colorType;

  /// The list of text descriptions for each rating value.
  /// Used when [showText] is true.
  final List<String>? texts;

  /// Template string for displaying the score.
  /// Use {value} as a placeholder for the current rating.
  /// Example: 'Score: {value}'
  final String? scoreTemplate;

  /// The list of colors to use for different rating ranges.
  /// If provided, colors will be used based on the rating value:
  /// - First color: 0-2 stars
  /// - Second color: 2-4 stars
  /// - Third color: 4-5 stars
  /// If only one color is provided, it will be used for all stars.
  /// If not provided, the primary theme color will be used.
  final List<Color>? colors;

  /// Callback function when the rating value changes.
  /// Called with the new rating value.
  final ValueChanged<double>? onChanged;

  const ERate({
    super.key,
    this.value = 0,
    this.max = 5,
    this.disabled = false,
    this.allowHalf = false,
    this.showText = false,
    this.showScore = false,
    this.clearable = false,
    this.size = ESizeItem.medium,
    this.colorType = EColorType.primary,
    this.texts,
    this.scoreTemplate,
    this.colors,
    this.onChanged,
    this.customSize,
    this.customFontSize,
  });

  @override
  State<ERate> createState() => _ERateState();
}

class _ERateState extends State<ERate> {
  double _value = 0;
  double _hoverValue = 0;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(ERate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _value = widget.value;
    }
  }

  Color _getColor(double value) {
    if (widget.colors == null || widget.colors!.isEmpty) {
      return getColorByType(type: widget.colorType);
    }
    if (widget.colors!.length == 1) {
      return widget.colors![0];
    }

    final max = widget.max;
    final firstThreshold = max * 0.4;
    final secondThreshold = max * 0.8;

    if (value <= firstThreshold) {
      return widget.colors![0];
    } else if (value <= secondThreshold) {
      return widget.colors![1];
    } else {
      return widget.colors![2];
    }
  }

  String? _getText(double value) {
    if (!widget.showText || widget.texts == null) return null;
    final index = (value - 1).floor();
    if (index < 0 || index >= widget.texts!.length) return null;
    return widget.texts![index];
  }

  String _getScoreText(double value) {
    if (!widget.showScore) return '';
    if (widget.scoreTemplate != null) {
      return widget.scoreTemplate!.replaceAll('{value}', value.toString());
    }
    return value.toString();
  }

  void _handleTap(double value, TapDownDetails details) {
    if (widget.disabled) return;
    if (widget.clearable && _value == value) {
      value = 0;
    }
    if (widget.allowHalf) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final localPosition = box.globalToLocal(details.globalPosition);
      final starWidth = ElememtSize(size: widget.size)
              .getIconSize(customIconSize: widget.customSize) +
          8;
      final offset = localPosition.dx % starWidth;
      value = offset < starWidth / 2 ? value - 0.5 : value;
    }
    setState(() {
      _value = value;
      _hoverValue = value;
    });
    widget.onChanged?.call(value);
  }

  void _handleHover(double value, PointerEnterEvent event) {
    if (widget.disabled) return;
    if (widget.allowHalf) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final localPosition = box.globalToLocal(event.position);
      final starWidth = ElememtSize(size: widget.size)
              .getIconSize(customIconSize: widget.customSize) +
          8;
      final offset = localPosition.dx % starWidth;
      value = offset < starWidth / 2 ? value - 0.5 : value;
    }
    setState(() {
      _hoverValue = value;
      _isHovered = true;
    });
  }

  void _handleExit() {
    if (widget.disabled) return;
    setState(() {
      _hoverValue = _value;
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayValue = _isHovered ? _hoverValue : _value;
    final color = _getColor(displayValue);
    final text = _getText(displayValue);
    final scoreText = _getScoreText(displayValue);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          onExit: (_) => _handleExit(),
          cursor:
              widget.disabled ? MouseCursor.defer : SystemMouseCursors.click,
          child: Row(
            children: List.generate(
              widget.max.toInt(),
              (index) {
                final value = index + 1.0;
                final isHalf = widget.allowHalf && displayValue == value - 0.5;
                final isFull = displayValue >= value;

                return MouseRegion(
                  onEnter: (event) => _handleHover(value, event),
                  cursor: widget.disabled
                      ? MouseCursor.defer
                      : SystemMouseCursors.click,
                  child: GestureDetector(
                    onTapDown: (details) => _handleTap(value, details),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        isFull
                            ? Icons.star
                            : isHalf
                                ? Icons.star_half
                                : Icons.star_border,
                        size: ElememtSize(size: widget.size)
                            .getIconSize(customIconSize: widget.customSize),
                        color: widget.disabled
                            ? EBasicColors.borderGray
                            : isFull || isHalf
                                ? color
                                : EBasicColors.borderGray,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (text != null || scoreText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              text ?? scoreText,
              style: TextStyle(
                fontSize: ElememtSize(size: widget.size)
                    .getInputFontSize(customFontSize: widget.customFontSize),
                color: widget.disabled
                    ? EBasicColors.textGray
                    : text != null
                        ? color
                        : EColorTypes.primary,
              ),
            ),
          ),
      ],
    );
  }
}
