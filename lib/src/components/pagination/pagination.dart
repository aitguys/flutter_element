import 'package:flutter/material.dart';

/// A pagination component that follows Element Plus design guidelines.
///
/// The [EPagination] widget provides a customizable pagination interface with features like:
/// - Page navigation with previous/next buttons
/// - Page number display with ellipsis for long ranges
/// - Page size selection
/// - Page jumper
/// - Total count display
///
/// Example:
/// ```dart
/// EPagination(
///   total: 100,
///   pageSize: 10,
///   currentPage: 1,
///   pageSizes: [10, 20, 50, 100],
///   showSizeChanger: true,
///   showJumper: true,
///   onPageChange: (page) {
///     print('Page changed to: $page');
///   },
///   onPageSizeChange: (size) {
///     print('Page size changed to: $size');
///   },
/// )
/// ```
class EPagination extends StatelessWidget {
  /// The total number of items to paginate.
  final int total;

  /// The number of items per page.
  /// Default is 10.
  final int pageSize;

  /// The current active page.
  /// Default is 1.
  final int currentPage;

  /// The available page size options.
  /// Default is [10, 20, 50, 100].
  final List<int> pageSizes;

  /// Callback function when the page changes.
  /// The callback receives the new page number.
  final ValueChanged<int>? onPageChange;

  /// Callback function when the page size changes.
  /// The callback receives the new page size.
  final ValueChanged<int>? onPageSizeChange;

  /// Whether to show the page size selector.
  /// Default is false.
  final bool showSizeChanger;

  /// Whether to show the page jumper input.
  /// Default is false.
  final bool showJumper;

  const EPagination({
    super.key,
    required this.total,
    this.pageSize = 10,
    this.currentPage = 1,
    this.pageSizes = const [10, 20, 50, 100],
    this.onPageChange,
    this.onPageSizeChange,
    this.showSizeChanger = false,
    this.showJumper = false,
  });

  /// Calculates the total number of pages based on total items and page size.
  int get pageCount => (total / pageSize).ceil();

  /// Generates the list of page numbers to display, including ellipsis for long ranges.
  ///
  /// The list includes:
  /// - First page
  /// - Ellipsis (...) if needed
  /// - Pages around the current page
  /// - Last page
  List<int> get pageList {
    if (pageCount <= 7) {
      return List.generate(pageCount, (i) => i + 1);
    } else {
      List<int> list = [1];
      if (currentPage > 4) list.add(-1); // -1 代表 ...
      int start = currentPage - 1;
      int end = currentPage + 1;
      if (start < 2) start = 2;
      if (end > pageCount - 1) end = pageCount - 1;
      for (int i = start; i <= end; i++) {
        list.add(i);
      }
      if (end < pageCount - 1) list.add(-1);
      list.add(pageCount);
      return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: currentPage > 1
              ? () => onPageChange?.call(currentPage - 1)
              : null,
        ),
        ...pageList.map((p) => p == -1
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text('...'),
              )
            : TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: p == currentPage ? Colors.blue : null,
                  foregroundColor:
                      p == currentPage ? Colors.white : Colors.black87,
                  minimumSize: const Size(36, 36),
                  padding: EdgeInsets.zero,
                ),
                onPressed:
                    p == currentPage ? null : () => onPageChange?.call(p),
                child: Text('$p'),
              )),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: currentPage < pageCount
              ? () => onPageChange?.call(currentPage + 1)
              : null,
        ),
        if (showSizeChanger)
          DropdownButton<int>(
            value: pageSize,
            items: pageSizes
                .map((s) => DropdownMenuItem(value: s, child: Text('$s/页')))
                .toList(),
            onChanged: (v) => v != null ? onPageSizeChange?.call(v) : null,
          ),
        if (showJumper)
          _Jumper(
            pageCount: pageCount,
            onJump: (p) {
              if (p >= 1 && p <= pageCount) onPageChange?.call(p);
            },
          ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text('共 $total 条'),
        ),
      ],
    );
  }
}

/// A widget for jumping to a specific page number.
///
/// The [_Jumper] provides a text input field where users can enter a page number
/// to jump to. It validates the input and calls the provided callback when a
/// valid page number is entered.
class _Jumper extends StatefulWidget {
  /// The total number of pages available.
  final int pageCount;

  /// Callback function when a valid page number is entered.
  /// The callback receives the target page number.
  final ValueChanged<int> onJump;

  const _Jumper({required this.pageCount, required this.onJump});
  @override
  State<_Jumper> createState() => _JumperState();
}

class _JumperState extends State<_Jumper> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('跳至'),
        SizedBox(
          width: 40,
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 14),
            decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 4)),
            onSubmitted: (v) {
              final p = int.tryParse(v);
              if (p != null) widget.onJump(p);
            },
          ),
        ),
        const Text('页'),
      ],
    );
  }
}
