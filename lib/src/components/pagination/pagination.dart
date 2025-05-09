import 'package:flutter/material.dart';

class EPagination extends StatelessWidget {
  final int total;
  final int pageSize;
  final int currentPage;
  final List<int> pageSizes;
  final ValueChanged<int>? onPageChange;
  final ValueChanged<int>? onPageSizeChange;
  final bool showSizeChanger;
  final bool showJumper;

  const EPagination({
    Key? key,
    required this.total,
    this.pageSize = 10,
    this.currentPage = 1,
    this.pageSizes = const [10, 20, 50, 100],
    this.onPageChange,
    this.onPageSizeChange,
    this.showSizeChanger = false,
    this.showJumper = false,
  }) : super(key: key);

  int get pageCount => (total / pageSize).ceil();

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

class _Jumper extends StatefulWidget {
  final int pageCount;
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
