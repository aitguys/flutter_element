import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

/// The position of the alert when displayed as an overlay.
enum EAlertPosition {
  /// Position the alert on the left side.
  left,

  /// Position the alert in the center.
  center,

  /// Position the alert on the right side.
  right,
}

/// An alert component that follows Element Plus design guidelines.
///
/// The [EAlert] widget provides a customizable alert message with various
/// types, themes, and features like closable alerts and custom icons.
///
/// ## Example
///
/// ```dart
/// EAlert(
///   title: 'Success',
///   description: 'Operation completed successfully',
///   type: EColorType.success,
///   closable: true,
///   onClose: () => print('Alert closed'),
///   width: 320,
/// )
/// ```
class EAlert extends StatefulWidget {
  /// The main title text of the alert.
  ///
  /// This is the primary message displayed in the alert.
  final String title;

  /// Optional description text to provide additional information.
  ///
  /// This is displayed below the title in a smaller font size.
  final String? description;

  /// The type of alert, which determines its color scheme.
  ///
  /// Defaults to [EColorType.info].
  final EColorType type;

  /// A custom color to use for the alert.
  ///
  /// If provided, this overrides the color determined by [type].
  final Color? customColor;

  /// Whether the alert can be closed by the user.
  ///
  /// When true, a close button will be shown in the alert.
  /// Defaults to true.
  final bool closable;

  /// Whether to show the default icon for the alert type.
  ///
  /// When true, an icon corresponding to the alert type will be shown.
  /// Defaults to true.
  final bool showIcon;

  /// A custom icon to display in the alert.
  ///
  /// If provided, this overrides the default icon for the alert type.
  final IconData? icon;

  /// Callback function when the alert is closed.
  ///
  /// This is called when the user clicks the close button.
  final VoidCallback? onClose;

  /// Whether to center the alert content.
  ///
  /// When true, the title and description will be centered.
  /// Defaults to false.
  final bool center;

  /// A custom widget to use as the close button.
  ///
  /// If provided, this overrides the default close button.
  final Widget? closeButton;

  /// Custom padding for the alert content.
  ///
  /// If not provided, a default padding of 12 pixels on all sides is used.
  final EdgeInsets? padding;

  /// The theme of the alert.
  ///
  /// This determines whether the alert uses a light or dark color scheme.
  /// Defaults to [EThemeType.dark].
  final EThemeType theme;

  /// The width of the alert.
  ///
  /// If provided, sets the width of the alert container.
  final double? width;

  /// The position of the alert when displayed as an overlay.
  ///
  /// This determines whether the alert appears on the left, center, or right
  /// of the screen. Defaults to [EAlertPosition.center].
  final EAlertPosition position;

  /// Creates an [EAlert] widget.
  ///
  /// The [title] argument is required.
  const EAlert({
    super.key,
    required this.title,
    this.description,
    this.type = EColorType.info,
    this.customColor,
    this.closable = true,
    this.showIcon = true,
    this.icon,
    this.onClose,
    this.center = false,
    this.closeButton,
    this.padding,
    this.theme = EThemeType.dark,
    this.width,
    this.position = EAlertPosition.center,
  });

  @override
  State<EAlert> createState() => _EAlertState();
}

class _EAlertState extends State<EAlert> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _close() {
    setState(() => _isVisible = false);
    _controller.forward().then((_) => widget.onClose?.call());
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    Widget alertContent = Container(
      width: widget.width,
      padding: widget.padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: getBackGroundColorByTypeAndTheme(
            type: widget.type,
            theme: widget.theme,
            customColor: widget.customColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.showIcon) ...[
            Padding(
              padding: EdgeInsets.only(top: widget.description != null ? 4 : 0),
              child: Icon(
                getDefaultIconByType(widget.type, customIcon: widget.icon),
                color: getDefaultContentColorByTypeAndTheme(
                    type: widget.type,
                    theme: widget.theme,
                    customColor: widget.customColor),
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: widget.center
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: getDefaultContentColorByTypeAndTheme(
                        type: widget.type,
                        theme: widget.theme,
                        customColor: widget.customColor),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (widget.description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    widget.description!,
                    style: TextStyle(
                      color: getDefaultContentColorByTypeAndTheme(
                          type: widget.type,
                          theme: widget.theme,
                          customColor: widget.customColor),
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (widget.closable) ...[
            const SizedBox(width: 8),
            widget.closeButton != null
                ? MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _close,
                      child: widget.closeButton,
                    ))
                : InkWell(
                    onTap: _close,
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: getDefaultContentColorByTypeAndTheme(
                          type: widget.type,
                          theme: widget.theme,
                          customColor: widget.customColor),
                    ),
                  ),
          ],
        ],
      ),
    );

    return FadeTransition(
      opacity: _animation,
      child: alertContent,
    );
  }
}

/// Shows an alert dialog that overlays the current screen.
///
/// This function creates a temporary overlay alert that can be used to
/// display important messages to the user. The alert can be configured
/// with various options like type, theme, and auto-close duration.
///
/// ## Example
///
/// ```dart
/// showAlert(
///   context: context,
///   title: 'Success',
///   description: 'Operation completed successfully',
///   type: EColorType.success,
///   autoCloseDuration: Duration(seconds: 3),
///   width: 320,
///   position: EAlertPosition.center,
/// )
/// ```
///
/// See also:
/// * [EAlert] for the underlying widget implementation
Future<void> showAlert({
  required BuildContext context,
  required String title,
  String? description,
  EColorType type = EColorType.info,
  Color? customColor,
  bool closable = true,
  bool showIcon = true,
  IconData? icon,
  VoidCallback? onClose,
  bool center = false,
  Widget? closeButton,
  EdgeInsets? padding,
  Duration? autoCloseDuration,
  EThemeType theme = EThemeType.dark,
  double? width,
  EAlertPosition position = EAlertPosition.center,
}) async {
  late final OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) {
      Widget positionedAlert;

      switch (position) {
        case EAlertPosition.left:
          positionedAlert = Positioned(
            top: 16,
            left: 16,
            child: Material(
              color: Colors.transparent,
              child: EAlert(
                title: title,
                description: description,
                type: type,
                customColor: customColor,
                closable: closable,
                showIcon: showIcon,
                icon: icon,
                onClose: () {
                  entry.remove();
                  onClose?.call();
                },
                center: center,
                closeButton: closeButton,
                padding: padding,
                theme: theme,
                width: width,
                position: position,
              ),
            ),
          );
          break;
        case EAlertPosition.center:
          positionedAlert = Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: EAlert(
                  title: title,
                  description: description,
                  type: type,
                  customColor: customColor,
                  closable: closable,
                  showIcon: showIcon,
                  icon: icon,
                  onClose: () {
                    entry.remove();
                    onClose?.call();
                  },
                  center: center,
                  closeButton: closeButton,
                  padding: padding,
                  theme: theme,
                  width: width,
                  position: position,
                ),
              ),
            ),
          );
          break;
        case EAlertPosition.right:
          positionedAlert = Positioned(
            top: 16,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: EAlert(
                title: title,
                description: description,
                type: type,
                customColor: customColor,
                closable: closable,
                showIcon: showIcon,
                icon: icon,
                onClose: () {
                  entry.remove();
                  onClose?.call();
                },
                center: center,
                closeButton: closeButton,
                padding: padding,
                theme: theme,
                width: width,
                position: position,
              ),
            ),
          );
          break;
      }

      return positionedAlert;
    },
  );

  Overlay.of(context).insert(entry);

  if (autoCloseDuration != null) {
    await Future.delayed(autoCloseDuration);
    entry.remove();
    onClose?.call();
  }
}
