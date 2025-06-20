import 'package:flutter/material.dart';
import 'date_picker_style.dart';
import 'package:intl/intl.dart';
import '../button/button.dart';
import '../../theme/index.dart';

String getDefaultFormat(CalendarType type) {
  switch (type) {
    case CalendarType.year:
      return 'yyyy';
    case CalendarType.years:
      return 'yyyy';
    case CalendarType.month:
      return 'yyyy-MM';
    case CalendarType.months:
      return 'yyyy-MM';
    case CalendarType.date:
      return 'yyyy-MM-dd';
    case CalendarType.dates:
      return 'yyyy-MM-dd';
  }
}

enum CalendarType {
  year,
  years,
  month,
  months,
  date,
  dates,
  // datetime,
  // week,
  // time,
  // datetimerange,
  // daterange,
  // monthrange,
  // yearrange,
}

class Calendar extends StatefulWidget {
  final String? initialDate;
  final CalendarType type;
  final DateTime? minDate;
  final DateTime? maxDate;
  final List<DateTime>? initialRange;
  final ValueChanged<dynamic>? onSelect;
  final Widget? prevMonth;
  final Widget? nextMonth;
  final Widget? prevYear;
  final Widget? nextYear;
  final String? format;
  final bool weekDate;
  final ESizeItem size;

  const Calendar({
    super.key,
    this.initialDate,
    this.type = CalendarType.date,
    this.minDate,
    this.maxDate,
    this.initialRange,
    this.onSelect,
    this.prevMonth,
    this.nextMonth,
    this.prevYear,
    this.nextYear,
    this.format,
    this.weekDate = false,
    this.size = ESizeItem.medium,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  String? _selectedDate;
  List<String>? _selectedDates;
  // List<DateTime>? _selectedRange;
  late DateTime _currentMonth;

  double get _cellWidth {
    switch (widget.size) {
      case ESizeItem.large:
        return 52;
      case ESizeItem.small:
        return 36;
      case ESizeItem.medium:
      default:
        return 45;
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case ESizeItem.large:
        return 16;
      case ESizeItem.small:
        return 12;
      case ESizeItem.medium:
      default:
        return 14;
    }
  }

  double get _headerFontSize {
    switch (widget.size) {
      case ESizeItem.large:
        return 18;
      case ESizeItem.small:
        return 14;
      case ESizeItem.medium:
      default:
        return 16;
    }
  }

  double get _iconSize {
    switch (widget.size) {
      case ESizeItem.large:
        return 24;
      case ESizeItem.small:
        return 16;
      case ESizeItem.medium:
      default:
        return 20;
    }
  }

  @override
  void initState() {
    super.initState();

    _selectedDate = widget.initialDate;
    _selectedDates = [];
    // _selectedRange = widget.initialRange;
    _currentMonth = widget.initialDate != null
        ? DateFormat(widget.format ?? getDefaultFormat(widget.type))
            .parse(widget.initialDate!)
        : DateTime.now();

    if (widget.initialDate != null && widget.initialDate!.isNotEmpty) {
      _selectedDates = widget.initialDate!.split(',').toList();
    }
  }

  @override
  void didUpdateWidget(Calendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate) {
      _selectedDate = widget.initialDate;
      if (widget.initialDate != null) {
        final date = DateFormat(widget.format ?? getDefaultFormat(widget.type))
            .parse(widget.initialDate!);
        _currentMonth = DateTime(date.year, date.month);
      }
    }

    if (widget.initialRange != oldWidget.initialRange) {
      // _selectedRange = widget.initialRange;
    }
  }

  Widget _buildHeader() {
    switch (widget.type) {
      case CalendarType.year:
      case CalendarType.years:
        return _buildYearHeader();
      case CalendarType.month:
      case CalendarType.months:
        return _buildMonthHeader();
      case CalendarType.date:
      case CalendarType.dates:
        return _buildDateHeader();
      // default:
      //   return _buildDateHeader();
    }
  }

  Widget _buildYearHeader() {
    final int currentYear = _currentMonth.year;
    final int decadeStart = (currentYear ~/ 10) * 10;
    final int decadeEnd = decadeStart + 9;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEBEEF5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: widget.prevYear ??
                Icon(Icons.keyboard_double_arrow_left, size: _iconSize),
            onPressed: () {
              setState(() {
                _currentMonth = DateTime(
                  _currentMonth.year - 10,
                  _currentMonth.month,
                );
              });
            },
          ),
          Text(
            '$decadeStart - $decadeEnd',
            style: TextStyle(
              fontSize: _headerFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: widget.nextYear ??
                Icon(Icons.keyboard_double_arrow_right, size: _iconSize),
            onPressed: () {
              setState(() {
                _currentMonth = DateTime(
                  _currentMonth.year + 10,
                  _currentMonth.month,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMonthHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEBEEF5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: widget.prevMonth ?? Icon(Icons.chevron_left, size: _iconSize),
            onPressed: () {
              setState(() {
                _currentMonth = DateTime(
                  _currentMonth.year - 1,
                  _currentMonth.month,
                );
              });
            },
          ),
          Text(
            _currentMonth.year.toString(),
            style: TextStyle(
              fontSize: _headerFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon:
                widget.nextMonth ?? Icon(Icons.chevron_right, size: _iconSize),
            onPressed: () {
              setState(() {
                _currentMonth = DateTime(
                  _currentMonth.year + 1,
                  _currentMonth.month,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateHeader() {
    final monthName =
        DateFormat(widget.format ?? 'MMMM yyyy').format(_currentMonth);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEBEEF5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: widget.prevYear ??
                    Icon(Icons.keyboard_double_arrow_left, size: _iconSize),
                onPressed: () {
                  setState(() {
                    _currentMonth =
                        DateTime(_currentMonth.year - 1, _currentMonth.month);
                  });
                },
              ),
              IconButton(
                icon: widget.prevMonth ??
                    Icon(Icons.chevron_left, size: _iconSize),
                onPressed: () {
                  setState(() {
                    _currentMonth =
                        DateTime(_currentMonth.year, _currentMonth.month - 1);
                  });
                },
              ),
            ],
          ),
          Text(
            monthName,
            style: TextStyle(
              fontSize: _headerFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: widget.nextMonth ??
                    Icon(Icons.chevron_right, size: _iconSize),
                onPressed: () {
                  setState(() {
                    _currentMonth =
                        DateTime(_currentMonth.year, _currentMonth.month + 1);
                  });
                },
              ),
              IconButton(
                icon: widget.nextYear ??
                    Icon(Icons.keyboard_double_arrow_right, size: _iconSize),
                onPressed: () {
                  setState(() {
                    _currentMonth =
                        DateTime(_currentMonth.year + 1, _currentMonth.month);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDays() {
    if (widget.weekDate && widget.type == CalendarType.date) {
      return const SizedBox.shrink(); // Hide week days in week view
    }
    const weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEBEEF5))),
      ),
      child: Row(
        children: weekDays
            .map((day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        color: const Color(0xFF606266),
                        fontSize: _fontSize,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    switch (widget.type) {
      case CalendarType.year:
      case CalendarType.years:
        return _buildYearGrid();
      case CalendarType.month:
      case CalendarType.months:
        return _buildMonthGrid();
      case CalendarType.date:
      case CalendarType.dates:
        return _buildDateGrid();
      // default:
      //   return _buildDateGrid();
    }
  }

  // 添加一个辅助方法来检查日期是否在允许范围内
  bool _isDateInRange(DateTime date) {
    if (widget.minDate != null && date.isBefore(widget.minDate!)) {
      return false;
    }
    if (widget.maxDate != null && date.isAfter(widget.maxDate!)) {
      return false;
    }
    return true;
  }

  Widget _buildYearGrid() {
    final int currentYear = _currentMonth.year;
    final int decadeStart = (currentYear ~/ 10) * 10;
    List<Widget> years = List.generate(10, (index) {
      final int year = decadeStart + index;
      final DateTime yearDate = DateTime(year);
      bool isInRange = _isDateInRange(yearDate);
      bool isSelected = false;
      if (widget.type == CalendarType.years) {
        isSelected = _selectedDates?.any((d) =>
                DateFormat(widget.format ?? 'yyyy').parse(d).year == year) ??
            false;
      } else {
        isSelected = _selectedDate != null
            ? DateFormat(widget.format ?? 'yyyy').parse(_selectedDate!).year ==
                year
            : false;
      }
      final bool isToday = year == DateTime.now().year;
      return MouseRegion(
        cursor: isInRange ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: () {
            if (!isInRange) return; // 如果年份不在范围内，不处理点击
            setState(() {
              if (widget.type == CalendarType.years) {
                final yearDate = DateTime(year);
                if (_selectedDates == null) {
                  _selectedDates = [
                    DateFormat(widget.format ?? 'yyyy').format(yearDate)
                  ];
                } else {
                  if (_selectedDates!.any((d) =>
                      DateFormat(widget.format ?? 'yyyy').parse(d).year ==
                      year)) {
                    _selectedDates = List<String>.from(_selectedDates!)
                      ..removeWhere((d) =>
                          DateFormat(widget.format ?? 'yyyy').parse(d).year ==
                          year);
                  } else {
                    _selectedDates = List<String>.from(_selectedDates!)
                      ..add(
                          DateFormat(widget.format ?? 'yyyy').format(yearDate));
                  }
                }
              } else {
                _selectedDate = year.toString();
                widget.onSelect?.call(_selectedDate!);
              }
            });
          },
          child: Container(
            height: _cellWidth,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: _selectedDates?.any((d) =>
                              DateFormat(widget.format ?? 'yyyy')
                                  .parse(d)
                                  .year ==
                              year) ==
                          true ||
                      isSelected
                  ? EDatePickerStyle.selectedColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: isToday
                  ? Border.all(color: EDatePickerStyle.selectedColor)
                  : null,
            ),
            child: Text(
              DateFormat('yyyy').format(DateTime(year)),
              style: TextStyle(
                color: !isInRange
                    ? const Color(0xFFCCCCCC) // 超出范围的年份显示为灰色
                    : _selectedDates?.any((d) =>
                                    DateFormat(widget.format ?? 'yyyy')
                                        .parse(d)
                                        .year ==
                                    year) ==
                                true ||
                            isSelected
                        ? Colors.white
                        : const Color(0xFF606266),
                fontSize: _fontSize,
              ),
            ),
          ),
        ),
      );
    });
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          for (int i = 0; i < years.length; i += 3)
            Row(
              children: [
                for (int j = 0; j < 3; j++)
                  if (i + j < years.length)
                    Expanded(child: years[i + j])
                  else
                    const Expanded(child: SizedBox()),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildMonthGrid() {
    List<Widget> months = List.generate(12, (index) {
      final int month = index + 1;
      final DateTime monthDate = DateTime(_currentMonth.year, month);
      bool isInRange = _isDateInRange(monthDate);
      // bool isSelected = false;
      if (widget.type == CalendarType.months) {
        // isSelected = _selectedDates?.any((d) =>
        //         DateFormat(widget.format ?? 'yyyy-MM').parse(d).year ==
        //             _currentMonth.year &&
        //         DateFormat(widget.format ?? 'yyyy-MM').parse(d).month ==
        //             month) ??
        //     false;
      } else {
        // isSelected = _selectedDate != null
        //     ? DateFormat(widget.format ?? 'yyyy-MM')
        //                 .parse(_selectedDate!)
        //                 .year ==
        //             _currentMonth.year &&
        //         DateFormat(widget.format ?? 'yyyy-MM')
        //                 .parse(_selectedDate!)
        //                 .month ==
        //             month
        //     : false;
      }
      final bool isToday = _currentMonth.year == DateTime.now().year &&
          month == DateTime.now().month;
      return MouseRegion(
        cursor: isInRange ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: () {
            if (!isInRange) return; // 如果月份不在范围内，不处理点击
            setState(() {
              if (widget.type == CalendarType.months) {
                if (_selectedDates == null) {
                  _selectedDates = [
                    DateFormat(widget.format ?? 'yyyy-MM')
                        .format(DateTime(_currentMonth.year, month))
                  ];
                } else if (_selectedDates!.any((d) =>
                    DateFormat(widget.format ?? 'yyyy-MM').parse(d).year ==
                        _currentMonth.year &&
                    DateFormat(widget.format ?? 'yyyy-MM').parse(d).month ==
                        month)) {
                  _selectedDates!.removeWhere((d) =>
                      DateFormat(widget.format ?? 'yyyy-MM').parse(d).year ==
                          _currentMonth.year &&
                      DateFormat(widget.format ?? 'yyyy-MM').parse(d).month ==
                          month);
                } else {
                  _selectedDates!.add(DateFormat(widget.format ?? 'yyyy-MM')
                      .format(DateTime(_currentMonth.year, month)));
                }
              } else if (widget.type == CalendarType.month) {
                _selectedDate = DateFormat(widget.format ?? 'yyyy-MM')
                    .format(DateTime(_currentMonth.year, month));
                widget.onSelect?.call(_selectedDate!);
                return;
              } else {
                _selectedDate = DateFormat(widget.format ?? 'yyyy-MM')
                    .format(DateTime(_currentMonth.year, month));
                widget.onSelect?.call(_selectedDate!);
              }
            });
          },
          child: Container(
            height: _cellWidth,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: _selectedDates?.any((d) =>
                          DateFormat(widget.format ?? 'yyyy-MM')
                                  .parse(d)
                                  .year ==
                              _currentMonth.year &&
                          DateFormat(widget.format ?? 'yyyy-MM')
                                  .parse(d)
                                  .month ==
                              month) ==
                      true
                  ? EDatePickerStyle.selectedColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: isToday
                  ? Border.all(color: EDatePickerStyle.selectedColor)
                  : null,
            ),
            child: Text(
              DateFormat('MMM').format(DateTime(2000, month)),
              style: TextStyle(
                color: !isInRange
                    ? const Color(0xFFCCCCCC) // 超出范围的月份显示为灰色
                    : _selectedDates?.any((d) =>
                                DateFormat(widget.format ?? 'yyyy-MM')
                                        .parse(d)
                                        .year ==
                                    _currentMonth.year &&
                                DateFormat(widget.format ?? 'yyyy-MM')
                                        .parse(d)
                                        .month ==
                                    month) ==
                            true
                        ? Colors.white
                        : const Color(0xFF606266),
                fontSize: _fontSize,
              ),
            ),
          ),
        ),
      );
    });
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          for (int i = 0; i < months.length; i += 3)
            Row(
              children: [
                for (int j = 0; j < 3; j++)
                  if (i + j < months.length)
                    Expanded(child: months[i + j])
                  else
                    const Expanded(child: SizedBox()),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDateGrid() {
    if (widget.weekDate && widget.type == CalendarType.date) {
      return _buildWeekGrid();
    }
    final DateTime firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month, 1);
    final int daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    int firstWeekday = firstDayOfMonth.weekday;
    firstWeekday = firstWeekday == 7 ? 0 : firstWeekday;
    final DateTime prevMonth =
        DateTime(_currentMonth.year, _currentMonth.month - 1);
    final int daysInPrevMonth =
        DateTime(prevMonth.year, prevMonth.month + 1, 0).day;
    // 生成42个日期对象
    List<DateTime> dayList = List.generate(42, (index) {
      final int day = index - firstWeekday + 1;
      if (day <= 0) {
        return DateTime(
            _currentMonth.year, _currentMonth.month - 1, daysInPrevMonth + day);
      } else if (day > daysInMonth) {
        return DateTime(
            _currentMonth.year, _currentMonth.month + 1, day - daysInMonth);
      } else {
        return DateTime(_currentMonth.year, _currentMonth.month, day);
      }
    });
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(6, (i) {
        return Row(
          children: List.generate(7, (j) {
            int idx = i * 7 + j;
            DateTime date = dayList[idx];
            final bool isCurrentMonth = date.month == _currentMonth.month;
            bool isSelected = false;
            if (widget.type == CalendarType.dates) {
              // 循环 _selectedDates 输出   DateFormat(widget.format ?? 'yyyy-MM-dd') .parse(d)

              isSelected = _selectedDates?.any((d) =>
                      DateFormat(widget.format ?? 'yyyy-MM-dd')
                          .parse(d)
                          .isAtSameMomentAs(date)) ??
                  false;
            } else {
              isSelected = _selectedDate != null &&
                  DateFormat(widget.format ?? 'yyyy-MM-dd')
                      .parse(_selectedDate!)
                      .isAtSameMomentAs(date);
            }
            bool isToday = date.isAtSameMomentAs(DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day));
            return Expanded(
              child: MouseRegion(
                cursor: _isDateInRange(date) && isCurrentMonth
                    ? SystemMouseCursors.click
                    : SystemMouseCursors.basic,
                child: GestureDetector(
                  onTap: () {
                    // 检查日期是否在允许范围内
                    if (!_isDateInRange(date)) {
                      return;
                    }
                    setState(() {
                      if (!isCurrentMonth) {
                        _currentMonth = DateTime(date.year, date.month);
                      }
                      if (widget.type == CalendarType.dates) {
                        if (_selectedDates == null) {
                          _selectedDates = [
                            DateFormat(widget.format ?? 'yyyy-MM-dd')
                                .format(date)
                          ];
                        } else if (_selectedDates!.any((d) =>
                            DateFormat(widget.format ?? 'yyyy-MM-dd')
                                .parse(d)
                                .isAtSameMomentAs(date))) {
                          _selectedDates!.removeWhere((d) =>
                              DateFormat(widget.format ?? 'yyyy-MM-dd')
                                  .parse(d)
                                  .isAtSameMomentAs(date));
                        } else {
                          _selectedDates!.add(
                              DateFormat(widget.format ?? 'yyyy-MM-dd')
                                  .format(date));
                        }
                      } else {
                        _selectedDate =
                            DateFormat(widget.format ?? 'yyyy-MM-dd')
                                .format(date);
                        widget.onSelect?.call(_selectedDate!);
                      }
                    });
                  },
                  child: Container(
                    height: _cellWidth,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: _selectedDates?.any((d) =>
                                      DateFormat(widget.format ?? 'yyyy-MM-dd')
                                          .parse(d)
                                          .isAtSameMomentAs(date)) ==
                                  true ||
                              isSelected
                          ? EDatePickerStyle.selectedColor
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: isToday
                          ? Border.all(color: EDatePickerStyle.selectedColor)
                          : null,
                    ),
                    child: Text(
                      DateFormat('dd').format(date),
                      style: TextStyle(
                        color: !_isDateInRange(date)
                            ? const Color(0xFFCCCCCC) // 超出范围的日期显示为灰色
                            : _selectedDates?.any((d) => DateFormat(
                                                widget.format ?? 'yyyy-MM-dd')
                                            .parse(d)
                                            .isAtSameMomentAs(date)) ==
                                        true ||
                                    isSelected
                                ? Colors.white
                                : !isCurrentMonth
                                    ? const Color(0xFFCCCCCC)
                                    : const Color(0xFF606266),
                        fontSize: _fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  Widget _buildWeekGrid() {
    final DateTime firstDayOfWeek =
        _currentMonth.subtract(Duration(days: _currentMonth.weekday - 1));
    List<DateTime> weekDays =
        List.generate(7, (index) => firstDayOfWeek.add(Duration(days: index)));

    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left, size: _iconSize),
          onPressed: () {
            setState(() {
              _currentMonth = _currentMonth.subtract(const Duration(days: 7));
            });
          },
        ),
        Expanded(
          child: Row(
            children: weekDays.map((date) {
              bool isSelected = _selectedDate != null &&
                  DateFormat(widget.format ?? 'yyyy-MM-dd')
                      .parse(_selectedDate!)
                      .isAtSameMomentAs(date);
              bool isToday = date.isAtSameMomentAs(DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day));

              return Expanded(
                child: MouseRegion(
                  cursor: _isDateInRange(date)
                      ? SystemMouseCursors.click
                      : SystemMouseCursors.basic,
                  child: GestureDetector(
                    onTap: () {
                      if (!_isDateInRange(date)) return;
                      setState(() {
                        _selectedDate =
                            DateFormat(widget.format ?? 'yyyy-MM-dd')
                                .format(date);
                        widget.onSelect?.call(_selectedDate!);
                      });
                    },
                    child: Container(
                      height: _cellWidth,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? EDatePickerStyle.selectedColor
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: isToday
                            ? Border.all(color: EDatePickerStyle.selectedColor)
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('E').format(date),
                            style: TextStyle(
                              color: !_isDateInRange(date)
                                  ? const Color(0xFFCCCCCC)
                                  : isSelected
                                      ? Colors.white
                                      : const Color(0xFF606266),
                              fontSize: _fontSize - 2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            DateFormat('dd').format(date),
                            style: TextStyle(
                              color: !_isDateInRange(date)
                                  ? const Color(0xFFCCCCCC)
                                  : isSelected
                                      ? Colors.white
                                      : const Color(0xFF606266),
                              fontSize: _fontSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right, size: _iconSize),
          onPressed: () {
            setState(() {
              _currentMonth = _currentMonth.add(const Duration(days: 7));
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMulti = widget.type == CalendarType.dates ||
        widget.type == CalendarType.months ||
        widget.type == CalendarType.years;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(),
        if (widget.type == CalendarType.date ||
            widget.type == CalendarType.dates)
          _buildWeekDays(),
        _buildCalendarGrid(),
        if (isMulti)
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 60,
                  child: EButton(
                    size: ESizeItem.small,
                    type: EColorType.default_,
                    onPressed: () {
                      setState(() {
                        _selectedDates?.clear();
                      });
                      widget.onSelect?.call(null);
                    },
                    text: 'Cancel',
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 40,
                  child: EButton(
                    size: ESizeItem.small,
                    type: EColorType.primary,
                    onPressed: () {
                      List<String> selected = _selectedDates ?? [];
                      String result = selected.join(',');
                      widget.onSelect?.call(result);
                    },
                    text: 'Ok',
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
      ],
    );
  }
}

Future<T?> showCalendarDialog<T>(
  BuildContext context, {
  String? initialDate,
  CalendarType type = CalendarType.date,
  DateTime? minDate,
  DateTime? maxDate,
  List<DateTime>? initialRange,
  ValueChanged<dynamic>? onSelect,
  Widget? prevMonth,
  Widget? nextMonth,
  Widget? prevYear,
  Widget? nextYear,
  String? format,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return PopScope(
        canPop: true,
        child: Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Calendar(
              initialDate: initialDate,
              type: type,
              minDate: minDate,
              maxDate: maxDate,
              initialRange: initialRange,
              onSelect: (value) {
                onSelect?.call(value);
                if (context.mounted && Navigator.canPop(context)) {
                  Navigator.of(context).pop(value);
                }
              },
              prevMonth: prevMonth,
              nextMonth: nextMonth,
              prevYear: prevYear,
              nextYear: nextYear,
              format: format,
            ),
          ),
        ),
      );
    },
  );
}
