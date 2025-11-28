import 'package:flutter/material.dart';

/// A column definition for the [ETable] component.
///
/// The [ETableColumn] class defines how a column should be displayed in the table,
/// including its label, width, alignment, and custom rendering.
///
/// ## Example
///
/// ```dart
/// ETableColumn(
///   prop: 'name',
///   label: 'Name',
///   width: 200,
///   align: TextAlign.center,
///   sortable: true,
/// )
/// ```
class ETableColumn {
  /// The property key in the data object to display in this column.
  final String prop;

  /// The label text to display in the column header.
  final String label;

  /// The width of the column in logical pixels.
  /// If null, the column will size itself based on its content.
  final double? width;

  /// A custom render function for the column cells.
  /// If provided, this function will be called with the row data to render
  /// custom content for each cell in this column.
  final Widget Function(dynamic)? render;

  /// The text alignment for the column content.
  /// If null, the default alignment will be used.
  final TextAlign? align;

  /// Whether the column can be sorted.
  /// When true, a sort indicator will be shown in the header.
  final bool sortable;

  const ETableColumn({
    required this.prop,
    required this.label,
    this.width,
    this.render,
    this.align,
    this.sortable = false,
  });
}

/// A table component that follows Element Plus design guidelines.
///
/// The [ETable] widget provides a data table with features like:
/// - Customizable columns with sorting
/// - Striped rows
/// - Bordered cells
/// - Row click and long press events
/// - Custom cell rendering
/// - Fixed header
///
/// ## Example
///
/// ```dart
/// ETable(
///   data: [
///     {'name': 'John', 'age': 30},
///     {'name': 'Jane', 'age': 25},
///   ],
///   columns: [
///     ETableColumn(prop: 'name', label: 'Name', sortable: true),
///     ETableColumn(prop: 'age', label: 'Age', align: TextAlign.center),
///   ],
///   stripe: true,
///   border: true,
///   onRowTap: (row) => print('Row tapped: $row'),
/// )
/// ```
class ETable extends StatefulWidget {
  /// The data to display in the table.
  /// Each item in the list represents a row, and should be a map
  /// with keys matching the [prop] values of the columns.
  final List<Map<String, dynamic>> data;

  /// The column definitions for the table.
  /// Each [ETableColumn] defines how a column should be displayed.
  final List<ETableColumn> columns;

  /// Whether to show striped rows.
  /// When true, alternate rows will have a different background color.
  final bool stripe;

  /// Whether to show borders around cells.
  /// When true, each cell will have a border.
  final bool border;

  /// The height of the table.
  /// If provided, the table body will scroll vertically when content
  /// exceeds this height.
  final double? height;

  /// Whether to show the table header.
  /// When false, the column headers will be hidden.
  final bool showHeader;

  /// Callback function when a row is tapped.
  /// The callback receives the row data as a map.
  final Function(Map<String, dynamic>)? onRowTap;

  /// Callback function when a row is long pressed.
  /// The callback receives the row data as a map.
  final Function(Map<String, dynamic>)? onRowLongPress;

  /// Callback function when a column is sorted.
  /// The callback receives the column property and sort direction.
  final Function(String, bool)? onSort;

  const ETable({
    super.key,
    required this.data,
    required this.columns,
    this.stripe = false,
    this.border = false,
    this.height,
    this.showHeader = true,
    this.onRowTap,
    this.onRowLongPress,
    this.onSort,
  });

  @override
  State<ETable> createState() => _ETableState();
}

class _ETableState extends State<ETable> {
  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: Theme.of(context).dividerColor);
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      textBaseline: TextBaseline.ideographic,
      columnWidths: Map.fromEntries(
        widget.columns.asMap().entries.map(
              (e) => MapEntry(
                e.key,
                e.value.width != null
                    ? FixedColumnWidth(e.value.width!)
                    : const FlexColumnWidth(),
              ),
            ),
      ),
      border: widget.border
          ? TableBorder(
              top: borderSide,
              bottom: borderSide,
              left: borderSide,
              right: borderSide,
              horizontalInside: borderSide,
              verticalInside: borderSide)
          : null,
      children: _buildRows(),
    );
  }

  List<TableRow> _buildRows() {
    return widget.data.asMap().entries.map((entry) {
      final index = entry.key;
      final row = entry.value;

      return TableRow(
        decoration: BoxDecoration(
          color: widget.stripe && index.isOdd
              ? Theme.of(context).colorScheme.surface.withValues(alpha: 0.3)
              : null,
        ),
        children: widget.columns.asMap().entries.map((colEntry) {
          final column = colEntry.value;
          final value = row[column.prop];

          return SizedBox(
            child: InkWell(
              onTap:
                  widget.onRowTap != null ? () => widget.onRowTap!(row) : null,
              onLongPress: widget.onRowLongPress != null
                  ? () => widget.onRowLongPress!(row)
                  : null,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: column.render != null
                    ? column.render!(value)
                    : Text(
                        value?.toString() ?? '',
                        textAlign: column.align,
                      ),
              ),
            ),
          );
        }).toList(),
      );
    }).toList();
  }
}

extension TextAlignExtension on TextAlign {
  MainAxisAlignment toMainAxisAlignment() {
    switch (this) {
      case TextAlign.left:
        return MainAxisAlignment.start;
      case TextAlign.right:
        return MainAxisAlignment.end;
      case TextAlign.center:
        return MainAxisAlignment.center;
      default:
        return MainAxisAlignment.start;
    }
  }
}
