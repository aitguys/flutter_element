import 'package:flutter/material.dart';
import '../date_picker_model.dart';
import '../date_picker_style.dart';
import '../../../theme/index.dart';

class EDateCalendarView extends StatelessWidget {
  final DateTime displayMonth;
  final EDatePickerViewMode viewMode;
  final DateTime? selectedDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? hoverDate;
  final ValueChanged<DateTime> onDateClick;
  final ValueChanged<DateTime>? onHover;
  final ESizeItem size;

  const EDateCalendarView({
    super.key,
    required this.displayMonth,
    required this.viewMode,
    this.selectedDate,
    this.startDate,
    this.endDate,
    this.hoverDate,
    required this.onDateClick,
    this.onHover,
    this.size = ESizeItem.medium,
  });

  @override
  Widget build(BuildContext context) {
    switch (viewMode) {
      case EDatePickerViewMode.day:
        return _buildDayView(context);
      case EDatePickerViewMode.month:
        return _buildMonthView(context);
      case EDatePickerViewMode.year:
        return _buildYearView(context);
    }
  }

  Widget _buildDayView(BuildContext context) {
    final List<String> weekDays = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun'
    ];
    final DateTime firstDayOfMonth =
        DateTime(displayMonth.year, displayMonth.month, 1);
    final int daysInMonth =
        DateTime(displayMonth.year, displayMonth.month + 1, 0).day;

    // Adjust to start from Monday (1) to Sunday (7)
    int firstWeekday = firstDayOfMonth.weekday; // 1 = Mon, 7 = Sun

    final int prevMonthDays = firstWeekday - 1;
    final DateTime prevMonth =
        DateTime(displayMonth.year, displayMonth.month - 1);
    final int daysInPrevMonth =
        DateTime(prevMonth.year, prevMonth.month + 1, 0).day;

    List<DateTime> allDays = [];
    // Previous month days
    for (int i = prevMonthDays - 1; i >= 0; i--) {
      allDays.add(DateTime(
          displayMonth.year, displayMonth.month - 1, daysInPrevMonth - i));
    }
    // Current month days
    for (int i = 1; i <= daysInMonth; i++) {
      allDays.add(DateTime(displayMonth.year, displayMonth.month, i));
    }
    // Next month days - Dynamic row calculation
    int totalSoFar = allDays.length;
    int totalVisibleDays = ((totalSoFar / 7).ceil()) * 7;
    // Ensure at least 5 rows for visual consistency or just
    // strictly minimal as requested. The user said "最小行".
    int remaining = totalVisibleDays - totalSoFar;
    for (int i = 1; i <= remaining; i++) {
      allDays.add(DateTime(displayMonth.year, displayMonth.month + 1, i));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: weekDays
                .map((d) => Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text(d,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ),
                    ))
                .toList(),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(height: 1, color: Color(0xFFF2F6FC)),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 0,
            ),
            itemCount: allDays.length,
            itemBuilder: (context, index) {
              final date = allDays[index];
              final bool isCurrentMonth = date.month == displayMonth.month;
              return _buildDateCell(context, date, isCurrentMonth);
            },
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildDateCell(
      BuildContext context, DateTime date, bool isCurrentMonth) {
    bool isSelected = false;
    bool isInRange = false;
    bool isRangeStart = false;
    bool isRangeEnd = false;

    if (selectedDate != null && _isSameDay(date, selectedDate!)) {
      isSelected = true;
    }

    if (startDate != null && endDate != null) {
      if (_isSameDay(date, startDate!)) {
        isRangeStart = true;
        isSelected = true;
      } else if (_isSameDay(date, endDate!)) {
        isRangeEnd = true;
        isSelected = true;
      } else if (date.isAfter(startDate!) && date.isBefore(endDate!)) {
        isInRange = true;
      }
    } else if (startDate != null && hoverDate != null) {
      DateTime s = startDate!.isBefore(hoverDate!) ? startDate! : hoverDate!;
      DateTime e = startDate!.isBefore(hoverDate!) ? hoverDate! : startDate!;
      if (_isSameDay(date, s)) {
        isRangeStart = true;
      } else if (_isSameDay(date, e)) {
        isRangeEnd = true;
      } else if (date.isAfter(s) && date.isBefore(e)) {
        isInRange = true;
      }
    }

    final bool isToday = _isSameDay(date, DateTime.now());

    return MouseRegion(
      onEnter: (_) => onHover?.call(date),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onDateClick(date),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 0),
          decoration: BoxDecoration(
            color: isInRange
                ? const Color(0xFFF2F6FC)
                : (isRangeStart || isRangeEnd)
                    ? const Color(0xFFF2F6FC)
                    : Colors.transparent,
            borderRadius: _getBorderRadius(isRangeStart, isRangeEnd, isInRange),
          ),
          child: Center(
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected
                    ? EDatePickerStyle.selectedColor
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: isToday && !isSelected
                    ? Border.all(
                        color: EDatePickerStyle.selectedColor, width: 1)
                    : null,
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected
                        ? Colors.white
                        : (isCurrentMonth
                            ? (isToday
                                ? EDatePickerStyle.selectedColor
                                : Colors.black)
                            : const Color(0xFFC0C4CC)),
                    fontWeight: isSelected || isToday
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius? _getBorderRadius(bool isStart, bool isEnd, bool inRange) {
    if (isStart && isEnd) return BorderRadius.circular(15);
    if (isStart) {
      return const BorderRadius.horizontal(left: Radius.circular(15));
    }
    if (isEnd) return const BorderRadius.horizontal(right: Radius.circular(15));
    return null;
  }

  Widget _buildMonthView(BuildContext context) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 2,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        final month = index + 1;
        final bool isSelected = selectedDate?.year == displayMonth.year &&
            selectedDate?.month == month;
        final bool isCurrentMonth = DateTime.now().year == displayMonth.year &&
            DateTime.now().month == month;

        return _buildSelectionCell(months[index], isSelected, isCurrentMonth,
            () {
          onDateClick(DateTime(displayMonth.year, month, 1));
        });
      },
    );
  }

  Widget _buildYearView(BuildContext context) {
    final int startYear = (displayMonth.year ~/ 10) * 10;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 2,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        final year = startYear + index;
        final bool isSelected = selectedDate?.year == year;
        final bool isCurrentYear = DateTime.now().year == year;

        return _buildSelectionCell(year.toString(), isSelected, isCurrentYear,
            () {
          onDateClick(DateTime(year, 1, 1));
        });
      },
    );
  }

  Widget _buildSelectionCell(
      String label, bool isSelected, bool isCurrent, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? EDatePickerStyle.selectedColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: isCurrent && !isSelected
                ? Border.all(color: EDatePickerStyle.selectedColor, width: 1)
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.white : const Color(0xFF606266),
              fontWeight:
                  isSelected || isCurrent ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
