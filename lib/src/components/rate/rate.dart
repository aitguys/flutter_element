import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_element/src/theme/index.dart';

enum ERateSize { small, medium, large }

class ERate extends StatefulWidget {
  final double value;
  final double max;
  final bool disabled;
  final bool allowHalf;
  final bool showText;
  final bool showScore;
  final bool clearable;
  final ERateSize size;
  final List<String>? texts;
  final String? scoreTemplate;
  final List<Color>? colors;
  final ValueChanged<double>? onChanged;

  const ERate({
    Key? key,
    this.value = 0,
    this.max = 5,
    this.disabled = false,
    this.allowHalf = false,
    this.showText = false,
    this.showScore = false,
    this.clearable = false,
    this.size = ERateSize.medium,
    this.texts,
    this.scoreTemplate,
    this.colors,
    this.onChanged,
  }) : super(key: key);

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

  double get _iconSize {
    switch (widget.size) {
      case ERateSize.small:
        return 16;
      case ERateSize.large:
        return 24;
      case ERateSize.medium:
      default:
        return 20;
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case ERateSize.small:
        return 12;
      case ERateSize.large:
        return 16;
      case ERateSize.medium:
      default:
        return 14;
    }
  }

  Color _getColor(double value) {
    if (widget.colors == null || widget.colors!.isEmpty) {
      return EColors.Primary;
    }
    if (widget.colors!.length == 1) {
      return widget.colors![0];
    }
    if (value <= 2) {
      return widget.colors![0];
    } else if (value <= 4) {
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
      final starWidth = _iconSize + 8;
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
      final starWidth = _iconSize + 8;
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
          child: Row(
            children: List.generate(
              widget.max.toInt(),
              (index) {
                final value = index + 1.0;
                final isHalf = widget.allowHalf && displayValue == value - 0.5;
                final isFull = displayValue >= value;

                return MouseRegion(
                  onEnter: (event) => _handleHover(value, event),
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
                        size: _iconSize,
                        color: widget.disabled
                            ? EColors.BorderGray
                            : isFull || isHalf
                                ? color
                                : EColors.BorderGray,
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
                fontSize: _fontSize,
                color: widget.disabled
                    ? EColors.TextGray
                    : text != null
                        ? color
                        : EColors.Primary,
              ),
            ),
          ),
      ],
    );
  }
}
