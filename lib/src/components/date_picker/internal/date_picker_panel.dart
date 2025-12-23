import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../date_picker_model.dart';
import 'date_calendar_view.dart';
import '../../../theme/index.dart';

import '../date_picker_style.dart';

class EDatePickerPanel extends StatefulWidget {
  final DateTime? initialDisplayDate;
  final DateTime? selectedDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? hoverDate;
  final ValueChanged<DateTime> onDateSelect;
  final ValueChanged<DateTime>? onHover;
  final VoidCallback? onHeaderClick;
  final ESizeItem size;

  const EDatePickerPanel({
    super.key,
    this.initialDisplayDate,
    this.selectedDate,
    this.startDate,
    this.endDate,
    this.hoverDate,
    required this.onDateSelect,
    this.onHover,
    this.onHeaderClick,
    this.size = ESizeItem.medium,
  });

  @override
  State<EDatePickerPanel> createState() => _EDatePickerPanelState();
}

class _EDatePickerPanelState extends State<EDatePickerPanel> {
  late DateTime _displayDate;
  EDatePickerViewMode _viewMode = EDatePickerViewMode.day;

  @override
  void initState() {
    super.initState();
    _displayDate = widget.initialDisplayDate ??
        widget.selectedDate ??
        widget.startDate ??
        DateTime.now();
  }

  @override
  void didUpdateWidget(EDatePickerPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDisplayDate != null &&
        widget.initialDisplayDate != oldWidget.initialDisplayDate) {
      _displayDate = widget.initialDisplayDate!;
    }
  }

  void _prevYear() {
    setState(() {
      if (_viewMode == EDatePickerViewMode.year) {
        _displayDate = DateTime(_displayDate.year - 10, _displayDate.month);
      } else {
        _displayDate = DateTime(_displayDate.year - 1, _displayDate.month);
      }
    });
  }

  void _nextYear() {
    setState(() {
      if (_viewMode == EDatePickerViewMode.year) {
        _displayDate = DateTime(_displayDate.year + 10, _displayDate.month);
      } else {
        _displayDate = DateTime(_displayDate.year + 1, _displayDate.month);
      }
    });
  }

  void _prevMonth() {
    setState(() {
      _displayDate = DateTime(_displayDate.year, _displayDate.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _displayDate = DateTime(_displayDate.year, _displayDate.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(),
        EDateCalendarView(
          displayMonth: _displayDate,
          viewMode: _viewMode,
          selectedDate: widget.selectedDate,
          startDate: widget.startDate,
          endDate: widget.endDate,
          hoverDate: widget.hoverDate,
          size: widget.size,
          onHover: widget.onHover,
          onDateClick: (date) {
            if (_viewMode == EDatePickerViewMode.year) {
              setState(() {
                _displayDate = DateTime(date.year, _displayDate.month);
                _viewMode = EDatePickerViewMode.month;
              });
            } else if (_viewMode == EDatePickerViewMode.month) {
              setState(() {
                _displayDate = DateTime(_displayDate.year, date.month);
                _viewMode = EDatePickerViewMode.day;
              });
            } else {
              widget.onDateSelect(date);
            }
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
    String title = "";
    if (_viewMode == EDatePickerViewMode.day) {
      title = DateFormat('MMMM yyyy').format(_displayDate);
    } else if (_viewMode == EDatePickerViewMode.month) {
      title = DateFormat('yyyy').format(_displayDate);
    } else {
      int startYear = (_displayDate.year ~/ 10) * 10;
      title = '$startYear - ${startYear + 9}';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(
                color: EDatePickerStyle.borderColor.withOpacity(0.5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildHeaderBtn(
                  Icons.keyboard_double_arrow_left_rounded, _prevYear),
              const SizedBox(width: 4),
              if (_viewMode == EDatePickerViewMode.day)
                _buildHeaderBtn(Icons.keyboard_arrow_left_rounded, _prevMonth),
            ],
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (_viewMode == EDatePickerViewMode.day) {
                      _viewMode = EDatePickerViewMode.month;
                    } else if (_viewMode == EDatePickerViewMode.month) {
                      _viewMode = EDatePickerViewMode.year;
                    }
                  });
                },
                borderRadius:
                    BorderRadius.circular(EDatePickerStyle.borderRadius),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(0xFF111827),
                        letterSpacing: 0.2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              if (_viewMode == EDatePickerViewMode.day)
                _buildHeaderBtn(Icons.keyboard_arrow_right_rounded, _nextMonth),
              const SizedBox(width: 4),
              _buildHeaderBtn(
                  Icons.keyboard_double_arrow_right_rounded, _nextYear),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBtn(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            icon,
            size: 20,
            color: EDatePickerStyle.selectedColor,
          ),
        ),
      ),
    );
  }
}
