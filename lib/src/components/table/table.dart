import 'package:flutter/material.dart';

class ETableColumn {
  final String prop;
  final String label;
  final double? width;
  final Widget Function(dynamic)? render;
  final TextAlign? align;
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

class ETable extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final List<ETableColumn> columns;
  final bool stripe;
  final bool border;
  final double? height;
  final bool showHeader;
  final Function(Map<String, dynamic>)? onRowTap;
  final Function(Map<String, dynamic>)? onRowLongPress;
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
  String? _sortColumn;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: Theme.of(context).dividerColor);

    return Container(
      decoration: widget.border
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Theme.of(context).dividerColor),
            )
          : null,
      clipBehavior: widget.border ? Clip.antiAlias : Clip.none,
      child: Column(
        children: [
          if (widget.showHeader) _buildHeader(borderSide),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
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
                        horizontalInside: borderSide,
                        verticalInside: borderSide,
                      )
                    : null,
                children: _buildRows(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BorderSide borderSide) {
    return Container(
      decoration: BoxDecoration(
        border: widget.border ? Border(bottom: borderSide) : null,
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: widget.columns.asMap().entries.map((entry) {
          final column = entry.value;
          final isLast = entry.key == widget.columns.length - 1;

          return Expanded(
            flex: column.width != null ? 0 : 1,
            child: Container(
              width: column.width,
              decoration: widget.border && !isLast
                  ? BoxDecoration(
                      border: Border(right: borderSide),
                    )
                  : null,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: column.sortable
                  ? InkWell(
                      onTap: () => _onSort(column.prop),
                      child: Row(
                        mainAxisAlignment:
                            column.align?.toMainAxisAlignment() ??
                                MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              column.label,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (_sortColumn == column.prop)
                            Icon(
                              _sortAscending
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              size: 16,
                            ),
                        ],
                      ),
                    )
                  : Text(
                      column.label,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: column.align,
                    ),
            ),
          );
        }).toList(),
      ),
    );
  }

  List<TableRow> _buildRows() {
    final borderSide = BorderSide(color: Theme.of(context).dividerColor);

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
          final isLastColumn = colEntry.key == widget.columns.length - 1;
          final value = row[column.prop];

          return Container(
            decoration: widget.border && !isLastColumn
                ? BoxDecoration(
                    border: Border(right: borderSide),
                  )
                : null,
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

  void _onSort(String prop) {
    if (widget.onSort != null) {
      if (_sortColumn == prop) {
        _sortAscending = !_sortAscending;
      } else {
        _sortColumn = prop;
        _sortAscending = true;
      }
      widget.onSort!(prop, _sortAscending);
      setState(() {});
    }
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
