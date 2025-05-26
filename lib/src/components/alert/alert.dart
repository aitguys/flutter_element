import 'package:flutter/material.dart';

enum EAlertType {
  success,
  warning,
  info,
  error,
}

class EAlert extends StatefulWidget {
  final String title;
  final String? description;
  final EAlertType type;
  final bool closable;
  final bool showIcon;
  final IconData? icon;
  final VoidCallback? onClose;
  final bool center;
  final Widget? closeButton;
  final EdgeInsets? padding;

  const EAlert({
    Key? key,
    required this.title,
    this.description,
    this.type = EAlertType.info,
    this.closable = true,
    this.showIcon = false,
    this.icon,
    this.onClose,
    this.center = false,
    this.closeButton,
    this.padding,
  }) : super(key: key);

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

  Color _getBackgroundColor(BuildContext context) {
    // final theme = Theme.of(context);
    switch (widget.type) {
      case EAlertType.success:
        return Colors.green[50] ?? Colors.green.withOpacity(0.1);
      case EAlertType.warning:
        return Colors.orange[50] ?? Colors.orange.withOpacity(0.1);
      case EAlertType.info:
        return Colors.blue[50] ?? Colors.blue.withOpacity(0.1);
      case EAlertType.error:
        return Colors.red[50] ?? Colors.red.withOpacity(0.1);
    }
  }

  Color _getIconColor(BuildContext context) {
    // final theme = Theme.of(context);
    switch (widget.type) {
      case EAlertType.success:
        return Colors.green;
      case EAlertType.warning:
        return Colors.orange;
      case EAlertType.info:
        return Colors.blue;
      case EAlertType.error:
        return Colors.red;
    }
  }

  IconData _getDefaultIcon() {
    switch (widget.type) {
      case EAlertType.success:
        return Icons.check_circle;
      case EAlertType.warning:
        return Icons.warning;
      case EAlertType.info:
        return Icons.info;
      case EAlertType.error:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    return FadeTransition(
      opacity: _animation,
      child: Container(
        padding: widget.padding ?? const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _getBackgroundColor(context),
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
                  widget.icon ?? _getDefaultIcon(),
                  color: _getIconColor(context),
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
                      color: _getIconColor(context),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (widget.description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      widget.description!,
                      style: TextStyle(
                        color: _getIconColor(context).withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (widget.closable) ...[
              const SizedBox(width: 8),
              widget.closeButton ??
                  InkWell(
                    onTap: _close,
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: _getIconColor(context).withOpacity(0.8),
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
  EAlertType type = EAlertType.info,
  bool closable = true,
  bool showIcon = false,
  IconData? icon,
  VoidCallback? onClose,
  bool center = false,
  Widget? closeButton,
  EdgeInsets? padding,
  Duration? autoCloseDuration,
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
