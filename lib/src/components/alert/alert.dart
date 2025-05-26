import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class EAlert extends StatefulWidget {
  final String title;
  final String? description;
  final EColorType type;
  final Color? customColor;
  final bool closable;
  final bool showIcon;
  final IconData? icon;
  final VoidCallback? onClose;
  final bool center;
  final Widget? closeButton;
  final EdgeInsets? padding;
  final EThemeType theme;

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

    return FadeTransition(
      opacity: _animation,
      child: Container(
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
                padding:
                    EdgeInsets.only(top: widget.description != null ? 4 : 0),
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
      ),
    );
  }
}

/// Shows an alert dialog with the given parameters
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
}) async {
  late final OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) => Positioned(
      top: 16,
      left: 16,
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
        ),
      ),
    ),
  );

  Overlay.of(context).insert(entry);

  if (autoCloseDuration != null) {
    await Future.delayed(autoCloseDuration);
    entry.remove();
    onClose?.call();
  }
}
