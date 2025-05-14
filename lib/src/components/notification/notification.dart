import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

enum NotificationType { success, warning, info, error }

class ENotification extends StatefulWidget {
  final String title;
  final String message;
  final NotificationType type;
  final int duration;
  final bool showClose;
  final VoidCallback? onClose;
  final Widget? icon;
  final double? offset;
  final bool visible;
  final String? position;
  final VoidCallback? onClick;

  const ENotification({
    Key? key,
    required this.title,
    required this.message,
    this.type = NotificationType.info,
    this.duration = 4500,
    this.showClose = true,
    this.onClose,
    this.icon,
    this.offset,
    this.visible = true,
    this.position = 'topRight',
    this.onClick,
  }) : super(key: key);

  @override
  State<ENotification> createState() => _ENotificationState();
}

class _ENotificationState extends State<ENotification>
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
  void didUpdateWidget(ENotification oldWidget) {
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
      case NotificationType.success:
        return Colors.green.withOpacity(0.9);
      case NotificationType.warning:
        return Colors.orange.withOpacity(0.9);
      case NotificationType.error:
        return Colors.red.withOpacity(0.9);
      case NotificationType.info:
      default:
        return theme.primaryColor.withOpacity(0.9);
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case NotificationType.success:
        return Icons.check_circle_outline;
      case NotificationType.warning:
        return Icons.warning_amber_outlined;
      case NotificationType.error:
        return Icons.error_outline;
      case NotificationType.info:
      default:
        return Icons.info_outline;
    }
  }

  Alignment _getAlignment() {
    switch (widget.position) {
      case 'topLeft':
        return Alignment.topLeft;
      case 'topRight':
        return Alignment.topRight;
      case 'bottomLeft':
        return Alignment.bottomLeft;
      case 'bottomRight':
        return Alignment.bottomRight;
      default:
        return Alignment.topRight;
    }
  }

  EdgeInsets _getPosition() {
    final offset = widget.offset ?? 20;
    switch (widget.position) {
      case 'topLeft':
        return EdgeInsets.only(top: offset, left: 20);
      case 'topRight':
        return EdgeInsets.only(top: offset, right: 20);
      case 'bottomLeft':
        return EdgeInsets.only(bottom: offset, left: 20);
      case 'bottomRight':
        return EdgeInsets.only(bottom: offset, right: 20);
      default:
        return EdgeInsets.only(top: offset, right: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final alignment = _getAlignment();
    final position = _getPosition();

    return Positioned.fill(
      child: Stack(
        alignment: alignment,
        children: [
          Positioned(
            top: position.top,
            bottom: position.bottom,
            left: position.left,
            right: position.right,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(_animation),
              child: FadeTransition(
                opacity: _animation,
                child: Container(
                  width: 330,
                  constraints: const BoxConstraints(maxWidth: 330),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    child: InkWell(
                      onTap: widget.onClick,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                widget.icon ??
                                    Icon(
                                      _getIcon(),
                                      color: _getBackgroundColor(context),
                                      size: 24,
                                    ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    widget.title,
                                    style: theme.textTheme.titleMedium,
                                  ),
                                ),
                                if (widget.showClose)
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: _hide,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                              ],
                            ),
                            if (widget.message.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                widget.message,
                                style: theme.textTheme.bodyMedium,
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
        ],
      ),
    );
  }
}

class NotificationController {
  static final List<OverlayEntry> _entries = [];
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> _initPlatformSpecific() async {
    if (_initialized) return;

    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      const initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      final initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          // Handle iOS notification when app is in foreground
        },
      );
      final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          // Handle notification tap
        },
      );
    }
    _initialized = true;
  }

  static Future<void> _showPlatformNotification({
    required String title,
    required String message,
    NotificationType type = NotificationType.info,
  }) async {
    // Web platform notification

    // Mobile platform notification
    await _initPlatformSpecific();
    const androidDetails = AndroidNotificationDetails(
      'flutter_element_channel',
      'Flutter Element Notifications',
      channelDescription: 'Notifications from Flutter Element',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      message,
      details,
    );
  }

  static void _showOverlayNotification({
    required BuildContext context,
    required String title,
    required String message,
    NotificationType type = NotificationType.info,
    int duration = 4500,
    bool showClose = true,
    VoidCallback? onClose,
    Widget? icon,
    String position = 'topRight',
    VoidCallback? onClick,
    double? offset,
  }) {
    final overlayState = Overlay.of(context);
    final double finalOffset = (offset ?? 20) + (_entries.length * 80);
    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => ENotification(
        title: title,
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
        position: position,
        onClick: onClick,
        offset: finalOffset,
      ),
    );

    _entries.add(entry);
    overlayState.insert(entry);
  }

  static Future<void> success(
    BuildContext context,
    String title,
    String message, {
    int duration = 4500,
    bool showClose = true,
    VoidCallback? onClose,
    Widget? icon,
    String position = 'topRight',
    VoidCallback? onClick,
    double? offset = 20,
    bool usePlatformNotification = false,
  }) async {
    if (usePlatformNotification) {
      await _showPlatformNotification(
        title: title,
        message: message,
        type: NotificationType.success,
      );
    } else {
      _showOverlayNotification(
        context: context,
        title: title,
        message: message,
        type: NotificationType.success,
        duration: duration,
        showClose: showClose,
        onClose: onClose,
        icon: icon,
        position: position,
        onClick: onClick,
        offset: offset,
      );
    }
  }

  static Future<void> warning(
    BuildContext context,
    String title,
    String message, {
    int duration = 4500,
    bool showClose = true,
    VoidCallback? onClose,
    Widget? icon,
    String position = 'topRight',
    VoidCallback? onClick,
    double? offset = 20,
    bool usePlatformNotification = false,
  }) async {
    if (usePlatformNotification) {
      await _showPlatformNotification(
        title: title,
        message: message,
        type: NotificationType.warning,
      );
    } else {
      _showOverlayNotification(
        context: context,
        title: title,
        message: message,
        type: NotificationType.warning,
        duration: duration,
        showClose: showClose,
        onClose: onClose,
        icon: icon,
        position: position,
        onClick: onClick,
        offset: offset,
      );
    }
  }

  static Future<void> error(
    BuildContext context,
    String title,
    String message, {
    int duration = 4500,
    bool showClose = true,
    VoidCallback? onClose,
    Widget? icon,
    String position = 'topRight',
    VoidCallback? onClick,
    double? offset = 20,
    bool usePlatformNotification = false,
  }) async {
    if (usePlatformNotification) {
      await _showPlatformNotification(
        title: title,
        message: message,
        type: NotificationType.error,
      );
    } else {
      _showOverlayNotification(
        context: context,
        title: title,
        message: message,
        type: NotificationType.error,
        duration: duration,
        showClose: showClose,
        onClose: onClose,
        icon: icon,
        position: position,
        onClick: onClick,
        offset: offset,
      );
    }
  }

  static Future<void> info(
    BuildContext context,
    String title,
    String message, {
    int duration = 4500,
    bool showClose = true,
    VoidCallback? onClose,
    Widget? icon,
    String position = 'topRight',
    VoidCallback? onClick,
    double? offset = 20,
    bool usePlatformNotification = false,
  }) async {
    if (usePlatformNotification) {
      await _showPlatformNotification(
        title: title,
        message: message,
        type: NotificationType.info,
      );
    } else {
      _showOverlayNotification(
        context: context,
        title: title,
        message: message,
        type: NotificationType.info,
        duration: duration,
        showClose: showClose,
        onClose: onClose,
        icon: icon,
        position: position,
        onClick: onClick,
        offset: offset,
      );
    }
  }
}
