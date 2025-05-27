import 'package:flutter/material.dart';

/// The status of the result component.
/// 
/// This enum defines the different visual styles available for [EResult].
enum EResultStatus {
  /// Success status (green)
  success,
  /// Warning status (orange)
  warning,
  /// Info status (blue)
  info,
  /// Error status (red)
  error,
}

/// A result component that follows Element Plus design guidelines.
/// 
/// The [EResult] widget provides a feedback page for displaying the result
/// of an operation. It supports different status types, custom icons, and
/// additional content.
/// 
/// ## Example
/// 
/// ```dart
/// EResult(
///   status: EResultStatus.success,
///   title: 'Success',
///   subTitle: 'Your operation has been completed successfully',
///   extra: ElevatedButton(
///     onPressed: () {},
///     child: Text('Back to Home'),
///   ),
/// )
/// ```
class EResult extends StatelessWidget {
  /// The status of the result, which determines its visual style.
  /// This affects both the icon and colors used.
  final EResultStatus status;

  /// The main title text of the result.
  /// This is displayed prominently below the icon.
  final String title;

  /// Optional subtitle text to provide additional information.
  /// This is displayed below the title in a smaller font size.
  final String? subTitle;

  /// A custom icon to display in the result.
  /// If provided, this overrides the default icon for the status.
  final Widget? icon;

  /// Additional content to display below the result.
  /// This can be used to add buttons or other widgets.
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
