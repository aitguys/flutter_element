import 'package:flutter/material.dart';

/// A dialog component that follows Element Plus design guidelines.
/// 
/// The [EDialog] widget provides a modal dialog with customizable header,
/// content, and footer sections. It supports various features like draggable
/// dialogs, custom close behavior, and scroll locking.
/// 
/// ## Example
/// 
/// ```dart
/// EDialog(
///   title: 'Dialog Title',
///   content: Text('Dialog content goes here'),
///   actions: [
///     TextButton(
///       onPressed: () => Navigator.pop(context),
///       child: Text('Cancel'),
///     ),
///     ElevatedButton(
///       onPressed: () => Navigator.pop(context),
///       child: Text('Confirm'),
///     ),
///   ],
///   visible: true,
///   onClose: () => Navigator.pop(context),
/// )
/// ```
class EDialog extends StatefulWidget {
  /// The title text to display in the dialog header.
  /// 
  /// If not provided, no title will be shown.
  final String? title;

  /// The main content of the dialog.
  /// 
  /// This is displayed in the body section of the dialog.
  final Widget? content;

  /// The action buttons to display in the dialog footer.
  /// 
  /// These are typically buttons like "Cancel" and "Confirm".
  final List<Widget>? actions;

  /// Whether the dialog is visible.
  /// 
  /// When true, the dialog will be shown with an animation.
  /// Defaults to false.
  final bool visible;

  /// Callback function when the dialog is closed.
  /// 
  /// This is called when the user clicks the close button or the modal backdrop.
  final VoidCallback? onClose;

  /// Whether to show the close button in the header.
  /// 
  /// When true, a close button will be shown in the top-right corner.
  /// Defaults to true.
  final bool showClose;

  /// The width of the dialog.
  /// 
  /// Defaults to 420 logical pixels.
  final double width;

  /// The height of the dialog.
  /// 
  /// If not provided, the dialog will size itself based on its content.
  final double? height;

  /// Custom padding for the dialog content.
  /// 
  /// If not provided, a default padding of 20 pixels on all sides is used.
  final EdgeInsets? padding;

  /// The margin around the dialog.
  /// 
  /// This determines the space between the dialog and the screen edges.
  /// Defaults to 16 pixels on the left and right sides.
  final EdgeInsets margin;

  /// Whether to center the dialog content.
  /// 
  /// When true, the title and content will be centered.
  /// Defaults to false.
  final bool center;

  /// Whether to prevent scrolling of the dialog content.
  /// 
  /// When true, the content will not be scrollable.
  /// Defaults to true.
  final bool lockScroll;

  /// Whether to close the dialog when clicking the modal backdrop.
  /// 
  /// When true, clicking outside the dialog will close it.
  /// Defaults to true.
  final bool closeOnClickModal;

  /// Whether to close the dialog when pressing the escape key.
  /// 
  /// When true, pressing the escape key will close the dialog.
  /// Defaults to true.
  final bool closeOnPressEscape;

  /// Whether the dialog can be dragged.
  /// 
  /// When true, the dialog can be moved by dragging its header.
  /// Defaults to false.
  final bool draggable;

  /// A custom widget to use as the dialog header.
  /// 
  /// If provided, this overrides the default header with title and close button.
  final Widget? customHeader;

  /// A custom widget to use as the dialog footer.
  /// 
  /// If provided, this overrides the default footer with action buttons.
  final Widget? customFooter;

  /// Creates an [EDialog] widget.
  /// 
  /// The [visible] argument defaults to false.
  const EDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.visible = false,
    this.onClose,
    this.showClose = true,
    this.width = 420,
    this.height,
    this.padding,
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.center = false,
    this.lockScroll = true,
    this.closeOnClickModal = true,
    this.closeOnPressEscape = true,
    this.draggable = false,
    this.customHeader,
    this.customFooter,
  });

  @override
  State<EDialog> createState() => _EDialogState();
}

class _EDialogState extends State<EDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Offset _dragOffset = Offset.zero;

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
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(EDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible != oldWidget.visible) {
      if (widget.visible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
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

  @override
  Widget build(BuildContext context) {
    if (!widget.visible && _controller.isDismissed) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final dialogWidth =
        widget.width.clamp(0.0, MediaQuery.of(context).size.width);

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
          FadeTransition(
            opacity: _animation,
            child: GestureDetector(
              onTap: widget.closeOnClickModal ? _handleClose : null,
              child: Container(
                color: Colors.black54,
              ),
            ),
          ),
          // Dialog content
          FadeTransition(
            opacity: _animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.7, end: 1.0).animate(_animation),
              child: Center(
                child: Transform.translate(
                  offset: _dragOffset,
                  child: Padding(
                    padding: widget.margin,
                    child: GestureDetector(
                      onPanStart: widget.draggable ? (_) {} : null,
                      onPanUpdate: widget.draggable
                          ? (details) {
                              setState(() {
                                _dragOffset += details.delta;
                              });
                            }
                          : null,
                      child: MouseRegion(
                        cursor: widget.draggable
                            ? SystemMouseCursors.move
                            : SystemMouseCursors.basic,
                        child: Material(
                          // ignore: deprecated_member_use
                          color: theme.dialogBackgroundColor,
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            width: dialogWidth,
                            height: widget.height,
                            padding: widget.padding ?? const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Header
                                widget.customHeader ??
                                    Row(
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
                                if (widget.title != null ||
                                    widget.customHeader != null)
                                  const SizedBox(height: 20),
                                // Content
                                if (widget.content != null)
                                  Flexible(
                                    child: SingleChildScrollView(
                                      physics: widget.lockScroll
                                          ? const NeverScrollableScrollPhysics()
                                          : null,
                                      child: widget.content!,
                                    ),
                                  ),
                                // Footer
                                if (widget.actions != null ||
                                    widget.customFooter != null) ...[
                                  const SizedBox(height: 20),
                                  widget.customFooter ??
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: widget.actions!,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shows a dialog with the given parameters
Future<void> showEDialog({
  required BuildContext context,
  String? title,
  Widget? content,
  List<Widget>? actions,
  bool showClose = true,
  double width = 420,
  double? height,
  EdgeInsets? padding,
  EdgeInsets? margin,
  bool center = false,
  bool lockScroll = true,
  bool closeOnClickModal = true,
  bool closeOnPressEscape = true,
  bool draggable = false,
  Widget? customHeader,
  Widget? customFooter,
}) {
  return showDialog(
    context: context,
    barrierDismissible: closeOnClickModal,
    builder: (context) => EDialog(
      title: title,
      content: content,
      actions: actions,
      visible: true,
      onClose: () => Navigator.of(context).pop(),
      showClose: showClose,
      width: width,
      height: height,
      padding: padding,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16),
      center: center,
      lockScroll: lockScroll,
      closeOnClickModal: closeOnClickModal,
      closeOnPressEscape: closeOnPressEscape,
      draggable: draggable,
      customHeader: customHeader,
      customFooter: customFooter,
    ),
  );
}
