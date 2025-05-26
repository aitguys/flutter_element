import 'package:flutter/material.dart';

enum ETimelineItemType {
  primary,
  success,
  warning,
  info,
  danger,
}

class ETimelineItem {
  final String? timestamp;
  final Widget content;
  final ETimelineItemType type;
  final Color? color;
  final Widget? dot;
  final bool hollow;

  const ETimelineItem({
    this.timestamp,
    required this.content,
    this.type = ETimelineItemType.primary,
    this.color,
    this.dot,
    this.hollow = false,
  });
}

class ETimeline extends StatelessWidget {
  final List<ETimelineItem> items;
  final bool reverse;

  const ETimeline({
    super.key,
    required this.items,
    this.reverse = false,
  });

  Color _getColor(ETimelineItem item) {
    if (item.color != null) return item.color!;

    switch (item.type) {
      case ETimelineItemType.primary:
        return const Color(0xFF409EFF);
      case ETimelineItemType.success:
        return const Color(0xFF67C23A);
      case ETimelineItemType.warning:
        return const Color(0xFFE6A23C);
      case ETimelineItemType.info:
        return const Color(0xFF909399);
      case ETimelineItemType.danger:
        return const Color(0xFFF56C6C);
    }
  }

  Widget _buildDot(ETimelineItem item) {
    if (item.dot != null) return item.dot!;

    final color = _getColor(item);
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: item.hollow ? Colors.white : color,
        border: Border.all(color: color, width: 2),
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final timelineItems = reverse ? items.reversed.toList() : items;

    return Column(
      children: timelineItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isLast = index == timelineItems.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 24,
              child: Column(
                children: [
                  _buildDot(item),
                  if (!isLast)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Container(
                        width: 2,
                        height: 40,
                        color: _getColor(item),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.timestamp != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        item.timestamp!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  item.content,
                  if (!isLast) const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
