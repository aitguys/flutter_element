import 'package:flutter/material.dart';
import '../../theme/index.dart';
import 'package:url_launcher/url_launcher.dart';

class ELink extends StatelessWidget {
  /// The text to display in the link.
  final String text;

  /// The type of the link, which determines its color scheme.
  /// Default is [ELinkType.defaultType].
  final EColorType colorType;
  final ESizeItem size;

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

  /// The size of the link text.
  /// Default is [ESizeItem.medium].

  final double? customFontSize;
  final double? customIconSize;
  final ValueChanged<bool>? onHover;

  const ELink({
    super.key,
    required this.text,
    this.colorType = EColorType.default_,
    this.size = ESizeItem.medium,
    this.customFontSize,
    this.customIconSize,
    this.disabled = false,
    this.underline = true,
    this.icon,
    this.href,
    this.target,
    this.onHover,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final basicColor = getColorByType(type: colorType);
    final contentColor = calculateContentColor(basicColor,
        isDisabled: disabled, isLink: true, isPlain: true);
    final customFontSize = ElememtSize(size: size)
        .getInputFontSize(customFontSize: this.customFontSize);
    final customIconSize = ElememtSize(size: size)
        .getIconSize(customIconSize: this.customIconSize);
    Widget linkContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: customIconSize,
            color: contentColor,
          ),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            color: contentColor,
            fontSize: customFontSize,
          ),
        ),
      ],
    );

    linkContent = MouseRegion(
      cursor:
          disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      onEnter: (_) => onHover?.call(true),
      onExit: (_) => onHover?.call(false),
      child: underline
          ? Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: contentColor,
                    width: 1,
                  ),
                ),
              ),
              child: linkContent,
            )
          : linkContent,
    );

    if (href != null) {
      return InkWell(
        onTap: disabled
            ? null
            : () async {
                try {
                  final url = Uri.parse(href!);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                      mode: target == '_blank'
                          ? LaunchMode.externalApplication
                          : LaunchMode.platformDefault,
                    );
                  }
                } catch (e) {
                  debugPrint('无法打开URL: $e');
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
