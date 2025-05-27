import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A custom painter that draws a watermark pattern on a canvas.
/// The watermark consists of repeated text with customizable rotation, color,
/// size, spacing, and opacity.
class WatermarkPainter extends CustomPainter {
  /// The text content to display as watermark.
  final String content;

  /// The rotation angle of the watermark text in degrees.
  /// Default is -45 degrees.
  final double rotate;

  /// The color of the watermark text.
  /// Default is black.
  final Color color;

  /// The font size of the watermark text.
  /// Default is 14.
  final double fontSize;

  /// The gap between watermark text elements.
  /// Default is 100.
  final double gap;

  /// The opacity of the watermark text.
  /// Default is 0.15.
  final double opacity;

  WatermarkPainter({
    required this.content,
    this.rotate = -45,
    this.color = Colors.black,
    this.fontSize = 14,
    this.gap = 100,
    this.opacity = 0.15,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.fill;
    final textPainter = TextPainter(
      text: TextSpan(
        text: content,
        style: TextStyle(
          color: color.withValues(alpha: opacity),
          fontSize: fontSize,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final textWidth = textPainter.width;
    final textHeight = textPainter.height;

    final columns = (size.width / (textWidth + gap)).ceil();
    final rows = (size.height / (textHeight + gap)).ceil();

    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < columns; j++) {
        canvas.save();
        final x = j * (textWidth + gap);
        final y = i * (textHeight + gap);
        canvas.translate(x + textWidth / 2, y + textHeight / 2);
        canvas.rotate(rotate * math.pi / 180);
        canvas.translate(-textWidth / 2, -textHeight / 2);
        textPainter.paint(canvas, Offset.zero);
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant WatermarkPainter oldDelegate) {
    return oldDelegate.content != content ||
        oldDelegate.rotate != rotate ||
        oldDelegate.color != color ||
        oldDelegate.fontSize != fontSize ||
        oldDelegate.gap != gap ||
        oldDelegate.opacity != opacity;
  }
}

/// A widget that adds a watermark overlay to its child widget.
/// The watermark is created by repeating text with customizable properties
/// like rotation, color, size, spacing, and opacity.
///
/// Example:
/// ```dart
/// Watermark(
///   content: 'Confidential',
///   child: YourWidget(),
///   rotate: -45,
///   color: Colors.black,
///   fontSize: 14,
///   gap: 100,
///   opacity: 0.15,
///   zIndex: false,
/// )
/// ```
class Watermark extends StatelessWidget {
  /// The text content to display as watermark.
  final String content;

  /// The child widget to display with the watermark overlay.
  final Widget child;

  /// The rotation angle of the watermark text in degrees.
  /// Default is -45 degrees.
  final double rotate;

  /// The color of the watermark text.
  /// Default is black.
  final Color color;

  /// The font size of the watermark text.
  /// Default is 14.
  final double fontSize;

  /// The gap between watermark text elements.
  /// Default is 100.
  final double gap;

  /// The opacity of the watermark text.
  /// Default is 0.15.
  final double opacity;

  /// Whether to display the watermark above the child widget.
  /// If false, the watermark will be displayed below the child.
  /// Default is false.
  final bool zIndex;

  const Watermark({
    super.key,
    required this.content,
    required this.child,
    this.rotate = -45,
    this.color = Colors.black,
    this.fontSize = 14,
    this.gap = 100,
    this.opacity = 0.15,
    this.zIndex = false,
  });

  @override
  Widget build(BuildContext context) {
    final watermark = CustomPaint(
      painter: WatermarkPainter(
        content: content,
        rotate: rotate,
        color: color,
        fontSize: fontSize,
        gap: gap,
        opacity: opacity,
      ),
      child: Container(),
    );

    return Stack(
      children: zIndex
          ? [
              child,
              Positioned.fill(child: watermark),
            ]
          : [
              Positioned.fill(child: watermark),
              child,
            ],
    );
  }
}
