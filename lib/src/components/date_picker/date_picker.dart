import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';
import 'date_picker_style.dart';
import 'package:intl/intl.dart';

class EDatePicker extends StatefulWidget {
  final DateTime? value;
  final ValueChanged<DateTime>? onChange;
  final SizeItem size;
  final DatePickerType type;
  final String? placeholder;
  final bool disabled;
  final bool clearable;
  final String format;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool range;
  final List<DateTime>? rangeValue;
  final ValueChanged<List<DateTime>>? onRangeChange;

  const EDatePicker({
    super.key,
    this.value,
    this.onChange,
    this.placeholder = 'Select date',
    this.disabled = false,
    this.clearable = true,
    this.format = 'yyyy-MM-dd',
    this.size = SizeItem.medium,
    this.type = DatePickerType.date,
    this.minDate,
    this.maxDate,
    this.range = false,
    this.rangeValue,
    this.onRangeChange,
  });

  @override
  State<EDatePicker> createState() => _EDatePickerState();
}

class _EDatePickerState extends State<EDatePicker> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  DateTime? _selectedDate;
  List<DateTime>? _selectedDates;
  List<DateTime>? _selectedRange;
  bool _isOpen = false;
  bool _isFocused = false;
  bool _isHovered = false;
  late DateTime _currentMonth;
  DateTime? _hoveredDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.value;
    _selectedRange = widget.rangeValue;
    _currentMonth = _selectedDate ?? DateTime.now();
    _updateController();
    _focusNode.addListener(_handleFocusChange);
  }

  // 当前节点被聚焦的时候 触发
  void _handleFocusChange() {
    print('focusNode: ${_focusNode.hasFocus}');
    setState(() {
      if (_focusNode.hasFocus) {
        _isFocused = true;
        _showDatePicker();
      } else {
        _isFocused = false;
      }
    });
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
  }

  void _updateController() {
    if (widget.range) {
      if (_selectedRange != null && _selectedRange!.length == 2) {
        _controller.text =
            '${_formatDate(_selectedRange![0])} - ${_formatDate(_selectedRange![1])}';
      } else {
        _controller.text = '';
      }
    } else {
      if (_selectedDate != null) {
        switch (widget.type) {
          case DatePickerType.dates:
            _controller.text =
                _selectedDates?.map((e) => _formatDate(e)).join(',') ?? '';
            break;
          case DatePickerType.date:
            _controller.text = _formatDate(_selectedDate!);
            break;
          case DatePickerType.year:
            _controller.text = _selectedDate!.year.toString();
            break;
          case DatePickerType.month:
            _controller.text = DateFormat('yyyy-MM').format(_selectedDate!);
            break;
          default:
            _controller.text = _formatDate(_selectedDate!);
        }
      } else {
        _controller.text = '';
      }
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat(widget.format).format(date);
  }

  void _showDatePicker() {
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
                      if (widget.type == DatePickerType.date ||
                          widget.type == DatePickerType.dates)
                        _buildWeekDays(),
                      _buildCalendarGrid(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  Widget _buildHeader() {
    switch (widget.type) {
      case DatePickerType.year:
      case DatePickerType.years:
        return _buildYearHeader();
      case DatePickerType.month:
      case DatePickerType.months:
        return _buildMonthHeader();
      case DatePickerType.date:
      case DatePickerType.dates:
        return _buildDateHeader();
      default:
        return _buildDateHeader();
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
            icon: const Icon(Icons.chevron_left, size: 20),
            onPressed: () {
              setState(() {
                _currentMonth = DateTime(
                  _currentMonth.year - 10,
                  _currentMonth.month,
                );
                _showDatePicker();
              });
            },
          ),
          Text(
            '$decadeStart - $decadeEnd',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 20),
            onPressed: () {
              setState(() {
                _currentMonth = DateTime(
                  _currentMonth.year + 10,
                  _currentMonth.month,
                );
                _showDatePicker();
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
            icon: const Icon(Icons.chevron_left, size: 20),
            onPressed: () {
              setState(() {
                _currentMonth = DateTime(
                  _currentMonth.year - 1,
                  _currentMonth.month,
                );
                _showDatePicker();
              });
            },
          ),
          Text(
            _currentMonth.year.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 20),
            onPressed: () {
              setState(() {
                _currentMonth = DateTime(
                  _currentMonth.year + 1,
                  _currentMonth.month,
                );
                _showDatePicker();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateHeader() {
    final monthName = DateFormat('MMMM yyyy').format(_currentMonth);
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
                _currentMonth = DateTime(
                  _currentMonth.year,
                  _currentMonth.month - 1,
                );
                _showDatePicker();
              });
            },
          ),
          Text(
            monthName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 20),
            onPressed: () {
              setState(() {
                _currentMonth = DateTime(
                  _currentMonth.year,
                  _currentMonth.month + 1,
                );
                _showDatePicker();
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weekDays
            .map((day) => SizedBox(
                  width: 32,
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
      case DatePickerType.date:
      case DatePickerType.dates:
        return _buildDateGrid();
      default:
        return _buildDateGrid();
    }
  }

  Widget _buildYearGrid() {
    final int currentYear = _currentMonth.year;
    final int decadeStart = (currentYear ~/ 10) * 10;

    List<Widget> years = List.generate(10, (index) {
      final int year = decadeStart + index;
      final bool isSelected = _selectedDate?.year == year;
      final bool isToday = year == DateTime.now().year;

      return MouseRegion(
        onEnter: (_) => setState(() => _hoveredDate = DateTime(year)),
        onExit: (_) => setState(() => _hoveredDate = null),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = DateTime(year);
              _updateController();
              widget.onChange?.call(_selectedDate!);
              _hidePicker();
            });
          },
          child: Container(
            width: 80,
            height: 32,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected
                  ? EDatePickerStyle.selectedColor
                  : _hoveredDate?.year == year
                      ? EDatePickerStyle.hoverColor
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: isToday
                  ? Border.all(color: EDatePickerStyle.selectedColor)
                  : null,
            ),
            child: Center(
              child: Text(
                year.toString(),
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : _hoveredDate?.year == year && !isSelected
                          ? EDatePickerStyle.selectedColor
                          : const Color(0xFF606266),
                  fontSize: 14,
                ),
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
        children: years,
      ),
    );
  }

  Widget _buildMonthGrid() {
    List<Widget> months = List.generate(12, (index) {
      final int month = index + 1;
      final bool isSelected = _selectedDate?.year == _currentMonth.year &&
          _selectedDate?.month == month;
      final bool isToday = _currentMonth.year == DateTime.now().year &&
          month == DateTime.now().month;

      return MouseRegion(
        onEnter: (_) =>
            setState(() => _hoveredDate = DateTime(_currentMonth.year, month)),
        onExit: (_) => setState(() => _hoveredDate = null),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = DateTime(_currentMonth.year, month);
              _updateController();
              widget.onChange?.call(_selectedDate!);
              _hidePicker();
            });
          },
          child: Container(
            width: 80,
            height: 32,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected
                  ? EDatePickerStyle.selectedColor
                  : _hoveredDate?.month == month
                      ? EDatePickerStyle.hoverColor
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: isToday
                  ? Border.all(color: EDatePickerStyle.selectedColor)
                  : null,
            ),
            child: Center(
              child: Text(
                DateFormat('MMM').format(DateTime(2000, month)),
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : _hoveredDate?.month == month && !isSelected
                          ? EDatePickerStyle.selectedColor
                          : const Color(0xFF606266),
                  fontSize: 14,
                ),
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
        children: months,
      ),
    );
  }

  Widget _buildDateGrid() {
    final DateTime firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month, 1);
    final int daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final int firstWeekday = firstDayOfMonth.weekday % 7;

    final DateTime prevMonth =
        DateTime(_currentMonth.year, _currentMonth.month - 1);
    final int daysInPrevMonth =
        DateTime(prevMonth.year, prevMonth.month + 1, 0).day;

    List<Widget> days = List.generate(42, (index) {
      final int day = index - firstWeekday + 1;
      final bool isCurrentMonth = day > 0 && day <= daysInMonth;
      DateTime date;

      if (day <= 0) {
        date = DateTime(
            _currentMonth.year, _currentMonth.month - 1, daysInPrevMonth + day);
      } else if (day > daysInMonth) {
        date = DateTime(
            _currentMonth.year, _currentMonth.month + 1, day - daysInMonth);
      } else {
        date = DateTime(_currentMonth.year, _currentMonth.month, day);
      }

      bool isSelected = false;
      if (widget.range) {
        if (_selectedRange != null) {
          if (_selectedRange!.length == 1) {
            isSelected = date.isAtSameMomentAs(_selectedRange![0]);
          } else if (_selectedRange!.length == 2) {
            isSelected = date.isAtSameMomentAs(_selectedRange![0]) ||
                date.isAtSameMomentAs(_selectedRange![1]);
          }
        }
      } else {
        isSelected =
            _selectedDate != null && date.isAtSameMomentAs(_selectedDate!);
      }

      bool isToday = date.isAtSameMomentAs(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ));

      return MouseRegion(
        onEnter: (_) => setState(() => _hoveredDate = date),
        onExit: (_) => setState(() => _hoveredDate = null),
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (!isCurrentMonth) {
                _currentMonth = DateTime(date.year, date.month);
              }

              if (widget.range) {
                if (_selectedRange == null) {
                  _selectedRange = [date];
                } else if (_selectedRange!.length == 1) {
                  if (date.isBefore(_selectedRange![0])) {
                    _selectedRange = [date, _selectedRange![0]];
                  } else {
                    _selectedRange = [_selectedRange![0], date];
                  }
                } else {
                  _selectedRange = [date];
                }
                _updateController();
                if (_selectedRange!.length == 2) {
                  widget.onRangeChange?.call(_selectedRange!);
                  _hidePicker();
                }
              } else {
                if (widget.type == DatePickerType.dates) {
                  _selectedDates = [...(_selectedDates ?? []), date];
                } else {
                  _selectedDate = date;
                }
                _updateController();
                widget.onChange?.call(_selectedDate!);
                if (widget.type == DatePickerType.date) {
                  _hidePicker();
                }
              }
            });
          },
          child: Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected
                  ? EDatePickerStyle.selectedColor
                  : _hoveredDate == date
                      ? EDatePickerStyle.hoverColor
                      : Colors.transparent,
              shape: BoxShape.circle,
              border: isToday
                  ? Border.all(color: EDatePickerStyle.selectedColor)
                  : null,
            ),
            child: Center(
              child: Text(
                date.day.toString(),
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : _hoveredDate == date && !isSelected
                          ? EDatePickerStyle.selectedColor
                          : !isCurrentMonth
                              ? const Color(0xFFCCCCCC)
                              : const Color(0xFF606266),
                  fontSize: 14,
                ),
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

  void _hidePicker() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
    });
  }

  void _handleClear() {
    setState(() {
      _selectedDate = null;
      _selectedRange = null;
      _updateController();
      if (widget.range) {
        widget.onRangeChange?.call([]);
      } else {
        widget.onChange?.call(DateTime.now());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasValue = widget.range
        ? (_selectedRange != null && _selectedRange!.isNotEmpty)
        : _selectedDate != null;

    return SizedBox(
      height: ElememtSize(size: widget.size).getContainerHeight(),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isFocused ? EColors.Primary : EColors.BorderGray,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: CompositedTransformTarget(
            link: _layerLink,
            child: Row(
              children: [
                SizedBox(
                  child: Center(
                    child: Icon(
                      Icons.calendar_month_rounded,
                      size: ElememtSize(size: widget.size).getIconSize(),
                      color: EColors.Primary,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!widget.disabled) {
                        _showDatePicker();
                      }
                    },
                    child: TextFormField(
                      controller: _controller,
                      focusNode: _focusNode,
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: false,
                      enabled: !widget.disabled,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(4),
                        isDense: true,
                        isCollapsed: true,
                        hintText: widget.placeholder,
                        hintStyle: TextStyle(color: EColors.BorderGray),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                if (hasValue && _isHovered && widget.clearable)
                  GestureDetector(
                    onTap: _handleClear,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: EColors.Primary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }
}
