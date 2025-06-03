// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';
import '../input/input.dart';
import 'calendar.dart';
import 'package:intl/intl.dart';

class EDatePicker extends StatefulWidget {
  final DateTime? value;
  final ValueChanged<String?>? onChange;
  final String? placeholder;
  final bool disabled;
  final bool clearable;
  final String? format;
  final ESizeItem size;
  final Widget? prefix;
  final Widget? suffix;
  final DateTime? minDate;
  final DateTime? maxDate;
  final CalendarType type;
  final bool showtimeSelect;
  final Widget? prevMonth;
  final Widget? nextMonth;
  final Widget? prevYear;
  final Widget? nextYear;

  const EDatePicker({
    super.key,
    this.value,
    this.onChange,
    this.placeholder = '选择日期',
    this.disabled = false,
    this.showtimeSelect = false,
    this.clearable = true,
    this.format,
    this.size = ESizeItem.medium,
    this.type = CalendarType.date,
    this.minDate,
    this.maxDate,
    this.prefix,
    this.suffix,
    this.prevMonth = const Icon(Icons.chevron_left, size: 20),
    this.nextMonth = const Icon(Icons.chevron_right, size: 20),
    this.prevYear = const Icon(Icons.keyboard_double_arrow_left, size: 20),
    this.nextYear = const Icon(Icons.keyboard_double_arrow_right, size: 20),
  });
  @override
  State<EDatePicker> createState() => _EDatePickerState();
}

class _EDatePickerState extends State<EDatePicker> {
  late TextEditingController _controller;
  String? _selectedDate;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.value != null
        ? DateFormat(widget.format).format(widget.value!)
        : null;
    _controller = TextEditingController(
      text: _selectedDate ?? '',
    );
  }

  @override
  void didUpdateWidget(EDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _selectedDate = widget.value != null
          ? DateFormat(widget.format).format(widget.value!)
          : null;
      _controller.text = _selectedDate ?? '';
    }
  }

  void _showCalendar() {
    if (widget.disabled) return;
    if (_controller.text.isNotEmpty) {
      _selectedDate = _controller.text;
    }
    _removeOverlay();
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
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
              child: Calendar(
                initialDate: _selectedDate,
                type: widget.type,
                minDate: widget.minDate,
                maxDate: widget.maxDate,
                onSelect: (date) {
                  debugPrint('已经选择的日期: $date');
                  _removeOverlay();
                  if (date != null) {
                    setState(() {
                      if (date is String) {
                        _controller.text = date;
                      } else {
                        _selectedDate = date;
                        _controller.text =
                            DateFormat(getDefaultFormat(widget.type))
                                .format(date);
                      }
                    });
                    widget.onChange?.call(date);
                  }
                },
                prevMonth: widget.prevMonth,
                nextMonth: widget.nextMonth,
                prevYear: widget.prevYear,
                nextYear: widget.nextYear,
                format: widget.format ?? getDefaultFormat(widget.type),
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: EInput(
        textController: _controller,
        placeholder: widget.placeholder,
        clearable: widget.clearable,
        disabled: widget.disabled,
        prefix: widget.prefix ?? Icon(Icons.calendar_month_rounded, size: 20),
        suffix: widget.suffix,
        size: widget.size,
        readOnly: true,
        onFocus: _showCalendar,
      ),
    );
  }
}
