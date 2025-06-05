import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

/// Defines the available types of progress indicators.
enum EProgressType {
  /// A horizontal line progress bar
  line,

  /// A circular progress indicator
  circle,
}

/// Defines the available statuses for the progress indicator.

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
  final double? width;

  /// The status of the progress indicator.
  /// This affects the color of the progress bar.
  /// Default is [EColorType.primary].
  final EColorType colorType;

  /// A custom color for the progress indicator.
  /// If provided, this overrides the color determined by [status].
  final Color? customColor;

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
    this.width,
    this.colorType = EColorType.primary,
    this.customColor,
    this.showText = true,
    this.text,
  });

  /// Gets the appropriate color for the progress indicator based on status or custom color.

  @override
  Widget build(BuildContext context) {
    final double progressWidth = width ?? 126;
    if (type == EProgressType.circle) {
      return SizedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: progressWidth,
              height: progressWidth,
              child: CircularProgressIndicator(
                value: percentage / 100,
                strokeWidth: strokeWidth,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(
                    getColorByType(type: colorType, customColor: customColor)),
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
              LinearProgressIndicator(
                value: percentage / 100,
                minHeight: strokeWidth,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(
                    getColorByType(type: colorType, customColor: customColor)),
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
