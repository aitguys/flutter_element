import 'package:flutter/material.dart';

enum EAvatarShape { circle, square }

enum EAvatarSize { small, medium, large, custom }

class EAvatar extends StatelessWidget {
  final String? src;
  final IconData? icon;
  final String? text;
  final double? size; // 优先级高于 enum size
  final EAvatarSize avatarSize;
  final EAvatarShape shape;
  final BoxFit fit;
  final String? alt;
  final Widget? fallback;
  final Widget? child;

  const EAvatar({
    super.key,
    this.src,
    this.icon,
    this.text,
    this.size,
    this.avatarSize = EAvatarSize.medium,
    this.shape = EAvatarShape.circle,
    this.fit = BoxFit.cover,
    this.alt,
    this.fallback,
    this.child,
  });

  double get _size {
    if (size != null) return size!;
    switch (avatarSize) {
      case EAvatarSize.small:
        return 32;
      case EAvatarSize.large:
        return 64;
      case EAvatarSize.medium:
        return 40;
      case EAvatarSize.custom:
        return 40;
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = shape == EAvatarShape.circle
        ? BorderRadius.circular(_size / 2)
        : BorderRadius.circular(6);
    Widget content;
    if (src != null && src!.isNotEmpty) {
      content = ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          src!,
          width: _size,
          height: _size,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            if (fallback != null) return fallback!;
            if (icon != null) {
              return Icon(icon, size: _size * 0.6);
            }
            if (text != null) {
              return Center(
                child: Text(
                  text!,
                  style: TextStyle(fontSize: _size * 0.4),
                ),
              );
            }
            return Container(
              width: _size,
              height: _size,
              color: Colors.grey[200],
              child: Center(
                child: Text(alt ?? '', style: TextStyle(fontSize: _size * 0.3)),
              ),
            );
          },
        ),
      );
    } else if (icon != null) {
      content = Center(child: Icon(icon, size: _size * 0.6));
    } else if (text != null) {
      content = Center(
        child: Text(
          text!,
          style: TextStyle(fontSize: _size * 0.4),
        ),
      );
    } else if (child != null) {
      content = child!;
    } else {
      content = Container();
    }
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: borderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: content,
    );
  }
}
