import 'package:flutter/material.dart';

class EDialog extends StatefulWidget {
  final String? title;
  final Widget? content;
  final List<Widget>? actions;
  final bool visible;
  final VoidCallback? onClose;
  final bool showClose;
  final double width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets margin;
  final bool center;
  final bool lockScroll;
  final bool closeOnClickModal;
  final bool closeOnPressEscape;
  final bool draggable;
  final Widget? customHeader;
  final Widget? customFooter;

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
