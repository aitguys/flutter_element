import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';
import 'date_picker_style.dart';
import 'package:intl/intl.dart';

enum DatePickerType {
  year,
  years,
  month,
  months,
  date,
  dates,
  datetime,
  week,
  datetimerange,
  daterange,
  monthrange,
  yearrange,
}

class EDatePicker extends StatefulWidget {
  final DateTime? value;
  final ValueChanged<DateTime>? onChange;
  final SizeItem size;
  final String? placeholder;
  final bool disabled;
  final bool clearable;
  final bool editable;
  final String format;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool range;
  final List<DateTime>? rangeValue;
  final ValueChanged<List<DateTime>>? onRangeChange;
  final VoidCallback? onTap;
  final VoidCallback? onPrefixTap;
  final DatePickerType type;
  final List<DateTime>? selectedDates;
  final ValueChanged<List<DateTime>>? onDatesChange;
  final DateTime? selectedWeek;
  final ValueChanged<DateTime>? onWeekChange;
  final List<DateTime>? selectedMonths;
  final ValueChanged<List<DateTime>>? onMonthsChange;
  final List<DateTime>? selectedYears;
  final ValueChanged<List<DateTime>>? onYearsChange;

  const EDatePicker({
    super.key,
    this.value,
    this.onChange,
    this.placeholder = 'Select date',
    this.disabled = false,
    this.clearable = true,
    this.editable = true,
    this.format = 'yyyy-MM-dd',
    this.size = SizeItem.medium,
    this.minDate,
    this.maxDate,
    this.range = false,
    this.rangeValue,
    this.onRangeChange,
    this.onTap,
    this.onPrefixTap,
    this.type = DatePickerType.date,
    this.selectedDates,
    this.onDatesChange,
    this.selectedWeek,
    this.onWeekChange,
    this.selectedMonths,
    this.onMonthsChange,
    this.selectedYears,
    this.onYearsChange,
  });

  @override
  State<EDatePicker> createState() => _EDatePickerState();
}

class _EDatePickerState extends State<EDatePicker> {
  final TextEditingController _controller = TextEditingController();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  DateTime? _selectedDate;
  List<DateTime>? _selectedRange;
  List<DateTime>? _selectedDates;
  DateTime? _selectedWeek;
  List<DateTime>? _selectedMonths;
  List<DateTime>? _selectedYears;
  bool _isOpen = false;
  late DateTime _currentMonth;
  DateTime? _hoveredDate;
  bool _isHovered = false;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.value;
    _selectedRange = widget.rangeValue;
    _selectedDates = widget.selectedDates;
    _selectedWeek = widget.selectedWeek;
    _selectedMonths = widget.selectedMonths;
    _selectedYears = widget.selectedYears;
    _currentMonth = _selectedDate ?? DateTime.now();
    _updateController();
  }

  @override
  void didUpdateWidget(EDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _selectedDate = widget.value;
      _updateController();
    }
    if (widget.rangeValue != oldWidget.rangeValue) {
      _selectedRange = widget.rangeValue;
      _updateController();
    }
    if (widget.selectedDates != oldWidget.selectedDates) {
      _selectedDates = widget.selectedDates;
      _updateController();
    }
    if (widget.selectedWeek != oldWidget.selectedWeek) {
      _selectedWeek = widget.selectedWeek;
      _updateController();
    }
    if (widget.selectedMonths != oldWidget.selectedMonths) {
      _selectedMonths = widget.selectedMonths;
      _updateController();
    }
    if (widget.selectedYears != oldWidget.selectedYears) {
      _selectedYears = widget.selectedYears;
      _updateController();
    }
  }

  void _updateController() {
    switch (widget.type) {
      case DatePickerType.year:
        _controller.text =
            _selectedDate != null ? _formatDate(_selectedDate!) : '';
        break;
      case DatePickerType.years:
        _controller.text = _selectedYears != null && _selectedYears!.isNotEmpty
            ? _selectedYears!.map((date) => _formatDate(date)).join(', ')
            : '';
        break;
      case DatePickerType.month:
        _controller.text =
            _selectedDate != null ? _formatDate(_selectedDate!) : '';
        break;
      case DatePickerType.months:
        _controller.text =
            _selectedMonths != null && _selectedMonths!.isNotEmpty
                ? _selectedMonths!.map((date) => _formatDate(date)).join(', ')
                : '';
        break;
      case DatePickerType.date:
        _controller.text =
            _selectedDate != null ? _formatDate(_selectedDate!) : '';
        break;
      case DatePickerType.dates:
        _controller.text = _selectedDates != null && _selectedDates!.isNotEmpty
            ? _selectedDates!.map((date) => _formatDate(date)).join(', ')
            : '';
        break;
      case DatePickerType.datetime:
        _controller.text = _selectedDate != null
            ? '${_formatDate(_selectedDate!)} ${_selectedTime?.format(context) ?? ''}'
            : '';
        break;
      case DatePickerType.week:
        _controller.text =
            _selectedWeek != null ? _formatWeek(_selectedWeek!) : '';
        break;
      case DatePickerType.daterange:
      case DatePickerType.monthrange:
      case DatePickerType.yearrange:
        if (_selectedRange != null && _selectedRange!.length == 2) {
          _controller.text =
              '${_formatDate(_selectedRange![0])} - ${_formatDate(_selectedRange![1])}';
        } else {
          _controller.text = '';
        }
        break;
      case DatePickerType.datetimerange:
        if (_selectedRange != null && _selectedRange!.length == 2) {
          _controller.text =
              '${_formatDate(_selectedRange![0])} ${_selectedTime?.format(context) ?? ''} - ${_formatDate(_selectedRange![1])} ${_selectedTime?.format(context) ?? ''}';
        } else {
          _controller.text = '';
        }
        break;
    }
  }

  String _formatDate(DateTime date) {
    switch (widget.type) {
      case DatePickerType.year:
      case DatePickerType.years:
        return DateFormat('yyyy').format(date);
      case DatePickerType.month:
      case DatePickerType.months:
        return DateFormat('yyyy-MM').format(date);
      case DatePickerType.week:
        return _formatWeek(date);
      default:
        return DateFormat(widget.format).format(date);
    }
  }

  String _formatWeek(DateTime date) {
    final firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));
    return '${DateFormat('yyyy-MM-dd').format(firstDayOfWeek)} - ${DateFormat('yyyy-MM-dd').format(lastDayOfWeek)}';
  }

  void _clearSelection() {
    setState(() {
      _selectedDate = null;
      _selectedRange = null;
      _selectedDates = null;
      _selectedWeek = null;
      _selectedMonths = null;
      _selectedYears = null;
      _selectedTime = null;
      _controller.clear();
    });
    switch (widget.type) {
      case DatePickerType.year:
      case DatePickerType.month:
      case DatePickerType.date:
      case DatePickerType.datetime:
      case DatePickerType.week:
        widget.onChange?.call(DateTime.now());
        break;
      case DatePickerType.years:
        widget.onYearsChange?.call([]);
        break;
      case DatePickerType.months:
        widget.onMonthsChange?.call([]);
        break;
      case DatePickerType.dates:
        widget.onDatesChange?.call([]);
        break;
      case DatePickerType.daterange:
      case DatePickerType.monthrange:
      case DatePickerType.yearrange:
      case DatePickerType.datetimerange:
        widget.onRangeChange?.call([]);
        break;
    }
  }

  void _showPicker() {
    if (widget.disabled) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _hidePicker,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            width: 320,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 8),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(),
                      if (widget.type == DatePickerType.datetime ||
                          widget.type == DatePickerType.datetimerange)
                        _buildTimePicker(),
                      if (_shouldShowWeekDays()) _buildWeekDays(),
                      _buildCalendarGrid(),
                      if (_needsFooter) _buildFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (context.mounted) {
      Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
      setState(() {
        _isOpen = true;
      });
    }
  }

  bool _shouldShowWeekDays() {
    return widget.type == DatePickerType.date ||
        widget.type == DatePickerType.dates ||
        widget.type == DatePickerType.daterange ||
        widget.type == DatePickerType.datetimerange ||
        widget.type == DatePickerType.week;
  }

  bool get _needsFooter {
    switch (widget.type) {
      case DatePickerType.dates:
      case DatePickerType.years:
      case DatePickerType.months:
        return true;
      default:
        return false;
    }
  }

  Widget _buildTimePicker() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEBEEF5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () async {
              final TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: _selectedTime ?? TimeOfDay.now(),
              );
              if (time != null) {
                setState(() {
                  _selectedTime = time;
                  _updateController();
                });
              }
            },
            child: Text(_selectedTime?.format(context) ?? 'Select Time'),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFEBEEF5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: _hidePicker,
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              switch (widget.type) {
                case DatePickerType.dates:
                  widget.onDatesChange?.call(_selectedDates ?? []);
                  break;
                case DatePickerType.years:
                  widget.onYearsChange?.call(_selectedYears ?? []);
                  break;
                case DatePickerType.months:
                  widget.onMonthsChange?.call(_selectedMonths ?? []);
                  break;
                default:
                  break;
              }
              _hidePicker();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    late String title;
    switch (widget.type) {
      case DatePickerType.date:
      case DatePickerType.dates:
      case DatePickerType.daterange:
      case DatePickerType.datetimerange:
        title = DateFormat('MMMM yyyy').format(_currentMonth);
        break;
      case DatePickerType.year:
        title = DateFormat('yyyy').format(_currentMonth);
        break;
      case DatePickerType.years:
        title = DateFormat('yyyy').format(_currentMonth);
        break;
      case DatePickerType.month:
        title = DateFormat('MMMM yyyy').format(_currentMonth);
        break;
      case DatePickerType.months:
        title = DateFormat('yyyy-MM').format(_currentMonth);
        break;
      default:
        title = '';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEBEEF5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 20),
            onPressed: () {
              setState(() {
                switch (widget.type) {
                  case DatePickerType.year:
                  case DatePickerType.years:
                    _currentMonth = DateTime(_currentMonth.year - 1);
                    break;
                  case DatePickerType.month:
                  case DatePickerType.months:
                    _currentMonth =
                        DateTime(_currentMonth.year, _currentMonth.month - 1);
                    break;
                  default:
                    _currentMonth =
                        DateTime(_currentMonth.year, _currentMonth.month - 1);
                }
                _showPicker();
              });
            },
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 20),
            onPressed: () {
              setState(() {
                switch (widget.type) {
                  case DatePickerType.year:
                  case DatePickerType.years:
                    _currentMonth = DateTime(_currentMonth.year + 1);
                    break;
                  case DatePickerType.month:
                  case DatePickerType.months:
                    _currentMonth =
                        DateTime(_currentMonth.year, _currentMonth.month + 1);
                    break;
                  default:
                    _currentMonth =
                        DateTime(_currentMonth.year, _currentMonth.month + 1);
                }
                _showPicker();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDays() {
    const weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEBEEF5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: weekDays
            .map((day) => SizedBox(
                  width: 36,
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(
                        color: Color(0xFF606266),
                        fontSize: 14,
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
      case DatePickerType.year:
      case DatePickerType.years:
        return _buildYearGrid();
      case DatePickerType.month:
      case DatePickerType.months:
        return _buildMonthGrid();
      case DatePickerType.week:
        return _buildWeekGrid();
      default:
        return _buildDateGrid();
    }
  }

  Widget _buildYearGrid() {
    final currentYear = _currentMonth.year;
    final years = List.generate(12, (index) => currentYear - 5 + index);

    return Container(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: years.map((year) {
          final date = DateTime(year);
          final isSelected = widget.type == DatePickerType.year
              ? _selectedDate?.year == year
              : _selectedYears?.any((d) => d.year == year) ?? false;
          final isInRange = _selectedRange != null &&
              _selectedRange!.length == 1 &&
              year == _selectedRange![0].year;

          return GestureDetector(
            onTap: () {
              setState(() {
                if (widget.type == DatePickerType.year) {
                  _selectedDate = date;
                  widget.onChange?.call(date);
                  _hidePicker();
                } else {
                  if (_selectedYears == null) {
                    _selectedYears = [date];
                  } else {
                    if (_selectedYears!.any((d) => d.year == year)) {
                      _selectedYears!.removeWhere((d) => d.year == year);
                    } else {
                      _selectedYears!.add(date);
                    }
                  }
                  _updateController();
                }
              });
            },
            child: Container(
              width: 72,
              height: 32,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isSelected || isInRange
                    ? EDatePickerStyle.selectedColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  year.toString(),
                  style: TextStyle(
                    color: isSelected || isInRange
                        ? Colors.white
                        : const Color(0xFF606266),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMonthGrid() {
    final months =
        List.generate(12, (index) => DateTime(_currentMonth.year, index + 1));

    return Container(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: months.map((month) {
          final isSelected = widget.type == DatePickerType.month
              ? _selectedDate?.month == month.month &&
                  _selectedDate?.year == month.year
              : _selectedMonths?.any(
                      (d) => d.month == month.month && d.year == month.year) ??
                  false;
          final isInRange = _selectedRange != null &&
              _selectedRange!.length == 1 &&
              month.month == _selectedRange![0].month &&
              month.year == _selectedRange![0].year;

          return GestureDetector(
            onTap: () {
              setState(() {
                if (widget.type == DatePickerType.month) {
                  _selectedDate = DateTime(month.year, month.month);
                  widget.onChange?.call(_selectedDate!);
                  _hidePicker();
                } else {
                  if (_selectedMonths == null) {
                    _selectedMonths = [DateTime(month.year, month.month)];
                  } else {
                    if (_selectedMonths!.any((d) =>
                        d.month == month.month && d.year == month.year)) {
                      _selectedMonths!.removeWhere((d) =>
                          d.month == month.month && d.year == month.year);
                    } else {
                      _selectedMonths!.add(DateTime(month.year, month.month));
                    }
                  }
                  _updateController();
                }
              });
            },
            child: Container(
              width: 72,
              height: 32,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isSelected || isInRange
                    ? EDatePickerStyle.selectedColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  DateFormat('MMM').format(month),
                  style: TextStyle(
                    color: isSelected || isInRange
                        ? Colors.white
                        : const Color(0xFF606266),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildWeekGrid() {
    final DateTime firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month, 1);
    final int daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final int firstWeekday = firstDayOfMonth.weekday % 7;

    List<Widget> days = List.generate(42, (index) {
      final int day = index - firstWeekday + 1;
      final bool isCurrentMonth = day > 0 && day <= daysInMonth;
      DateTime date;

      if (day <= 0) {
        date = DateTime(
            _currentMonth.year, _currentMonth.month - 1, daysInMonth + day);
      } else if (day > daysInMonth) {
        date = DateTime(
            _currentMonth.year, _currentMonth.month + 1, day - daysInMonth);
      } else {
        date = DateTime(_currentMonth.year, _currentMonth.month, day);
      }

      final firstDayOfWeek = date.subtract(Duration(days: date.weekday % 7));
      final isSelected = _selectedWeek != null &&
          firstDayOfWeek.isAtSameMomentAs(_selectedWeek!
              .subtract(Duration(days: _selectedWeek!.weekday % 7)));

      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedWeek = date;
            _updateController();
            widget.onWeekChange?.call(date);
            _hidePicker();
          });
        },
        child: Container(
          width: 32,
          height: 32,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isSelected
                ? EDatePickerStyle.selectedColor
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              date.day.toString(),
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF606266),
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
    });

    return Container(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: days,
      ),
    );
  }

  Widget _buildDateGrid() {
    final DateTime firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month, 1);
    final int daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final int firstWeekday = firstDayOfMonth.weekday % 7;

    // 获取上个月的最后几天
    final DateTime lastMonth =
        DateTime(_currentMonth.year, _currentMonth.month - 1);
    final int daysInLastMonth =
        DateTime(lastMonth.year, lastMonth.month + 1, 0).day;

    List<Widget> days = List.generate(42, (index) {
      final int day = index - firstWeekday + 1;
      final bool isCurrentMonth = day > 0 && day <= daysInMonth;
      DateTime date;

      if (day <= 0) {
        // 修正上个月日期的计算
        date = DateTime(lastMonth.year, lastMonth.month, daysInLastMonth + day);
      } else if (day > daysInMonth) {
        date = DateTime(
            _currentMonth.year, _currentMonth.month + 1, day - daysInMonth);
      } else {
        date = DateTime(_currentMonth.year, _currentMonth.month, day);
      }

      bool isSelected = false;
      bool isInRange = false;

      switch (widget.type) {
        case DatePickerType.date:
          isSelected =
              _selectedDate != null && date.isAtSameMomentAs(_selectedDate!);
          break;
        case DatePickerType.dates:
          isSelected =
              _selectedDates?.any((d) => d.isAtSameMomentAs(date)) ?? false;
          break;
        case DatePickerType.daterange:
        case DatePickerType.monthrange:
        case DatePickerType.yearrange:
        case DatePickerType.datetimerange:
          if (_selectedRange != null) {
            if (_selectedRange!.length == 1) {
              isSelected = date.isAtSameMomentAs(_selectedRange![0]);
            } else if (_selectedRange!.length == 2) {
              isSelected = date.isAtSameMomentAs(_selectedRange![0]) ||
                  date.isAtSameMomentAs(_selectedRange![1]);
              isInRange = date.isAfter(_selectedRange![0]) &&
                  date.isBefore(_selectedRange![1]);
            }
          }
          break;
        default:
          break;
      }

      return GestureDetector(
        onTap: () {
          setState(() {
            switch (widget.type) {
              case DatePickerType.date:
                _selectedDate = date;
                widget.onChange?.call(date);
                // 下一次屏幕刷新在消失
                Future.delayed(const Duration(milliseconds: 100), () {
                  _hidePicker();
                });
                break;
              case DatePickerType.dates:
                if (_selectedDates == null) {
                  _selectedDates = [date];
                } else {
                  if (_selectedDates!.any((d) => d.isAtSameMomentAs(date))) {
                    _selectedDates!
                        .removeWhere((d) => d.isAtSameMomentAs(date));
                  } else {
                    _selectedDates!.add(date);
                  }
                }
                _updateController();
                break;
              case DatePickerType.daterange:
              case DatePickerType.monthrange:
              case DatePickerType.yearrange:
              case DatePickerType.datetimerange:
                if (_selectedRange == null) {
                  _selectedRange = [date];
                } else if (_selectedRange!.length == 1) {
                  if (date.isBefore(_selectedRange![0])) {
                    _selectedRange = [date, _selectedRange![0]];
                  } else {
                    _selectedRange = [_selectedRange![0], date];
                  }
                  widget.onRangeChange?.call(_selectedRange!);
                  _hidePicker();
                } else {
                  _selectedRange = [date];
                }
                _updateController();
                break;
              default:
                break;
            }
          });
        },
        child: StatefulBuilder(builder: (context, setState) {
          bool isHovered = false;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isSelected || isInRange
                    ? EDatePickerStyle.selectedColor
                    : isHovered
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF606266),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }),
      );
    });

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: Wrap(
        spacing: 0,
        runSpacing: 0,
        children: days,
      ),
    );
  }

  void _hidePicker() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () {
            widget.onTap?.call();
            if (!widget.disabled && !widget.editable) {
              if (_isOpen) {
                _hidePicker();
              } else {
                _showPicker();
              }
            }
          },
          child: EBasicTextField(
            controller: _controller,
            placeholder: widget.placeholder,
            style: TextStyle(
              fontSize: ElememtSize(size: widget.size).getTextfieldFontSize(),
            ),
            textAlignVertical: TextAlignVertical.center,
            obscureText: false,
            readOnly: !widget.editable,
            size: widget.size,
            enabled: !widget.disabled,
            onChanged: (value) {
              // Handle text input if editable
              if (widget.editable) {
                print(value);
              }
            },
            decoration: InputDecoration(
              hintStyle: TextStyle(color: EColors.BorderGray),
              prefixIcon: IconButton(
                icon: Icon(
                  Icons.calendar_month_rounded,
                  size: ElememtSize(size: widget.size).getIconSize(),
                  color: widget.disabled ? EColors.BorderGray : EColors.Primary,
                ),
                onPressed: widget.disabled
                    ? null
                    : () {
                        widget.onPrefixTap?.call();
                        if (_isOpen) {
                          _hidePicker();
                        } else {
                          _showPicker();
                        }
                      },
              ),
              suffixIcon:
                  widget.clearable && _isHovered && _controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close, size: 16),
                          onPressed: _clearSelection,
                        )
                      : null,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }
}
