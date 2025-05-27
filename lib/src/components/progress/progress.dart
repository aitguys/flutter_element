import 'package:flutter/material.dart';

/// Defines the available types of progress indicators.
enum EProgressType {
  /// A horizontal line progress bar
  line,

  /// A circular progress indicator
  circle,
}

/// Defines the available statuses for the progress indicator.
enum EProgressStatus {
  /// Normal progress state (blue)
  normal,

  /// Success state (green)
  success,

  /// Error state (red)
  exception,

  /// Warning state (orange)
  warning,
}

/// A progress component that follows Element Plus design guidelines.
///
/// The [EProgress] widget provides a customizable progress indicator with features like:
/// - Line and circle types
/// - Different statuses (normal, success, exception, warning)
/// - Custom colors
/// - Percentage text display
/// - Custom stroke width
/// - Custom dimensions
///
/// Example:
/// ```dart
/// // Line progress
/// EProgress(
///   percentage: 75,
///   type: EProgressType.line,
///   status: EProgressStatus.success,
///   showText: true,
/// )
///
/// // Circle progress
/// EProgress(
///   percentage: 50,
///   type: EProgressType.circle,
///   width: 120,
///   strokeWidth: 8,
///   color: Colors.purple,
/// )
/// ```
class EProgress extends StatelessWidget {
  /// The current progress percentage (0-100).
  final double percentage;

  /// The type of progress indicator to display.
  /// Default is [EProgressType.line].
  final EProgressType type;

  /// The width of the progress bar or circle stroke.
  /// Default is 6.
  final double strokeWidth;

  /// The width of the progress component.
  /// For line type, this is the total width.
  /// For circle type, this is both width and height.
  /// Default is 126.
  final double width;

  /// The status of the progress indicator.
  /// This affects the color of the progress bar.
  /// Default is [EProgressStatus.normal].
  final EProgressStatus status;

  /// A custom color for the progress indicator.
  /// If provided, this overrides the color determined by [status].
  final Color? color;

  /// Whether to show the percentage text.
  /// Default is true.
  final bool showText;

  /// Custom text to display instead of the percentage.
  /// If not provided, the percentage will be shown.
  final String? text;

  const EProgress({
    super.key,
    required this.percentage,
    this.type = EProgressType.line,
    this.strokeWidth = 6,
    this.width = 126,
    this.status = EProgressStatus.normal,
    this.color,
    this.showText = true,
    this.text,
  });

  /// Gets the appropriate color for the progress indicator based on status or custom color.
  Color get _progressColor {
    if (color != null) return color!;
    switch (status) {
      case EProgressStatus.success:
        return Colors.green;
      case EProgressStatus.exception:
        return Colors.red;
      case EProgressStatus.warning:
        return Colors.orange;
      case EProgressStatus.normal:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (type == EProgressType.circle) {
      return SizedBox(
        width: width,
        height: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: width,
              height: width,
              child: CircularProgressIndicator(
                value: percentage / 100,
                strokeWidth: strokeWidth,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(_progressColor),
              ),
            ),
            if (showText)
              Text(
                text ?? '${percentage.toStringAsFixed(0)}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
          ],
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: strokeWidth,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(strokeWidth / 2),
                ),
              ),
              Container(
                height: strokeWidth,
                width: width * (percentage / 100),
                decoration: BoxDecoration(
                  color: _progressColor,
                  borderRadius: BorderRadius.circular(strokeWidth / 2),
                ),
              ),
            ],
          ),
          if (showText)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                text ?? '${percentage.toStringAsFixed(0)}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      );
    }
  }
}
