import 'package:flutter/material.dart';
import '../../theme/index.dart';

/// A message component that follows Element Plus design guidelines.
///
/// The [EMessage] widget provides a non-disruptive notification that appears
/// at the top of the screen. It supports different types, sizes, and features
/// like auto-close and custom icons.
///
/// ## Example
///
/// ```dart
/// // Using the widget directly
/// EMessage(
///   message: 'This is a message',
///   type: EColorType.success,
///   duration: 3000,
///   onClose: () => print('Message closed'),
/// )
///
/// // Using the controller
/// EMessageController.showSuccess(
///   context: context,
///   message: 'Operation completed successfully',
/// )
/// ```
class EMessage extends StatefulWidget {
  /// The message text to display.
  ///
  /// This is the main content of the message.
  final String message;

  /// The type of message, which determines its color scheme.
  ///
  /// This affects both the background color and the icon.
  /// Defaults to [EColorType.info].
  final EColorType type;

  /// Whether the message should have rounded corners.
  ///
  /// When true, the message will have fully rounded corners.
  /// Defaults to false.
  final bool isRound;

  /// The size of the message.
  ///
  /// This affects the padding, font size, and icon size.
  /// Defaults to [ESizeItem.medium].
  final ESizeItem size;

  /// The duration in milliseconds before the message automatically closes.
  ///
  /// If set to 0, the message will not auto-close.
  /// Defaults to 3000 milliseconds (3 seconds).
  final int duration;

  /// Whether to show a close button.
  ///
  /// When true, a close button will be shown on the right side of the message.
  /// Defaults to false.
  final bool showClose;

  /// Custom padding for the message content.
  ///
  /// If not provided, the padding will be determined by [size].
  final EdgeInsets? padding;

  /// Custom font size for the message text.
  ///
  /// If not provided, the font size will be determined by [size].
  final double? fontSize;

  /// A custom icon to display in the message.
  ///
  /// If not provided, a default icon based on [type] will be used.
  final Widget? icon;

  /// The vertical offset from the top of the screen.
  ///
  /// This determines how far from the top the message appears.
  /// Defaults to 20 logical pixels.
  final double? offset;

  /// Whether the message is visible.
  ///
  /// When true, the message will be shown with an animation.
  /// Defaults to true.
  final bool visible;

  /// Callback function when the message is closed.
  ///
  /// This is called when the message is closed either manually or automatically.
  final VoidCallback? onClose;

  /// Creates an [EMessage] widget.
  ///
  /// The [message] argument is required.
  const EMessage({
    super.key,
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
  });

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

/// A controller for showing messages using an overlay.
///
/// The [EMessageController] provides static methods to show different types
/// of messages without needing to manage the widget state manually.
///
/// ## Example
///
/// ```dart
/// // Show a success message
/// EMessageController.showSuccess(
///   context: context,
///   message: 'Operation completed successfully',
/// )
///
/// // Show an error message
/// EMessageController.showError(
///   context: context,
///   message: 'An error occurred',
/// )
/// ```
class EMessageController {
  /// The list of currently displayed message overlays.
  static final List<OverlayEntry> _entries = [];

  /// Shows a message with the specified parameters.
  ///
  /// This is the base method used by all other show methods.
  /// It creates an overlay entry and displays it at the top of the screen.
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
