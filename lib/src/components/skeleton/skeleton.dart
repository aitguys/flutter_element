import 'package:flutter/material.dart';

class ESkeleton extends StatelessWidget {
  final bool active;
  final bool animated;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget? child;
  final bool loading;

  const ESkeleton({
    Key? key,
    this.active = false,
    this.animated = true,
    this.width,
    this.height,
    this.borderRadius,
    this.child,
    this.loading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!loading && child != null) {
      return child!;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: width ?? constraints.maxWidth,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(4),
            color: active ? Colors.grey[200] : Colors.grey[300],
          ),
          child: animated
              ? _ShimmerEffect(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius ?? BorderRadius.circular(4),
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}

class _ShimmerEffect extends StatefulWidget {
  final Widget child;

  const _ShimmerEffect({Key? key, required this.child}) : super(key: key);

  @override
  _ShimmerEffectState createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<_ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                Colors.transparent,
                Colors.white,
                Colors.transparent,
              ],
              stops: [
                0.0,
                _animation.value,
                1.0,
              ],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

class ESkeletonItem extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ESkeletonItem({
    Key? key,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ESkeleton(
      width: width,
      height: height,
      borderRadius: borderRadius,
    );
  }
}
