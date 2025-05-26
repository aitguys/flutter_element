import 'package:flutter/material.dart';

enum EResultStatus { success, warning, info, error }

class EResult extends StatelessWidget {
  final EResultStatus status;
  final String title;
  final String? subTitle;
  final Widget? icon;
  final Widget? extra;

  const EResult({
    super.key,
    required this.status,
    required this.title,
    this.subTitle,
    this.icon,
    this.extra,
  });

  IconData get _defaultIcon {
    switch (status) {
      case EResultStatus.success:
        return Icons.check_circle_outline;
      case EResultStatus.warning:
        return Icons.warning_amber_rounded;
      case EResultStatus.info:
        return Icons.info_outline;
      case EResultStatus.error:
        return Icons.error_outline;
    }
  }

  Color get _color {
    switch (status) {
      case EResultStatus.success:
        return Colors.green;
      case EResultStatus.warning:
        return Colors.orange;
      case EResultStatus.info:
        return Colors.blue;
      case EResultStatus.error:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ?? Icon(_defaultIcon, color: _color, size: 64),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: _color),
              textAlign: TextAlign.center,
            ),
            if (subTitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subTitle!,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
            if (extra != null) ...[
              const SizedBox(height: 24),
              extra!,
            ],
          ],
        ),
      ),
    );
  }
}
