import 'package:flutter/material.dart';

enum MessageType { success, warning, info, error }

class EMessage extends StatefulWidget {
  final String message;
  final MessageType type;
  final int duration;
  final bool showClose;
  final VoidCallback? onClose;
  final bool center;
  final Widget? icon;
  final double? offset;
  final bool visible;

  const EMessage({
    Key? key,
    required this.message,
    this.type = MessageType.info,
    this.duration = 3000,
    this.showClose = false,
    this.onClose,
    this.center = false,
    this.icon,
    this.offset,
    this.visible = true,
  }) : super(key: key);

  @override
  State<EMessage> createState() => _EMessageState();
}

class _EMessageState extends State<EMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    if (widget.visible) {
      _show();
    }
  }

  @override
  void didUpdateWidget(EMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible != oldWidget.visible) {
      if (widget.visible) {
        _show();
      } else {
        _hide();
      }
    }
  }

  void _show() {
    setState(() => _visible = true);
    _controller.forward();
    if (widget.duration > 0) {
      Future.delayed(Duration(milliseconds: widget.duration), _hide);
    }
  }

  void _hide() {
    _controller.reverse().then((_) {
      if (mounted) {
        setState(() => _visible = false);
        widget.onClose?.call();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getBackgroundColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (widget.type) {
      case MessageType.success:
        return Colors.green.withOpacity(0.9);
      case MessageType.warning:
        return Colors.orange.withOpacity(0.9);
      case MessageType.error:
        return Colors.red.withOpacity(0.9);
      case MessageType.info:
      default:
        return theme.primaryColor.withOpacity(0.9);
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case MessageType.success:
        return Icons.check_circle_outline;
      case MessageType.warning:
        return Icons.warning_amber_outlined;
      case MessageType.error:
        return Icons.error_outline;
      case MessageType.info:
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Positioned(
      top: widget.offset ?? 20,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(_animation),
        child: FadeTransition(
          opacity: _animation,
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              constraints: const BoxConstraints(maxWidth: 500),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(4),
                color: _getBackgroundColor(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.icon ??
                          Icon(
                            _getIcon(),
                            color: Colors.white,
                            size: 20,
                          ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          widget.message,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (widget.showClose) ...[
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                          onPressed: _hide,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MessageController {
  static final List<OverlayEntry> _entries = [];

  static void _showMessage({
    required BuildContext context,
    required String message,
    MessageType type = MessageType.info,
    int duration = 3000,
    bool showClose = false,
    VoidCallback? onClose,
    bool center = false,
    Widget? icon,
    double? offset,
  }) {
    final overlayState = Overlay.of(context);
    final double finalOffset = (offset ?? 20) + (_entries.length * 60);
    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => EMessage(
        message: message,
        type: type,
        duration: duration,
        showClose: showClose,
        onClose: () {
          entry.remove();
          _entries.remove(entry);
          onClose?.call();
        },
        center: center,
        icon: icon,
        offset: finalOffset,
      ),
    );

    _entries.add(entry);
    overlayState.insert(entry);
  }

  static void success(
    BuildContext context,
    String message, {
    int duration = 3000,
    bool showClose = false,
    VoidCallback? onClose,
    bool center = false,
    Widget? icon,
    double? offset = 20,
  }) {
    _showMessage(
      context: context,
      message: message,
      type: MessageType.success,
      duration: duration,
      showClose: showClose,
      onClose: onClose,
      center: center,
      icon: icon,
      offset: offset,
    );
  }

  static void warning(
    BuildContext context,
    String message, {
    int duration = 3000,
    bool showClose = false,
    VoidCallback? onClose,
    bool center = false,
    Widget? icon,
    double? offset = 20,
  }) {
    _showMessage(
      context: context,
      message: message,
      type: MessageType.warning,
      duration: duration,
      showClose: showClose,
      onClose: onClose,
      center: center,
      icon: icon,
      offset: offset,
    );
  }

  static void error(
    BuildContext context,
    String message, {
    int duration = 3000,
    bool showClose = false,
    VoidCallback? onClose,
    bool center = false,
    Widget? icon,
    double? offset = 20,
  }) {
    _showMessage(
      context: context,
      message: message,
      type: MessageType.error,
      duration: duration,
      showClose: showClose,
      onClose: onClose,
      center: center,
      icon: icon,
      offset: offset,
    );
  }

  static void info(
    BuildContext context,
    String message, {
    int duration = 3000,
    bool showClose = false,
    VoidCallback? onClose,
    bool center = false,
    Widget? icon,
    double? offset = 20,
  }) {
    _showMessage(
      context: context,
      message: message,
      type: MessageType.info,
      duration: duration,
      showClose: showClose,
      onClose: onClose,
      center: center,
      icon: icon,
      offset: offset,
    );
  }
}
