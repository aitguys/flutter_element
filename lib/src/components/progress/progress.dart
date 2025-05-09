import 'package:flutter/material.dart';

enum EProgressType { line, circle }

enum EProgressStatus { normal, success, exception, warning }

class EProgress extends StatelessWidget {
  final double percentage;
  final EProgressType type;
  final double strokeWidth;
  final double width;
  final EProgressStatus status;
  final Color? color;
  final bool showText;
  final String? text;

  const EProgress({
    Key? key,
    required this.percentage,
    this.type = EProgressType.line,
    this.strokeWidth = 6,
    this.width = 126,
    this.status = EProgressStatus.normal,
    this.color,
    this.showText = true,
    this.text,
  }) : super(key: key);

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
      default:
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
