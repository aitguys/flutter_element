import 'package:flutter/material.dart';

/// The shadow style of the card.
///
/// This enum defines the different shadow behaviors available for [ECard].

/// A card component that follows Element Plus design guidelines.
///
/// The [ECard] widget provides a container with a header, body, and footer
/// sections. It supports different shadow styles and can be customized with
/// various styles and dimensions.
///
/// ## Example
///
/// ```dart
/// ECard(
///   header: Text('Card Title'),
///   child: Text('Card content goes here'),
///   footer: Text('Card footer'),
///   shadow: ECardShadow.hover,
/// )
/// ```
class ECard extends StatefulWidget {
  /// The widget to display in the card header.
  ///
  /// This is displayed at the top of the card with default padding.
  final Widget? header;

  /// The widget to display in the card footer.
  ///
  /// This is displayed at the bottom of the card with default padding.
  final Widget? footer;

  /// The main content of the card.
  ///
  /// This is displayed in the body section of the card.
  final Widget? child;

  /// Custom decoration for the card body.
  ///
  /// This can be used to customize the appearance of the body section.
  final BoxDecoration? bodyStyle;

  /// The padding inside the card body.
  ///
  /// If not provided, a default padding of 16 pixels on all sides is used.

  /// The width of the card.
  ///
  /// If not provided, the card will expand to fill its container's width.
  final double? width;

  /// The height of the card.
  ///
  /// If not provided, the card will size itself based on its content.
  final double? height;

  final EdgeInsetsGeometry? padding;

  final bool showShadowWhenHover;

  /// The margin around the card.
  final EdgeInsetsGeometry? margin;

  /// Creates an [ECard] widget.
  ///
  const ECard({
    super.key,
    this.header,
    this.footer,
    this.child,
    this.bodyStyle,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.showShadowWhenHover = false,
  });

  @override
  State<ECard> createState() => _ECardState();
}

class _ECardState extends State<ECard> {
  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      padding: widget.padding ?? const EdgeInsets.all(16),
      decoration: (() {
        final defaultDecoration = BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: const Color(0xFFE4E7ED), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        );
        final passedDecoration = widget.bodyStyle;
        if (passedDecoration == null) return defaultDecoration;
        return defaultDecoration.copyWith(
          color: passedDecoration.color ?? defaultDecoration.color,
          borderRadius:
              passedDecoration.borderRadius ?? defaultDecoration.borderRadius,
          border: passedDecoration.border ?? defaultDecoration.border,
          boxShadow: passedDecoration.boxShadow ?? defaultDecoration.boxShadow,
          gradient: passedDecoration.gradient ?? defaultDecoration.gradient,
          backgroundBlendMode: passedDecoration.backgroundBlendMode ??
              defaultDecoration.backgroundBlendMode,
          shape: passedDecoration.shape,
          image: passedDecoration.image ?? defaultDecoration.image,
        );
      })(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.header != null)
            Container(
              child: widget.header,
            ),
          if (widget.header != null)
            const Divider(
              height: 1,
              color: Color(0xFFE4E7ED),
            ),
          widget.child ?? const SizedBox.shrink(),
          if (widget.footer != null)
            const Divider(
              height: 1,
              color: Color(0xFFE4E7ED),
            ),
          if (widget.footer != null)
            Container(
              child: widget.footer,
            ),
        ],
      ),
    );
    return card;
  }
}
