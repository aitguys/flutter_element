import 'package:flutter/material.dart';

/// The size of the descriptions component.
/// 
/// This enum defines the different sizes available for [EDescriptions].
enum EDescriptionsSize {
  /// Medium size (default)
  medium,
  /// Small size
  small,
  /// Mini size
  mini,
}

/// An item in the descriptions component.
/// 
/// The [EDescriptionItem] class defines a label-value pair to be displayed
/// in the descriptions list.
class EDescriptionItem {
  /// The label text for this item.
  final String label;

  /// The content to display for this item.
  /// This can be any widget, but is typically a [Text] widget.
  final Widget content;

  /// The number of columns this item should span.
  /// Default is 1.
  final int span;

  /// The width of the label column for this item.
  /// If null, the width will be determined by the content.
  final double? labelWidth;

  /// The minimum width of the label column for this item.
  /// If null, no minimum width is enforced.
  final double? minWidth;

  /// The alignment of the content.
  /// If null, the default alignment will be used.
  final TextAlign? align;

  /// The label alignment.
  /// If null, the default alignment will be used.
  final TextAlign? labelAlign;

  /// The class name for the label element.
  /// This is used for styling in web applications.
  final String? labelClassName;

  /// The class name for the content element.
  /// This is used for styling in web applications.
  final String? className;

  const EDescriptionItem({
    required this.label,
    required this.content,
    this.span = 1,
    this.labelWidth,
    this.minWidth,
    this.align,
    this.labelAlign,
    this.labelClassName,
    this.className,
  });
}

/// A descriptions component that follows Element Plus design guidelines.
/// 
/// The [EDescriptions] widget provides a way to display a list of label-value
/// pairs in a structured format. It supports different sizes, column layouts,
/// and borders.
/// 
/// ## Example
/// 
/// ```dart
/// EDescriptions(
///   title: 'User Information',
///   column: 2,
///   border: true,
///   size: EDescriptionsSize.medium,
///   items: [
///     EDescriptionItem(
///       label: 'Username',
///       content: Text('john_doe'),
///     ),
///     EDescriptionItem(
///       label: 'Email',
///       content: Text('john@example.com'),
///       span: 2,
///     ),
///     EDescriptionItem(
///       label: 'Phone',
///       content: Text('+1 234 567 8900'),
///     ),
///   ],
/// )
/// ```
class EDescriptions extends StatelessWidget {
  /// Optional title text to display above the descriptions.
  final String? title;

  /// The number of columns to display the items in.
  /// Default is 3.
  final int column;

  /// Whether to show borders around the items.
  /// When true, each item will have a border.
  final bool border;

  /// The size of the descriptions component.
  /// This affects the font size and padding.
  final EDescriptionsSize size;

  /// The list of items to display in the descriptions.
  /// Each [EDescriptionItem] defines a label-value pair.
  final List<EDescriptionItem> items;

  /// Custom padding for the descriptions content.
  /// If not provided, a default padding will be used.
  final EdgeInsetsGeometry? padding;

  const EDescriptions({
    super.key,
    this.title,
    this.column = 3,
    this.border = false,
    this.size = EDescriptionsSize.medium,
    required this.items,
    this.padding,
  });

  double get _fontSize {
    switch (size) {
      case EDescriptionsSize.mini:
        return 12;
      case EDescriptionsSize.small:
        return 13;
      case EDescriptionsSize.medium:
        // default:
        return 14;
    }
  }

  @override
  Widget build(BuildContext context) {
    final rows = <TableRow>[];
    for (int i = 0; i < items.length; i += column) {
      final cells = <Widget>[];
      for (int j = 0; j < column; j++) {
        final idx = i + j;
        if (idx < items.length) {
          final item = items[idx];
          cells.add(_buildCell(item.label, item.content, border));
        } else {
          cells.add(Container());
        }
      }
      rows.add(TableRow(children: cells));
    }
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null && title!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  title!,
                  style: TextStyle(
                      fontSize: _fontSize + 2, fontWeight: FontWeight.bold),
                ),
              ),
            Table(
              border: border
                  ? TableBorder.all(color: Colors.grey[300]!, width: 1)
                  : null,
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: rows,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String label, Widget content, bool border) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: border ? 8 : 4, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: _fontSize - 1,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          content,
        ],
      ),
    );
  }
}
