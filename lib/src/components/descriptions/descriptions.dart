import 'package:flutter/material.dart';

/// 描述项，包含标签和内容
class EDescriptionItem {
  /// label 和 labelWidget 表示同一内容，labelWidget 优先级更高
  final String label;
  final Widget? labelWidget;
  final Widget content;
  final int span;
  final double? labelWidth;
  final double? minWidth;
  final TextAlign? align;
  final TextAlign? labelAlign;
  final String? labelClassName;
  final String? className;
  final TextStyle? labelStyle; // 新增label样式

  const EDescriptionItem({
    required this.label,
    this.labelWidget,
    required this.content,
    this.span = 1,
    this.labelWidth,
    this.minWidth,
    this.align,
    this.labelAlign,
    this.labelClassName,
    this.className,
    this.labelStyle,
  });
}

/// 描述列表方向
enum EDescriptionsDirection {
  horizontal,
  vertical,
}

/// 美化后的描述列表组件
class EDescriptions extends StatelessWidget {
  final Widget? titleWidget;
  final String? title;
  final TextStyle? titleStyle;

  /// column 可选，不传时为 auto，自动换行
  final int column;
  final bool border;
  final List<EDescriptionItem> items;
  final EdgeInsetsGeometry? padding;
  final TextStyle? labelStyle; // 新增全局label样式
  final EDescriptionsDirection direction; // 新增方向属性

  const EDescriptions({
    super.key,
    this.title,
    this.titleWidget,
    this.titleStyle,
    this.column = 3,
    this.border = false,
    required this.items,
    this.padding,
    this.labelStyle,
    this.direction = EDescriptionsDirection.horizontal, // 默认水平
  });

  Color get _labelColor => Colors.black;
  Color get _contentColor => const Color(0xFF303133);
  // Color get _bgColor => Colors.white;
  Color get _borderColor => const Color(0xFFE4E7ED);

  @override
  Widget build(BuildContext context) {
    if (direction == EDescriptionsDirection.vertical) {
      // 垂直模式下也需要支持 column
      final List<TableRow> rows = [];
      int i = 0;
      while (i < items.length) {
        int col = 0;
        List<Widget> cells = [];
        while (col < column && i < items.length) {
          final item = items[i];
          int span = item.span;
          if (span > column - col) span = column - col;
          cells.add(_buildVerticalCell(item, span, i == 0, col == 0,
              i == items.length - 1, col == column - 1));
          col += span;
          i++;
        }
        // 补齐空单元格
        while (col < column) {
          cells.add(_buildEmptyCell(
              i == 0, col == 0, i == items.length, col == column - 1));
          col++;
        }
        rows.add(TableRow(children: cells));
      }

      return Container(
        // decoration: BoxDecoration(
        //   color: _bgColor,
        //   borderRadius: BorderRadius.circular(4),
        //   border: border ? Border.all(color: _borderColor, width: 1) : null,
        // ),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (titleWidget != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: titleWidget!,
                )
              else if (title != null && title!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _contentColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              Table(
                border: border
                    ? TableBorder.all(color: _borderColor, width: 1)
                    : const TableBorder(
                        horizontalInside: BorderSide.none,
                        verticalInside: BorderSide.none,
                      ),
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                children: rows,
              ),
            ],
          ),
        ),
      );
    }

    // 水平（表格）模式
    final List<TableRow> rows = [];
    int i = 0;
    while (i < items.length) {
      int col = 0;
      List<Widget> cells = [];
      while (col < column && i < items.length) {
        final item = items[i];
        int span = item.span;
        if (span > column - col) span = column - col;
        cells.add(_buildCell(item, span, rows.isEmpty, col == 0,
            i == items.length - 1, col == column - 1));
        col += span;
        i++;
      }
      // 补齐空单元格
      while (col < column) {
        cells.add(_buildEmptyCell(
            rows.isEmpty, col == 0, i == items.length, col == column - 1));
        col++;
      }
      rows.add(TableRow(children: cells));
    }

    return Container(
      // decoration: BoxDecoration(
      //   color: _bgColor,
      //   borderRadius: BorderRadius.circular(4),
      //   border: border ? Border.all(color: _borderColor, width: 1) : null,
      // ),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (titleWidget != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: titleWidget!,
              )
            else if (title != null && title!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  title!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _contentColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            Table(
              border: border
                  ? TableBorder.all(color: _borderColor, width: 1)
                  : const TableBorder(
                      horizontalInside: BorderSide.none,
                      verticalInside: BorderSide.none,
                    ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: rows,
            ),
          ],
        ),
      ),
    );
  }

  /// 空单元格（用于补齐表格，保证边框完整）
  Widget _buildEmptyCell(
      bool isFirstRow, bool isFirstCol, bool isLastRow, bool isLastCol) {
    return Container(
      height: 40,
      decoration: border
          ? BoxDecoration(
              color: Colors.white,
            )
          : null,
    );
  }

  /// 垂直模式下的单元格
  Widget _buildVerticalCell(EDescriptionItem item, int span, bool isFirstRow,
      bool isFirstCol, bool isLastRow, bool isLastCol) {
    final TextStyle defaultLabelStyle = TextStyle(
      fontSize: 15,
      color: _labelColor,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
    );
    final TextStyle mergedLabelStyle =
        defaultLabelStyle.merge(labelStyle).merge(item.labelStyle);

    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.top,
      child: Container(
        decoration: border
            ? BoxDecoration(
                color: Colors.white,
              )
            : null,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item.labelWidget != null
                ? DefaultTextStyle(
                    style: mergedLabelStyle,
                    child: item.labelWidget!,
                  )
                : Text(
                    item.label,
                    textAlign: item.labelAlign ?? TextAlign.left,
                    style: mergedLabelStyle,
                  ),
            const SizedBox(height: 6),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 14,
                color: _contentColor,
                fontWeight: FontWeight.normal,
              ),
              child: item.content,
            ),
          ],
        ),
      ),
    );
  }

  /// 表格模式下的单元格
  Widget _buildCell(EDescriptionItem item, int span, bool isFirstRow,
      bool isFirstCol, bool isLastRow, bool isLastCol) {
    final TextStyle defaultLabelStyle = TextStyle(
      fontSize: 15,
      color: _labelColor,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
    );
    final TextStyle mergedLabelStyle =
        defaultLabelStyle.merge(labelStyle).merge(item.labelStyle);

    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        decoration: border
            ? BoxDecoration(
                color: Colors.white,
              )
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                minWidth: item.labelWidth ?? 80,
                maxWidth: item.labelWidth ?? 120,
              ),
              margin: const EdgeInsets.only(right: 12),
              child: item.labelWidget != null
                  ? DefaultTextStyle(
                      style: mergedLabelStyle,
                      child: item.labelWidget!,
                    )
                  : Text(
                      item.label,
                      textAlign: item.labelAlign ?? TextAlign.left,
                      style: mergedLabelStyle,
                    ),
            ),
            Expanded(
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 14,
                  color: _contentColor,
                  fontWeight: FontWeight.normal,
                ),
                child: item.content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
