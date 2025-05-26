import 'package:flutter/material.dart';

class EDrawer extends StatefulWidget {
  final String? title;
  final Widget? content;
  final bool visible;
  final VoidCallback? onClose;
  final bool showClose;
  final double width;
  final double? height;
  final EdgeInsets? padding;
  final String direction;
  final bool modal;
  final bool lockScroll;
  final bool closeOnClickModal;
  final bool closeOnPressEscape;
  final Widget? customHeader;
  final Color? backgroundColor;
  final double? size;

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
