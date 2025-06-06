import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';
import 'dart:math' show pi, cos, sin;

/// Defines the available types of progress indicators.
enum EProgressType {
  /// A horizontal line progress bar
  line,

  /// A circular progress indicator
  circle,
}

/// Defines the available statuses for the progress indicator.

class EProgress extends StatefulWidget {
  /// The current progress percentage (0-100).
  final double percentage;

  /// The type of progress indicator to display.
  /// Default is [EProgressType.line].
  final EProgressType type;

  /// The width of the progress bar or circle stroke.
  /// Default is 6 for circle, 12 for line.
  final double? strokeWidth;

  /// The width of the progress component.
  /// For line type, this is the total width.
  /// For circle type, this is both width and height.
  /// Default is 126.
  final double? width;

  /// The status of the progress indicator.
  /// This affects the color of the progress bar.
  /// Default is [EColorType.primary].
  final EColorType? colorType;

  /// A custom color for the progress indicator.
  /// If provided, this overrides the color determined by [status].
  final Color? color;

  /// Whether to show the percentage text.
  /// Default is true.
  final bool showText;

  /// Custom text to display instead of the percentage.
  /// If not provided, the percentage will be shown.
  final String? text;
  final bool textInside;

  /// Custom widget builder that takes percentage as parameter
  /// and returns a custom widget to display
  final Widget Function(double percentage)? customBuilder;

  /// Whether to show indeterminate progress animation
  /// Default is false
  final bool indeterminate;

  /// Duration of the indeterminate animation in seconds
  /// Default is 2
  final double duration;

  /// Whether to show striped progress bar
  /// Default is false
  final bool striped;

  /// Whether to show flowing striped progress bar
  /// Default is false
  final bool stripedFlow;

  const EProgress({
    super.key,
    required this.percentage,
    this.type = EProgressType.line,
    this.strokeWidth,
    this.width,
    this.colorType,
    this.color = EColorTypes.primary,
    this.showText = true,
    this.text,
    this.textInside = false,
    this.customBuilder,
    this.indeterminate = false,
    this.duration = 2,
    this.striped = false,
    this.stripedFlow = false,
  });

  @override
  State<EProgress> createState() => _EProgressState();
}

class _EProgressState extends State<EProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: (widget.duration * 1000).round()),
      vsync: this,
    );

    _animation = Tween<double>(begin: -0.5, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    )..addListener(() {
        if (mounted) setState(() {});
      });

    if (widget.indeterminate || widget.stripedFlow) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(EProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.indeterminate != oldWidget.indeterminate ||
        widget.stripedFlow != oldWidget.stripedFlow) {
      if (widget.indeterminate || widget.stripedFlow) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
    if (widget.duration != oldWidget.duration) {
      _controller.duration =
          Duration(milliseconds: (widget.duration * 1000).round());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _getProgressText() {
    if (widget.customBuilder != null) {
      final customWidget = widget.customBuilder!(widget.percentage);
      if (widget.type == EProgressType.circle) {
        return Center(child: customWidget);
      }
      return customWidget;
    }

    if (widget.text != null) {
      if (widget.type == EProgressType.circle) {
        return Center(
          child: Text(
            widget.text!,
            style: TextStyle(
              fontSize: 14,
              color: widget.colorType != null
                  ? getColorByType(type: widget.colorType!)
                  : widget.color,
            ),
          ),
        );
      }
      return Text(
        widget.text!,
        style: TextStyle(
          fontSize: 14,
          color: widget.colorType != null
              ? getColorByType(type: widget.colorType!)
              : widget.color,
        ),
      );
    }

    if (widget.type == EProgressType.circle) {
      return Center(
        child: Text(
          '${widget.percentage.round()}%',
          style: TextStyle(
            fontSize: 14,
            color: widget.colorType != null
                ? getColorByType(type: widget.colorType!)
                : widget.color,
          ),
        ),
      );
    }
    return Text(
      '${widget.percentage.round()}%',
      style: TextStyle(
        fontSize: 14,
        color: widget.colorType != null
            ? getColorByType(type: widget.colorType!)
            : widget.color,
      ),
    );
  }

  Widget _buildIndeterminateProgress() {
    final progressColor = widget.colorType != null
        ? getColorByType(type: widget.colorType!)
        : widget.color;
    final circleWidth = widget.strokeWidth ??
        (widget.type == EProgressType.circle ? 6.0 : 12.0);

    if (widget.type == EProgressType.circle) {
      return CircularProgressIndicator(
        value: null,
        strokeWidth: circleWidth,
        backgroundColor: Colors.grey[200],
        valueColor: AlwaysStoppedAnimation(progressColor),
      );
    } else {
      return Stack(
        children: [
          // 背景条
          Container(
            height: circleWidth,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(circleWidth / 2),
            ),
          ),
          // 动画进度条
          ClipRRect(
            borderRadius: BorderRadius.circular(circleWidth / 2),
            child: SizedBox(
              height: circleWidth,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      // 第一段动画
                      Positioned(
                        left: -constraints.maxWidth +
                            (constraints.maxWidth * 3 * _animation.value),
                        child: Container(
                          width: constraints.maxWidth,
                          height: circleWidth,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                progressColor!.withValues(alpha: 0.1),
                                progressColor.withValues(alpha: 0.6),
                                progressColor,
                                progressColor.withValues(alpha: 0.6),
                                progressColor.withValues(alpha: 0.1),
                              ],
                              stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                            ),
                          ),
                        ),
                      ),
                      // 第二段动画，错开相位
                      Positioned(
                        left: -constraints.maxWidth +
                            (constraints.maxWidth *
                                3 *
                                (_animation.value + 0.5)),
                        child: Container(
                          width: constraints.maxWidth,
                          height: circleWidth,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                progressColor.withValues(alpha: 0.1),
                                progressColor.withValues(alpha: 0.6),
                                progressColor,
                                progressColor.withValues(alpha: 0.6),
                                progressColor.withValues(alpha: 0.1),
                              ],
                              stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildStripedProgress() {
    final progressColor = widget.colorType != null
        ? getColorByType(type: widget.colorType!)
        : widget.color;
    final circleWidth = widget.strokeWidth ??
        (widget.type == EProgressType.circle ? 6.0 : 12.0);

    if (widget.type == EProgressType.circle) {
      return CustomPaint(
        size: Size(widget.width ?? 126, widget.width ?? 126),
        painter: _CircleStripedPainter(
          progress: widget.percentage / 100,
          color: progressColor!,
          strokeWidth: circleWidth,
          striped: widget.striped,
          stripedFlow: widget.stripedFlow,
          animation: widget.stripedFlow ? _animation.value : 0,
        ),
      );
    } else {
      return LayoutBuilder(
        builder: (context, constraints) {
          return CustomPaint(
            size: Size(constraints.maxWidth, circleWidth),
            painter: _LineStripedPainter(
              progress: widget.percentage / 100,
              color: progressColor!,
              height: circleWidth,
              striped: widget.striped,
              stripedFlow: widget.stripedFlow,
              animation: widget.stripedFlow ? _animation.value : 0,
            ),
          );
        },
      );
    }
  }

  Widget _buildProgress() {
    if (widget.striped || widget.stripedFlow) {
      return _buildStripedProgress();
    }

    if (widget.indeterminate) {
      return _buildIndeterminateProgress();
    }

    final progressColor = widget.colorType != null
        ? getColorByType(type: widget.colorType!)
        : widget.color;
    final circleWidth = widget.strokeWidth ??
        (widget.type == EProgressType.circle ? 6.0 : 12.0);

    if (widget.type == EProgressType.circle) {
      return CircularProgressIndicator(
        value: widget.percentage / 100,
        strokeWidth: circleWidth,
        backgroundColor: Colors.grey[200],
        valueColor: AlwaysStoppedAnimation(progressColor),
      );
    } else {
      return LinearProgressIndicator(
        value: widget.percentage / 100,
        minHeight: circleWidth,
        backgroundColor: Colors.grey[200],
        valueColor: AlwaysStoppedAnimation(progressColor),
        borderRadius: BorderRadius.circular(circleWidth / 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == EProgressType.circle) {
      final progressWidth = widget.width ?? 126;
      return SizedBox(
        width: progressWidth,
        height: progressWidth,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: progressWidth,
                height: progressWidth,
                child: _buildProgress(),
              ),
              if (widget.showText) _getProgressText(),
            ],
          ),
        ),
      );
    } else {
      final progressWidth = widget.width ?? double.infinity;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: progressWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            (widget.strokeWidth ?? 12) / 2),
                        child: _buildProgress(),
                      ),
                      if (widget.showText && widget.textInside)
                        Positioned(
                          left: (widget.percentage / 100) *
                                  MediaQuery.of(context).size.width -
                              50,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: _getProgressText(),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                if (widget.showText && !widget.textInside) _getProgressText(),
              ],
            ),
          ),
        ],
      );
    }
  }
}

class _LineStripedPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double height;
  final bool striped;
  final bool stripedFlow;
  final double animation;

  _LineStripedPainter({
    required this.progress,
    required this.color,
    required this.height,
    required this.striped,
    required this.stripedFlow,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, height),
        Radius.circular(height / 2),
      ),
      paint,
    );

    if (progress > 0) {
      final progressPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      if (striped || stripedFlow) {
        final stripeWidth = height * 2;
        final stripeCount = (size.width / stripeWidth).ceil() + 1;
        final path = Path();

        for (var i = -1; i < stripeCount; i++) {
          final offset = stripedFlow ? animation * stripeWidth : 0.0;
          final x = i * stripeWidth + offset;
          path.moveTo(x, 0);
          path.lineTo(x + stripeWidth / 2, 0);
          path.lineTo(x, height);
          path.lineTo(x - stripeWidth / 2, height);
          path.close();
        }

        final progressPath = Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(0, 0, size.width * progress, height),
              Radius.circular(height / 2),
            ),
          );

        final finalPath = Path.combine(
          PathOperation.intersect,
          progressPath,
          path,
        );

        canvas.drawPath(finalPath, progressPaint);
      } else {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width * progress, height),
            Radius.circular(height / 2),
          ),
          progressPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_LineStripedPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.height != height ||
        oldDelegate.striped != striped ||
        oldDelegate.stripedFlow != stripedFlow ||
        oldDelegate.animation != animation;
  }
}

class _CircleStripedPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  final bool striped;
  final bool stripedFlow;
  final double animation;

  _CircleStripedPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    required this.striped,
    required this.stripedFlow,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw background
    final bgPaint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, bgPaint);

    if (progress > 0) {
      final progressPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      if (striped || stripedFlow) {
        final stripeWidth = strokeWidth * 2;
        final stripeCount = (2 * pi * radius / stripeWidth).ceil() + 1;
        final path = Path();

        for (var i = -1; i < stripeCount; i++) {
          final offset = stripedFlow ? animation * stripeWidth : 0.0;
          final angle = i * (stripeWidth / radius) + offset;
          path.moveTo(
            center.dx + radius * cos(angle),
            center.dy + radius * sin(angle),
          );
          path.lineTo(
            center.dx + radius * cos(angle + stripeWidth / (2 * radius)),
            center.dy + radius * sin(angle + stripeWidth / (2 * radius)),
          );
          path.lineTo(
            center.dx + (radius - strokeWidth) * cos(angle),
            center.dy + (radius - strokeWidth) * sin(angle),
          );
          path.lineTo(
            center.dx +
                (radius - strokeWidth) *
                    cos(angle - stripeWidth / (2 * radius)),
            center.dy +
                (radius - strokeWidth) *
                    sin(angle - stripeWidth / (2 * radius)),
          );
          path.close();
        }

        final progressPath = Path()
          ..arcTo(
            Rect.fromCircle(center: center, radius: radius),
            -pi / 2,
            2 * pi * progress,
            false,
          );

        final finalPath = Path.combine(
          PathOperation.intersect,
          progressPath,
          path,
        );

        canvas.drawPath(finalPath, progressPaint);
      } else {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          -pi / 2,
          2 * pi * progress,
          false,
          progressPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_CircleStripedPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.striped != striped ||
        oldDelegate.stripedFlow != stripedFlow ||
        oldDelegate.animation != animation;
  }
}
