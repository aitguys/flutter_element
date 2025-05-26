import 'package:flutter/material.dart';
import 'dart:math' as math;

class WatermarkPainter extends CustomPainter {
  final String content;
  final double rotate;
  final Color color;
  final double fontSize;
  final double gap;
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

class Watermark extends StatelessWidget {
  final String content;
  final Widget child;
  final double rotate;
  final Color color;
  final double fontSize;
  final double gap;
  final double opacity;
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
