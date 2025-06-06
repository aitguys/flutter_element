import 'package:flutter/material.dart';
import '../../theme/index.dart';

enum EAvatarShape { circle, square }

class EAvatar extends StatelessWidget {
  final String? src;
  final IconData? icon;
  final String? text;
  final double? customSize;
  final ESizeItem avatarSize;
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
    this.customSize,
    this.avatarSize = ESizeItem.medium,
    this.shape = EAvatarShape.circle,
    this.fit = BoxFit.cover,
    this.alt,
    this.fallback,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final caculateAvatarSize =
        ElememtSize(size: avatarSize).getAvatarSize(customSize: customSize);
    final borderRadius = shape == EAvatarShape.circle
        ? BorderRadius.circular(caculateAvatarSize / 2)
        : BorderRadius.circular(6);
    Widget content;
    if (src != null && src!.isNotEmpty) {
      content = ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          src!,
          width: caculateAvatarSize,
          height: caculateAvatarSize,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            if (fallback != null) return fallback!;
            if (icon != null) {
              return Icon(icon, size: caculateAvatarSize * 0.6);
            }
            if (text != null) {
              return Center(
                child: Text(
                  text!,
                  style: TextStyle(fontSize: caculateAvatarSize * 0.4),
                ),
              );
            }
            return Container(
              width: caculateAvatarSize,
              height: caculateAvatarSize,
              color: Colors.grey[200],
              child: Center(
                child: Text(alt ?? '',
                    style: TextStyle(fontSize: caculateAvatarSize * 0.3)),
              ),
            );
          },
        ),
      );
    } else if (icon != null) {
      content = Center(child: Icon(icon, size: caculateAvatarSize * 0.6));
    } else if (text != null) {
      content = Center(
        child: Text(
          text!,
          style: TextStyle(fontSize: caculateAvatarSize * 0.4),
        ),
      );
    } else if (child != null) {
      content = child!;
    } else {
      content = Container();
    }
    return Container(
      width: caculateAvatarSize,
      height: caculateAvatarSize,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: borderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: content,
    );
  }
}
