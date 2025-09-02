import 'package:flutter/material.dart';
import '../button/button.dart';
import 'package:intl/intl.dart';

class CalendarRange extends StatefulWidget {
  final DateTimeRange? initialRange;
  final DateTime? minDate;
  final DateTime? maxDate;
  final String? format;
  final ValueChanged<DateTimeRange?>? onSelect;

  const CalendarRange({
    super.key,
    this.initialRange,
    this.minDate,
    this.maxDate,
    this.format,
    this.onSelect,
  });

  @override
  State<CalendarRange> createState() => _CalendarRangeState();
}

class _CalendarRangeState extends State<CalendarRange> {
  late DateTime _currentMonth;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isSelectingStart = true;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    if (widget.initialRange != null) {
      _startDate = widget.initialRange!.start;
      _endDate = widget.initialRange!.end;
    }
  }

  void _selectDate(DateTime date) {
    if (widget.minDate != null && date.isBefore(widget.minDate!)) return;
    if (widget.maxDate != null && date.isAfter(widget.maxDate!)) return;

    setState(() {
      if (_isSelectingStart || _startDate == null) {
        _startDate = date;
        _endDate = null;
        _isSelectingStart = false;
      } else {
        if (date.isBefore(_startDate!)) {
          _endDate = _startDate;
          _startDate = date;
        } else {
          _endDate = date;
        }
        _isSelectingStart = true;
      }
    });
  }

  void _confirmSelection() {
    if (_startDate != null && _endDate != null) {
      final range = DateTimeRange(start: _startDate!, end: _endDate!);
      widget.onSelect?.call(range);
    }
  }

  void _clearSelection() {
    setState(() {
      _startDate = null;
      _endDate = null;
      _isSelectingStart = true;
    });
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  void _previousYear() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year - 1, _currentMonth.month);
    });
  }

  void _nextYear() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year + 1, _currentMonth.month);
    });
  }

  bool _isInRange(DateTime date) {
    if (_startDate == null || _endDate == null) return false;
    return date.isAfter(_startDate!) && date.isBefore(_endDate!);
  }

  bool _isStartDate(DateTime date) {
    return _startDate != null && 
           date.year == _startDate!.year && 
           date.month == _startDate!.month && 
           date.day == _startDate!.day;
  }

  bool _isEndDate(DateTime date) {
    return _endDate != null && 
           date.year == _endDate!.year && 
           date.month == _endDate!.month && 
           date.day == _endDate!.day;
  }

  List<DateTime> _getDaysInMonth() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    
    final firstWeekday = firstDay.weekday;
    final daysInMonth = lastDay.day;
    
    final days = <DateTime>[];
    
    // 添加前一个月的日期
    final prevMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    final daysInPrevMonth = DateTime(_currentMonth.year, _currentMonth.month, 0).day;
    for (int i = firstWeekday - 1; i > 0; i--) {
      days.add(DateTime(prevMonth.year, prevMonth.month, daysInPrevMonth - i + 1));
    }
    
    // 添加当前月的日期
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }
    
    // 添加下个月的日期
    final remainingDays = 42 - days.length; // 6行7列 = 42
    for (int i = 1; i <= remainingDays; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month + 1, i));
    }
    
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth();
    final isCurrentMonth = (date) => date.month == _currentMonth.month;
    
    return Column(
      children: [
        // 头部
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: _previousYear,
                    icon: const Icon(Icons.keyboard_double_arrow_left, size: 20),
                  ),
                  IconButton(
                    onPressed: _previousMonth,
                    icon: const Icon(Icons.chevron_left, size: 20),
                  ),
                ],
              ),
              Text(
                DateFormat('yyyy年MM月').format(_currentMonth),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _nextMonth,
                    icon: const Icon(Icons.chevron_right, size: 20),
                  ),
                  IconButton(
                    onPressed: _nextYear,
                    icon: const Icon(Icons.keyboard_double_arrow_right, size: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // 星期标题
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: ['日', '一', '二', '三', '四', '五', '六'].map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        
        // 日期网格
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
              ),
              itemCount: days.length,
              itemBuilder: (context, index) {
                final date = days[index];
                final isCurrentMonthDate = isCurrentMonth(date);
                final isInRange = _isInRange(date);
                final isStart = _isStartDate(date);
                final isEnd = _isEndDate(date);
                
                return GestureDetector(
                  onTap: () => _selectDate(date),
                  child: Container(
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: isStart || isEnd
                          ? Theme.of(context).primaryColor
                          : isInRange
                              ? Theme.of(context).primaryColor.withOpacity(0.2)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          fontSize: 14,
                          color: isStart || isEnd
                              ? Colors.white
                              : isCurrentMonthDate
                                  ? Colors.black87
                                  : Colors.grey[400],
                          fontWeight: isStart || isEnd ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        
        // 底部按钮
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: _clearSelection,
                child: const Text('清除'),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () => widget.onSelect?.call(null),
                    child: const Text('取消'),
                  ),
                  const SizedBox(width: 8),
                  EButton(
                    onPressed: _startDate != null && _endDate != null 
                        ? _confirmSelection 
                        : null,
                    child: const Text('确定'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
