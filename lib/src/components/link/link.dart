import 'package:flutter/material.dart';
import 'link_style.dart';
import 'color_caculate.dart';

/// A link component that follows Element Plus design guidelines.
/// 
/// The [ELink] widget provides a customizable link with features like:
/// - Different types (default, primary, success, warning, danger)
/// - Disabled state
/// - Optional underline
/// - Icon support
/// - Click handling
/// - URL navigation
/// 
/// Example:
/// ```dart
/// ELink(
///   text: 'Click me',
///   type: ELinkType.primary,
///   icon: Icons.link,
///   onPressed: () {
///     print('Link clicked');
///   },
/// )
/// 
/// // With URL
/// ELink(
///   text: 'Visit website',
///   href: 'https://example.com',
///   target: '_blank',
/// )
/// ```
class ELink extends StatelessWidget {
  /// The text to display in the link.
  final String text;

  /// The type of the link, which determines its color scheme.
  /// Default is [ELinkType.defaultType].
  final ELinkType type;

  /// Whether the link is disabled.
  /// When true, the link cannot be clicked and shows a disabled style.
  final bool disabled;

  /// Whether to show an underline for the link.
  /// Default is true.
  final bool underline;

  /// An optional icon to display before the link text.
  final IconData? icon;

  /// A callback function when the link is clicked.
  /// This is called before any href navigation.
  final VoidCallback? onPressed;

  /// The URL to navigate to when the link is clicked.
  /// If provided, the link will act as a hyperlink.
  final String? href;

  /// The target attribute for the href link.
  /// Common values are '_blank' for opening in a new tab/window.
  final String? target;

  const ELink({
    super.key,
    required this.text,
    this.type = ELinkType.defaultType,
    this.disabled = false,
    this.underline = true,
    this.icon,
    this.onPressed,
    this.href,
    this.target,
  });

  @override
  Widget build(BuildContext context) {
    final color = getLinkColor(type);
    final textStyle = TextStyle(
      color: disabled
          ? calculateForegroundColor(color, isDisabled: true)
          : calculateForegroundColor(color),
    );

    Widget linkContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 16,
            color: disabled
                ? calculateForegroundColor(color, isDisabled: true)
                : calculateForegroundColor(color),
          ),
          const SizedBox(width: 8),
        ],
        Text(text, style: textStyle),
      ],
    );

    if (underline) {
      linkContent = MouseRegion(
        cursor:
            disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: disabled
                    ? calculateForegroundColor(color, isDisabled: true)
                    : calculateForegroundColor(color),
                width: 1,
              ),
            ),
          ),
          child: linkContent,
        ),
      );
    }

    if (href != null) {
      return InkWell(
        onTap: disabled
            ? null
            : () {
                // Handle href navigation
                if (onPressed != null) {
                  onPressed!();
                }
              },
        child: linkContent,
      );
    }

    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: linkContent,
    );
  }
}
