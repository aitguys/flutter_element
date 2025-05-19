import 'package:flutter/material.dart';

enum EDescriptionsSize { medium, small, mini }

class EDescriptions extends StatelessWidget {
  final String? title;
  final int column;
  final bool border;
  final EDescriptionsSize size;
  final List<EDescriptionItem> items;
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
      default:
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

class EDescriptionItem {
  final String label;
  final Widget content;

  EDescriptionItem({required this.label, required this.content});
}
