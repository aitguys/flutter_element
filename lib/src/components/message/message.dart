import 'package:flutter/material.dart';
import '../../theme/index.dart';

class EMessage extends StatefulWidget {
  final String message;
  final EColorType type;
  final bool isRound;
  final ESizeItem size;
  final int duration;
  final bool showClose;
  final EdgeInsets? padding;
  final double? fontSize;
  final Widget? icon;
  final double? offset;
  final bool visible;
  final VoidCallback? onClose;

  const EMessage({
    Key? key,
    required this.message,
    this.type = EColorType.info,
    this.duration = 3000,
    this.showClose = false,
    this.onClose,
    this.icon,
    this.offset,
    this.visible = true,
    this.isRound = false,
    this.size = ESizeItem.medium,
    this.padding,
    this.fontSize,
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
                borderRadius: widget.isRound
                    ? BorderRadius.circular(100)
                    : BorderRadius.circular(4),
                color: getMessageBackgroundColor(widget.type),
                child: Padding(
                  padding: ElememtSize(size: widget.size).getMessagePadding(
                    customPadding: widget.padding,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.icon ??
                          Icon(
                            getDefaultIconByType(widget.type),
                            color: Colors.white,
                            size: ElememtSize(size: widget.size).getIconSize(),
                          ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          widget.message,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontSize: ElememtSize(size: widget.size)
                                .getMessageFontSize(
                              customFontSize: widget.fontSize,
                            ),
                          ),
                        ),
                      ),
                      if (widget.showClose) ...[
                        const SizedBox(width: 10),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            size: ElememtSize(size: widget.size).getIconSize() -
                                4,
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

class EMessageController {
  static final List<OverlayEntry> _entries = [];

  static void _showMessage({
    required BuildContext context,
    required String message,
    EColorType type = EColorType.info,
    int duration = 3000,
    bool showClose = false,
    VoidCallback? onClose,
    Widget? icon,
    double? offset,
    EdgeInsets? padding,
    double? fontSize,
    bool isRound = false,
    ESizeItem size = ESizeItem.medium,
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
        icon: icon,
        offset: finalOffset,
        isRound: isRound,
        size: size,
        padding: padding,
        fontSize: fontSize,
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
    Widget? icon,
    double? offset = 20,
    EdgeInsets? padding,
    double? fontSize,
    bool isRound = false,
    ESizeItem size = ESizeItem.medium,
  }) {
    _showMessage(
      context: context,
      message: message,
      type: EColorType.success,
      duration: duration,
      showClose: showClose,
      onClose: onClose,
      icon: icon,
      offset: offset,
      isRound: isRound,
      size: size,
      padding: padding,
      fontSize: fontSize,
    );
  }

  static void warning(
    BuildContext context,
    String message, {
    int duration = 3000,
    bool showClose = false,
    VoidCallback? onClose,
    Widget? icon,
    double? offset = 20,
    EdgeInsets? padding,
    double? fontSize,
    bool isRound = false,
    ESizeItem size = ESizeItem.medium,
  }) {
    _showMessage(
      context: context,
      message: message,
      type: EColorType.warning,
      duration: duration,
      showClose: showClose,
      onClose: onClose,
      icon: icon,
      offset: offset,
      isRound: isRound,
      size: size,
      padding: padding,
      fontSize: fontSize,
    );
  }

  static void error(
    BuildContext context,
    String message, {
    int duration = 3000,
    bool showClose = false,
    VoidCallback? onClose,
    Widget? icon,
    double? offset = 20,
    EdgeInsets? padding,
    double? fontSize,
    bool isRound = false,
    ESizeItem size = ESizeItem.medium,
  }) {
    _showMessage(
      context: context,
      message: message,
      type: EColorType.danger,
      duration: duration,
      showClose: showClose,
      onClose: onClose,
      icon: icon,
      offset: offset,
      isRound: isRound,
      size: size,
      padding: padding,
      fontSize: fontSize,
    );
  }

  static void info(
    BuildContext context,
    String message, {
    int duration = 3000,
    bool showClose = false,
    VoidCallback? onClose,
    Widget? icon,
    double? offset = 20,
    bool isRound = false,
    ESizeItem size = ESizeItem.medium,
    EdgeInsets? padding,
    double? fontSize,
  }) {
    _showMessage(
      context: context,
      message: message,
      type: EColorType.info,
      duration: duration,
      showClose: showClose,
      onClose: onClose,
      icon: icon,
      offset: offset,
      isRound: isRound,
      size: size,
      padding: padding,
      fontSize: fontSize,
    );
  }
}
