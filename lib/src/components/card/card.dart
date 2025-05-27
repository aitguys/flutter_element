import 'package:flutter/material.dart';

/// The shadow style of the card.
///
/// This enum defines the different shadow behaviors available for [ECard].
enum ECardShadow {
  /// Always show the shadow.
  always,

  /// Show the shadow only when the card is hovered.
  hover,

  /// Never show the shadow.
  never
}

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

  /// Custom CSS class for the header section.
  ///
  /// This is used for styling the header in web applications.
  final String? headerClass;

  /// Custom CSS class for the body section.
  ///
  /// This is used for styling the body in web applications.
  final String? bodyClass;

  /// Custom CSS class for the footer section.
  ///
  /// This is used for styling the footer in web applications.
  final String? footerClass;

  /// The shadow style of the card.
  ///
  /// This determines when and how the card's shadow is displayed.
  /// Defaults to [ECardShadow.always].
  final ECardShadow shadow;

  /// The margin around the card.
  ///
  /// If not provided, no margin is applied.
  final EdgeInsetsGeometry? margin;

  /// The padding inside the card body.
  ///
  /// If not provided, a default padding of 16 pixels on all sides is used.
  final EdgeInsetsGeometry? padding;

  /// The width of the card.
  ///
  /// If not provided, the card will expand to fill its container's width.
  final double? width;

  /// The height of the card.
  ///
  /// If not provided, the card will size itself based on its content.
  final double? height;

  /// Creates an [ECard] widget.
  ///
  /// The [shadow] argument defaults to [ECardShadow.always].
  const ECard({
    super.key,
    this.header,
    this.footer,
    this.child,
    this.bodyStyle,
    this.headerClass,
    this.bodyClass,
    this.footerClass,
    this.shadow = ECardShadow.always,
    this.margin,
    this.padding,
    this.width,
    this.height,
  });

  @override
  State<ECard> createState() => _ECardState();
}

class _ECardState extends State<ECard> {
  bool _isHover = false;

  BoxShadow? get _boxShadow {
    if (widget.shadow == ECardShadow.never) return null;
    if (widget.shadow == ECardShadow.hover && !_isHover) return null;
    return const BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE4E7ED), width: 1),
        boxShadow: _boxShadow != null ? [_boxShadow!] : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.header != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: widget.header,
            ),
          Container(
            padding: widget.padding ?? const EdgeInsets.all(16),
            decoration: widget.bodyStyle,
            child: widget.child,
          ),
          if (widget.footer != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: widget.footer,
            ),
        ],
      ),
    );
    if (widget.shadow == ECardShadow.hover) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHover = true),
        onExit: (_) => setState(() => _isHover = false),
        child: card,
      );
    }
    return card;
  }
}
