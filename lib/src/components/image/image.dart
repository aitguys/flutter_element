import 'package:flutter/material.dart';

/// An image component that follows Element Plus design guidelines.
///
/// The [EImage] widget provides a customizable image display with features like:
/// - Custom fit and dimensions
/// - Border radius
/// - Loading placeholder
/// - Error widget
/// - Image preview with zoom, rotate, and fullscreen capabilities
///
/// Example:
/// ```dart
/// EImage(
///   src: 'https://example.com/image.jpg',
///   width: 200,
///   height: 200,
///   borderRadius: 8,
///   preview: true,
///   placeholder: CircularProgressIndicator(),
///   errorWidget: Icon(Icons.error),
/// )
/// ```
class EImage extends StatelessWidget {
  /// The URL of the image to display.
  final String src;

  /// How the image should be inscribed into the space.
  /// Default is [BoxFit.cover].
  final BoxFit fit;

  /// The width of the image.
  /// If null, the image will take the available width.
  final double? width;

  /// The height of the image.
  /// If null, the image will take the available height.
  final double? height;

  /// The border radius of the image.
  /// Default is 0 (no border radius).
  final double borderRadius;

  /// Widget to display while the image is loading.
  /// If not provided, a default loading indicator will be shown.
  final Widget? placeholder;

  /// Widget to display when the image fails to load.
  /// If not provided, a default error icon will be shown.
  final Widget? errorWidget;

  /// Whether to enable image preview functionality.
  /// When true, tapping the image will open a preview dialog with zoom,
  /// rotate, and fullscreen capabilities.
  /// Default is false.
  final bool preview;

  const EImage({
    super.key,
    required this.src,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.placeholder,
    this.errorWidget,
    this.preview = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        src,
        width: width,
        height: height,
        fit: fit,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          }
          return frame == null
              ? (placeholder ??
                  Container(
                    width: width,
                    height: height,
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ))
              : child;
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ??
              Container(
                width: width,
                height: height,
                color: Colors.grey[200],
                child: const Icon(Icons.broken_image,
                    color: Colors.grey, size: 40),
              );
        },
      ),
    );
    if (preview) {
      image = GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            barrierColor: Colors.black.withValues(alpha: 0.85),
            builder: (_) => _ImagePreviewDialog(src: src),
          );
        },
        child: image,
      );
    }
    return image;
  }
}

/// A dialog widget for previewing images with interactive features.
///
/// The [_ImagePreviewDialog] provides:
/// - Zoom in/out functionality
/// - Image rotation
/// - Fullscreen toggle
/// - Close button
///
/// This is used internally by [EImage] when [preview] is enabled.
class _ImagePreviewDialog extends StatefulWidget {
  /// The URL of the image to preview.
  final String src;
  const _ImagePreviewDialog({required this.src});

  @override
  State<_ImagePreviewDialog> createState() => _ImagePreviewDialogState();
}

class _ImagePreviewDialogState extends State<_ImagePreviewDialog> {
  double _scale = 1.0;
  double _rotation = 0.0;
  bool _fullscreen = false;

  void _zoom(double factor) {
    setState(() {
      _scale = (_scale * factor).clamp(0.2, 5.0);
    });
  }

  void _rotate(double angle) {
    setState(() {
      _rotation += angle;
    });
  }

  void _toggleFullscreen() {
    setState(() {
      _fullscreen = !_fullscreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final image = Center(
      child: InteractiveViewer(
        minScale: 0.2,
        maxScale: 5.0,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..scaleByDouble(_scale, _scale, _scale, _scale)
            ..rotateZ(_rotation),
          child: Image.network(widget.src, fit: BoxFit.contain),
        ),
      ),
    );
    final actions = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.zoom_out, color: Colors.white),
            tooltip: '缩小',
            onPressed: () => _zoom(0.8),
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in, color: Colors.white),
            tooltip: '放大',
            onPressed: () => _zoom(1.25),
          ),
          IconButton(
            icon: Icon(_fullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                color: Colors.white),
            tooltip: '全屏',
            onPressed: _toggleFullscreen,
          ),
          IconButton(
            icon: const Icon(Icons.rotate_left, color: Colors.white),
            tooltip: '左旋转',
            onPressed: () => _rotate(-0.5 * 3.1415926),
          ),
          IconButton(
            icon: const Icon(Icons.rotate_right, color: Colors.white),
            tooltip: '右旋转',
            onPressed: () => _rotate(0.5 * 3.1415926),
          ),
          // IconButton(
          //   icon: const Icon(Icons.download, color: Colors.white),
          //   tooltip: '下载',
          //   onPressed: () async {
          //     // 实现图片下载功能
          //   },
          // ),
        ],
      ),
    );
    final closeBtn = Positioned(
      top: 16,
      right: 16,
      child: IconButton(
        icon: const Icon(Icons.close, color: Colors.white, size: 28),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
    final body = Stack(
      children: [
        Positioned.fill(child: image),
        Positioned(
          left: 0,
          right: 0,
          bottom: 32,
          child: Center(child: actions),
        ),
        closeBtn,
      ],
    );
    if (_fullscreen) {
      return Scaffold(
        backgroundColor: Colors.black.withValues(alpha: 0.95),
        body: SafeArea(child: body),
      );
    }
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: AspectRatio(
        aspectRatio: 1,
        child: body,
      ),
    );
  }
}
