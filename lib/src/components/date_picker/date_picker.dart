import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';
import 'date_picker_style.dart';
import 'package:intl/intl.dart';

class EDatePicker extends StatefulWidget {
  final DateTime? value;
  final ValueChanged<DateTime>? onChange;
  final SizeItem size;
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
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  DateTime? _selectedDate;
  List<DateTime>? _selectedRange;
  bool _isOpen = false;
  late DateTime _currentMonth;
  DateTime? _hoveredDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.value;
    _selectedRange = widget.rangeValue;
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
      _controller.text =
          _selectedDate != null ? _formatDate(_selectedDate!) : '';
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat(widget.format).format(date);
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
                _showPicker(); // Refresh overlay to show updated calendar
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
                _showPicker(); // Refresh overlay to show updated calendar
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
    final DateTime firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month, 1);
    final int daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final int firstWeekday = firstDayOfMonth.weekday % 7;

    // Calculate previous month's days
    final DateTime prevMonth =
        DateTime(_currentMonth.year, _currentMonth.month - 1);
    final int daysInPrevMonth =
        DateTime(prevMonth.year, prevMonth.month + 1, 0).day;

    List<Widget> days = List.generate(42, (index) {
      final int day = index - firstWeekday + 1;
      final bool isCurrentMonth = day > 0 && day <= daysInMonth;
      DateTime date;

      if (day <= 0) {
        // Previous month
        date = DateTime(
            _currentMonth.year, _currentMonth.month - 1, daysInPrevMonth + day);
      } else if (day > daysInMonth) {
        // Next month
        date = DateTime(
            _currentMonth.year, _currentMonth.month + 1, day - daysInMonth);
      } else {
        // Current month
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
                _selectedDate = date;
                _updateController();
                widget.onChange?.call(_selectedDate!);
                _hidePicker();
              }
            });
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
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

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: EBasicTextField(
        controller: _controller,
        readOnly: false,
        size: widget.size,
        enabled: !widget.disabled,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          prefix: Icon(Icons.calendar_today_outlined),
          hintStyle: TextStyle(color: EColors.BorderGray),
          contentPadding:
              ElememtSize(size: widget.size).getInputPadding(widget.size),
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
