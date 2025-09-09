import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

/// 平台类型枚举
enum EDialogPlatform {
  /// 自动检测平台
  auto,

  /// iOS 平台样式
  ios,

  /// Android 平台样式
  android,

  /// Web 平台样式
  web,
}

/// A dialog component that follows Element Plus design guidelines.
///
/// The [EDialog] widget provides a modal dialog with customizable header,
/// content, and footer sections. It supports various features like draggable
/// dialogs, custom close behavior, and scroll locking.
///
/// Supports different platform styles: iOS, Android, and Web.
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

  /// The platform style for the dialog.
  ///
  /// When set to [EDialogPlatform.auto], the platform will be automatically detected.
  /// Defaults to [EDialogPlatform.auto].
  final EDialogPlatform platform;

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
    this.margin = const EdgeInsets.symmetric(horizontal: 40),
    this.center = false,
    this.lockScroll = true,
    this.closeOnClickModal = true,
    this.closeOnPressEscape = true,
    this.draggable = false,
    this.customHeader,
    this.customFooter,
    this.platform = EDialogPlatform.auto,
  });

  @override
  State<EDialog> createState() => _EDialogState();
}

class _EDialogState extends State<EDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Offset _dragOffset = Offset.zero;

  /// 获取当前平台
  EDialogPlatform get _currentPlatform {
    if (widget.platform != EDialogPlatform.auto) {
      return widget.platform;
    }

    if (kIsWeb) {
      return EDialogPlatform.web;
    } else if (Platform.isIOS) {
      return EDialogPlatform.ios;
    } else if (Platform.isAndroid) {
      return EDialogPlatform.android;
    } else {
      return EDialogPlatform.web; // 默认使用 web 样式
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _getAnimationDuration(),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: _getAnimationCurve(),
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

  /// 获取平台特定的背景色
  Color _getBackgroundColor(ThemeData theme) {
    switch (_currentPlatform) {
      case EDialogPlatform.ios:
        return Colors.white;
      case EDialogPlatform.android:
        return theme.dialogBackgroundColor;
      case EDialogPlatform.web:
        return theme.dialogBackgroundColor;
      case EDialogPlatform.auto:
        return Colors.white;
    }
  }

  /// 获取平台特定的圆角
  BorderRadius _getBorderRadius() {
    switch (_currentPlatform) {
      case EDialogPlatform.ios:
        return BorderRadius.circular(20);
      case EDialogPlatform.android:
        return BorderRadius.circular(8);
      case EDialogPlatform.web:
        return BorderRadius.circular(8);
      case EDialogPlatform.auto:
        return BorderRadius.circular(8);
    }
  }

  /// 获取平台特定的阴影
  List<BoxShadow> _getBoxShadow() {
    switch (_currentPlatform) {
      case EDialogPlatform.ios:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ];
      case EDialogPlatform.android:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ];
      case EDialogPlatform.web:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ];
      case EDialogPlatform.auto:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ];
    }
  }

  /// 获取平台特定的动画曲线
  Curve _getAnimationCurve() {
    switch (_currentPlatform) {
      case EDialogPlatform.ios:
        return Curves.easeOutCubic;
      case EDialogPlatform.android:
        return Curves.fastOutSlowIn;
      case EDialogPlatform.web:
        return Curves.easeInOut;
      case EDialogPlatform.auto:
        return Curves.easeInOut;
    }
  }

  /// 获取平台特定的动画时长
  Duration _getAnimationDuration() {
    switch (_currentPlatform) {
      case EDialogPlatform.ios:
        return const Duration(milliseconds: 300);
      case EDialogPlatform.android:
        return const Duration(milliseconds: 200);
      case EDialogPlatform.web:
        return const Duration(milliseconds: 250);
      case EDialogPlatform.auto:
        return const Duration(milliseconds: 250);
    }
  }

  /// 获取平台特定的内边距
  EdgeInsets _getPlatformPadding() {
    switch (_currentPlatform) {
      case EDialogPlatform.ios:
        return const EdgeInsets.all(24);
      case EDialogPlatform.android:
        return const EdgeInsets.all(20);
      case EDialogPlatform.web:
        return const EdgeInsets.all(20);
      case EDialogPlatform.auto:
        return const EdgeInsets.all(20);
    }
  }

  /// 获取平台特定的标题样式
  TextStyle _getTitleStyle(ThemeData theme) {
    switch (_currentPlatform) {
      case EDialogPlatform.ios:
        return theme.textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ) ??
            const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            );
      case EDialogPlatform.android:
        return theme.textTheme.titleLarge?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ) ??
            theme.textTheme.titleLarge ??
            const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            );
      case EDialogPlatform.web:
        return theme.textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ) ??
            theme.textTheme.titleLarge ??
            const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            );
      case EDialogPlatform.auto:
        return theme.textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ) ??
            theme.textTheme.titleLarge ??
            const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            );
    }
  }

  /// 获取平台特定的内容样式
  TextStyle _getContentStyle(ThemeData theme) {
    switch (_currentPlatform) {
      case EDialogPlatform.ios:
        return theme.textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              color: Colors.black87,
              height: 1.4,
            ) ??
            const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.4,
            );
      case EDialogPlatform.android:
        return theme.textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              height: 1.4,
            ) ??
            theme.textTheme.bodyMedium ??
            const TextStyle(
              fontSize: 16,
              height: 1.4,
            );
      case EDialogPlatform.web:
        return theme.textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              height: 1.4,
            ) ??
            theme.textTheme.bodyMedium ??
            const TextStyle(
              fontSize: 16,
              height: 1.4,
            );
      case EDialogPlatform.auto:
        return theme.textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              height: 1.4,
            ) ??
            theme.textTheme.bodyMedium ??
            const TextStyle(
              fontSize: 16,
              height: 1.4,
            );
    }
  }

  /// 获取平台特定的 action 对齐方式
  MainAxisAlignment _getActionAlignment() {
    switch (_currentPlatform) {
      case EDialogPlatform.ios:
        return MainAxisAlignment.center;
      case EDialogPlatform.android:
        return MainAxisAlignment.center;
      case EDialogPlatform.web:
        return MainAxisAlignment.end;
      case EDialogPlatform.auto:
        return MainAxisAlignment.end;
    }
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: _getBackgroundColor(theme),
                            borderRadius: _getBorderRadius(),
                            boxShadow: _getBoxShadow(),
                          ),
                          child: Container(
                            width: dialogWidth,
                            height: widget.height,
                            padding: widget.padding ?? _getPlatformPadding(),
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
                                              style: _getTitleStyle(theme),
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
                                  SizedBox(
                                      height: _currentPlatform ==
                                              EDialogPlatform.ios
                                          ? 16
                                          : 20),
                                // Content
                                if (widget.content != null)
                                  Flexible(
                                    child: SingleChildScrollView(
                                      physics: widget.lockScroll
                                          ? const NeverScrollableScrollPhysics()
                                          : null,
                                      child: DefaultTextStyle(
                                        style: _getContentStyle(theme),
                                        child: widget.content!,
                                      ),
                                    ),
                                  ),
                                // Footer
                                if (widget.actions != null ||
                                    widget.customFooter != null) ...[
                                  SizedBox(
                                      height: _currentPlatform ==
                                              EDialogPlatform.ios
                                          ? 16
                                          : 20),
                                  widget.customFooter ??
                                      Row(
                                        mainAxisAlignment:
                                            _getActionAlignment(),
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
  EDialogPlatform platform = EDialogPlatform.auto,
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
      platform: platform,
    ),
  );
}
