import 'package:flutter/material.dart';

/// A drawer component that follows Element Plus design guidelines.
///
/// The [EDrawer] widget provides a sliding panel that can be shown from any
/// side of the screen. It supports various features like modal backdrop,
/// custom close behavior, and different directions.
///
/// ## Example
///
/// ```dart
/// EDrawer(
///   title: 'Drawer Title',
///   content: Text('Drawer content goes here'),
///   visible: true,
///   direction: 'rtl',
///   onClose: () => setState(() => _drawerVisible = false),
/// )
/// ```
class EDrawer extends StatefulWidget {
  /// The title text to display in the drawer header.
  ///
  /// If not provided, no title will be shown.
  final String? title;

  /// The main content of the drawer.
  ///
  /// This is displayed in the body section of the drawer.
  final Widget? content;

  /// Whether the drawer is visible.
  ///
  /// When true, the drawer will be shown with a sliding animation.
  /// Defaults to false.
  final bool visible;

  /// Callback function when the drawer is closed.
  ///
  /// This is called when the user clicks the close button or the modal backdrop.
  final VoidCallback? onClose;

  /// Whether to show the close button in the header.
  ///
  /// When true, a close button will be shown in the top-right corner.
  /// Defaults to true.
  final bool showClose;

  /// The width of the drawer when in horizontal mode.
  ///
  /// This is used when [direction] is 'ltr' or 'rtl'.
  /// Defaults to 420 logical pixels.
  final double width;

  /// The height of the drawer when in vertical mode.
  ///
  /// This is used when [direction] is 'ttb' or 'btt'.
  /// If not provided, it will be 30% of the screen height.
  final double? height;

  /// Custom padding for the drawer content.
  ///
  /// If not provided, no padding is applied.
  final EdgeInsets? padding;

  /// The direction from which the drawer slides in.
  ///
  /// Possible values are:
  /// * 'ltr' - slides in from the left
  /// * 'rtl' - slides in from the right (default)
  /// * 'ttb' - slides in from the top
  /// * 'btt' - slides in from the bottom
  final String direction;

  /// Whether to show a modal backdrop behind the drawer.
  ///
  /// When true, a semi-transparent backdrop will be shown and clicking it
  /// will close the drawer.
  /// Defaults to true.
  final bool modal;

  /// Whether to prevent scrolling of the drawer content.
  ///
  /// When true, the content will not be scrollable.
  /// Defaults to true.
  final bool lockScroll;

  /// Whether to close the drawer when clicking the modal backdrop.
  ///
  /// When true, clicking outside the drawer will close it.
  /// Defaults to true.
  final bool closeOnClickModal;

  /// Whether to close the drawer when pressing the escape key.
  ///
  /// When true, pressing the escape key will close the drawer.
  /// Defaults to true.
  final bool closeOnPressEscape;

  /// A custom widget to use as the drawer header.
  ///
  /// If provided, this overrides the default header with title and close button.
  final Widget? customHeader;

  /// The background color of the drawer.
  ///
  /// If not provided, the theme's dialog background color will be used.
  final Color? backgroundColor;

  /// A custom size for the drawer.
  ///
  /// This overrides both [width] and [height] when provided.
  /// The actual dimension used depends on the [direction].
  final double? size;

  /// Creates an [EDrawer] widget.
  ///
  /// The [visible] argument defaults to false, and [direction] defaults to 'rtl'.
  const EDrawer({
    super.key,
    this.title,
    this.content,
    this.visible = false,
    this.onClose,
    this.showClose = true,
    this.width = 420,
    this.height,
    this.padding,
    this.direction = 'rtl',
    this.modal = true,
    this.lockScroll = true,
    this.closeOnClickModal = true,
    this.closeOnPressEscape = true,
    this.customHeader,
    this.backgroundColor,
    this.size,
  });

  @override
  State<EDrawer> createState() => _EDrawerState();
}

class _EDrawerState extends State<EDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _updateAnimation();

    if (widget.visible) {
      _controller.forward();
    }
  }

  void _updateAnimation() {
    Offset beginOffset;
    Offset endOffset = Offset.zero;

    switch (widget.direction) {
      case 'ltr':
        beginOffset = const Offset(-1.0, 0.0);
        break;
      case 'rtl':
        beginOffset = const Offset(1.0, 0.0);
        break;
      case 'ttb':
        beginOffset = const Offset(0.0, -1.0);
        break;
      case 'btt':
        beginOffset = const Offset(0.0, 1.0);
        break;
      default:
        beginOffset = const Offset(1.0, 0.0);
    }

    _animation = Tween<Offset>(
      begin: beginOffset,
      end: endOffset,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(EDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible != oldWidget.visible) {
      if (widget.visible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
    if (widget.direction != oldWidget.direction) {
      _updateAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleClose() {
    widget.onClose?.call();
  }

  double _getSize() {
    if (widget.size != null) return widget.size!;

    switch (widget.direction) {
      case 'ttb':
      case 'btt':
        return widget.height ?? MediaQuery.of(context).size.height * 0.3;
      default:
        return widget.width;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible && _controller.isDismissed) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final size = _getSize();
    final isVertical = widget.direction == 'ttb' || widget.direction == 'btt';

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (widget.closeOnPressEscape) {
          _handleClose();
        }
        return false;
      },
      child: Stack(
        children: [
          // Modal backdrop
          if (widget.modal)
            FadeTransition(
              opacity: _controller,
              child: GestureDetector(
                onTap: widget.closeOnClickModal ? _handleClose : null,
                child: Container(
                  color: Colors.black54,
                ),
              ),
            ),
          // Drawer content
          Positioned(
            right: widget.direction == 'rtl' ? 0 : null,
            left: widget.direction == 'ltr' ? 0 : null,
            top: widget.direction == 'ttb' ? 0 : null,
            bottom: widget.direction == 'btt' ? 0 : null,
            child: SlideTransition(
              position: _animation,
              child: SizedBox(
                width: isVertical ? MediaQuery.of(context).size.width : size,
                height: isVertical ? size : MediaQuery.of(context).size.height,
                child: Material(
                  // ignore: deprecated_member_use
                  color: widget.backgroundColor ?? theme.dialogBackgroundColor,
                  elevation: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      widget.customHeader ??
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                if (widget.title != null)
                                  Expanded(
                                    child: Text(
                                      widget.title!,
                                      style: theme.textTheme.titleLarge,
                                    ),
                                  ),
                                if (widget.showClose)
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: _handleClose,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                              ],
                            ),
                          ),
                      // Content
                      if (widget.content != null)
                        Expanded(
                          child: SingleChildScrollView(
                            physics: widget.lockScroll
                                ? const NeverScrollableScrollPhysics()
                                : null,
                            padding: widget.padding,
                            child: widget.content!,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shows a drawer with the given parameters
Future<void> showEDrawer({
  required BuildContext context,
  String? title,
  Widget? content,
  bool showClose = true,
  double width = 420,
  double? height,
  EdgeInsets? padding,
  String direction = 'rtl',
  bool modal = true,
  bool lockScroll = true,
  bool closeOnClickModal = true,
  bool closeOnPressEscape = true,
  Widget? customHeader,
  Color? backgroundColor,
  double? size,
}) {
  bool isVisible = true;

  void close() {
    if (isVisible) {
      isVisible = false;
      Navigator.of(context).pop();
    }
  }

  return showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (context) => EDrawer(
      title: title,
      content: content,
      visible: true,
      onClose: close,
      showClose: showClose,
      width: width,
      height: height,
      padding: padding,
      direction: direction,
      modal: modal,
      lockScroll: lockScroll,
      closeOnClickModal: closeOnClickModal,
      closeOnPressEscape: closeOnPressEscape,
      customHeader: customHeader,
      backgroundColor: backgroundColor,
      size: size,
    ),
  );
}
