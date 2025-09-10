import 'package:flutter/material.dart';
import '../../theme/color.dart';
// import '../button/button.dart';

class EPaginationLayout {
  static const total = 'total';
  static const prev = 'prev';
  static const pager = 'pager';
  static const next = 'next';
  static const sizes = 'sizes';
  static const jumper = 'jumper';
}

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

  final List<String> layout; // layout="[total, prev, pager, next]"

  /// Whether to show the page jumper input.

  /// Color type for the pagination theme
  final EColorType colorType;
  final Color? customColor;
  final bool isRound;
  final bool showBackground;
  const EPagination({
    super.key,
    required this.total,
    this.pageSize = 10,
    this.currentPage = 1,
    this.pageSizes = const [10, 20, 50, 100],
    this.onPageChange,
    this.onPageSizeChange,
    this.layout = const [
      EPaginationLayout.prev,
      EPaginationLayout.pager,
      EPaginationLayout.next
    ],
    this.colorType = EColorType.primary,
    this.customColor,
    this.isRound = false,
    this.showBackground = true,
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

  /// Builds a widget component based on layout string
  Widget _buildLayoutComponent(String component) {
    switch (component) {
      case EPaginationLayout.total:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Total $total ',
            style: TextStyle(
              color: calculateContentColor(EColorTypes.default_),
              fontSize: 14,
            ),
          ),
        );

      case EPaginationLayout.prev:
        final isDisabled = currentPage <= 1;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: SizedBox(
            height: 32,
            width: 32,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: showBackground
                    ? const Color(0xFFF0F1F5)
                    : Colors.transparent,
                shape: isRound
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                minimumSize: const Size(32, 32),
              ),
              onPressed:
                  isDisabled ? null : () => onPageChange?.call(currentPage - 1),
              child: Icon(
                Icons.chevron_left,
                color: showBackground
                    ? (isDisabled
                        ? calculateContentColor(EColorTypes.default_,
                            isDisabled: true)
                        : calculateContentColor(EColorTypes.default_))
                    : (isDisabled
                        ? calculateContentColor(EColorTypes.default_,
                            isDisabled: true)
                        : calculateContentColor(EColorTypes.default_)),
                size: 20,
              ),
            ),
          ),
        );

      case EPaginationLayout.pager:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: pageList.map((p) {
            if (p == -1) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  '...',
                  style: TextStyle(
                    color: calculateContentColor(EColorTypes.default_),
                  ),
                ),
              );
            }

            final isActive = p == currentPage;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: SizedBox(
                height: 32,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: showBackground && isActive
                        ? (customColor ?? getColorByType(type: colorType))
                        : showBackground
                            ? const Color(0xFFF0F1F5)
                            : Colors.transparent,
                    shape: isRound
                        ? RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          )
                        : RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                    minimumSize: const Size(32, 32),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onPressed: isActive ? null : () => onPageChange?.call(p),
                  child: Text(
                    '$p',
                    style: TextStyle(
                      color: showBackground
                          ? (isActive
                              ? Colors.white
                              : calculateContentColor(EColorTypes.default_))
                          : (isActive
                              ? customColor ?? EColorTypes.primary
                              : calculateContentColor(EColorTypes.default_)),
                      fontWeight: showBackground && isActive
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );

      case EPaginationLayout.next:
        final isDisabled = currentPage >= pageCount;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: SizedBox(
            height: 32,
            width: 32,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: showBackground
                    ? const Color(0xFFF0F1F5)
                    : Colors.transparent,
                shape: isRound
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                minimumSize: const Size(32, 32),
              ),
              onPressed:
                  isDisabled ? null : () => onPageChange?.call(currentPage + 1),
              child: Icon(
                Icons.chevron_right,
                size: 20,
                color: showBackground
                    ? (isDisabled
                        ? calculateContentColor(EColorTypes.default_,
                            isDisabled: true)
                        : calculateContentColor(EColorTypes.default_))
                    : (isDisabled
                        ? calculateContentColor(EColorTypes.default_,
                            isDisabled: true)
                        : calculateContentColor(EColorTypes.default_)),
              ),
            ),
          ),
        );

      case EPaginationLayout.sizes:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButton<int>(
            value: pageSize,
            underline: Container(),
            style: TextStyle(
              color: calculateContentColor(EColorTypes.default_),
              fontSize: 14,
            ),
            items: pageSizes
                .map((s) => DropdownMenuItem(
                      value: s,
                      child: Text('$s/page'),
                    ))
                .toList(),
            onChanged: (v) => v != null ? onPageSizeChange?.call(v) : null,
          ),
        );

      case EPaginationLayout.jumper:
        return _Jumper(
          pageCount: pageCount,
          onJump: (p) {
            if (p >= 1 && p <= pageCount) onPageChange?.call(p);
          },
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build components in the exact order specified in layout array
    final List<Widget> orderedComponents = [];

    for (final component in layout) {
      // Check if component should be displayed based on flags
      bool shouldShow = true;
      switch (component) {
        case EPaginationLayout.total:
          shouldShow = true;
          break;
        case EPaginationLayout.sizes:
          shouldShow = true;
          break;
        case EPaginationLayout.jumper:
          shouldShow = true;
          break;
        default:
          shouldShow = true;
      }

      if (shouldShow) {
        orderedComponents.add(_buildLayoutComponent(component));
      }
    }

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      children: orderedComponents,
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
        const Text('Go to'),
        const SizedBox(width: 8),
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
      ],
    );
  }
}
