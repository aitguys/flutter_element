import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../date_picker_model.dart';
import '../date_picker_style.dart';
import 'date_picker_panel.dart';
import '../../../theme/index.dart';
import '../../button/button.dart';

class EDatePickerPopup extends StatefulWidget {
  final DatePickerType type;
  final DateTime? initialDate;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final ValueChanged<EDatePickerValue> onConfirm;
  final VoidCallback onCancel;
  final ESizeItem size;

  const EDatePickerPopup({
    super.key,
    required this.type,
    this.initialDate,
    this.initialStartDate,
    this.initialEndDate,
    required this.onConfirm,
    required this.onCancel,
    this.size = ESizeItem.medium,
  });

  @override
  State<EDatePickerPopup> createState() => _EDatePickerPopupState();
}

class _EDatePickerPopupState extends State<EDatePickerPopup> {
  DateTime? _selectedDate;
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _hoverDate;

  late DateTime _leftDisplayMonth;
  late DateTime _rightDisplayMonth;

  bool _hasStartError = false;
  bool _hasEndError = false;

  final TextEditingController _startInputController = TextEditingController();
  final TextEditingController _endInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;

    DateTime initial = _startDate ?? _selectedDate ?? DateTime.now();
    _leftDisplayMonth = DateTime(initial.year, initial.month);
    _rightDisplayMonth = DateTime(initial.year, initial.month + 1);

    _updateInputFields();
  }

  void _updateInputFields() {
    final now = DateTime.now();
    DateTime sd = _startDate ?? _selectedDate ?? now;
    _startInputController.text = DateFormat('MM/dd/yyyy').format(sd);

    if (widget.type == DatePickerType.daterange) {
      DateTime ed = _endDate ?? now;
      _endInputController.text = DateFormat('MM/dd/yyyy').format(ed);
    }
  }

  void _onDateSelect(DateTime date) {
    setState(() {
      if (widget.type == DatePickerType.daterange) {
        if (_startDate == null || (_startDate != null && _endDate != null)) {
          _startDate = date;
          _endDate = null;
        } else {
          if (date.isBefore(_startDate!)) {
            _endDate = _startDate;
            _startDate = date;
          } else {
            _endDate = date;
          }
          // Auto confirm when range is finished
          widget.onConfirm(EDatePickerValue(
            start: _startDate,
            end: _endDate,
          ));
        }
      } else {
        _selectedDate = date;
        _startDate = date;
        // Auto confirm for single date
        widget.onConfirm(EDatePickerValue(
          start: _startDate,
        ));
      }
      _hasStartError = false;
      _hasEndError = false;
      _updateInputFields();
    });
  }

  void _onShortcutClick(EShortcut shortcut) {
    final now = DateTime.now();
    DateTime? start;
    DateTime? end = DateTime(now.year, now.month, now.day);

    if (shortcut.getValue != null) {
      start = shortcut.getValue!();
    } else if (shortcut.duration != null) {
      start = end.subtract(shortcut.duration!);
    }

    if (start != null) {
      setState(() {
        if (widget.type == DatePickerType.daterange) {
          _startDate = start;
          _endDate = end;
        } else {
          _selectedDate = start;
        }
        _leftDisplayMonth = DateTime(start!.year, start.month);
        _rightDisplayMonth =
            DateTime(_leftDisplayMonth.year, _leftDisplayMonth.month + 1);
        _hasStartError = false;
        _hasEndError = false;
        _updateInputFields();
      });
      widget.onConfirm(EDatePickerValue(
        start: widget.type == DatePickerType.daterange ? start : start,
        end: widget.type == DatePickerType.daterange ? end : null,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isRange = widget.type == DatePickerType.daterange;

    return LayoutBuilder(builder: (context, constraints) {
      double availableWidth = MediaQuery.of(context).size.width - 20;
      bool isMobile = isRange && availableWidth < 600;
      double width = isRange ? (isMobile ? 320 : 640) : 320;

      // Adjust to actual available space if needed
      if (width > availableWidth) width = availableWidth;

      return Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: const Color(0xFFEBEEF5), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isRange) ...[
              _buildShortcuts(),
              const Divider(height: 1, color: Color(0xFFF2F6FC)),
            ],
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: SingleChildScrollView(
                child: isRange
                    ? (isMobile ? _buildMobileRangePanel() : _buildRangePanel())
                    : _buildSinglePanel(),
              ),
            ),
            const Divider(height: 1, color: Color(0xFFF2F6FC)),
            _buildFooter(),
          ],
        ),
      );
    });
  }

  Widget _buildMobileRangePanel() {
    return Column(
      children: [
        EDatePickerPanel(
          initialDisplayDate: _leftDisplayMonth,
          startDate: _startDate,
          endDate: _endDate,
          hoverDate: _hoverDate,
          onDateSelect: _onDateSelect,
          onHover: (date) {
            if (_startDate != null && _endDate == null) {
              setState(() => _hoverDate = date);
            }
          },
          size: widget.size,
        ),
        const Divider(height: 1, color: Color(0xFFEBEEF5)),
        EDatePickerPanel(
          initialDisplayDate: _rightDisplayMonth,
          startDate: _startDate,
          endDate: _endDate,
          hoverDate: _hoverDate,
          onDateSelect: _onDateSelect,
          onHover: (date) {
            if (_startDate != null && _endDate == null) {
              setState(() => _hoverDate = date);
            }
          },
          size: widget.size,
        ),
      ],
    );
  }

  Widget _buildShortcuts() {
    final shortcuts = [
      EShortcut(label: 'Last 7 days', duration: const Duration(days: 7)),
      EShortcut(label: 'Last 30 days', duration: const Duration(days: 30)),
      EShortcut(label: 'Last 6 months', duration: const Duration(days: 180)),
      EShortcut(label: 'Last year', duration: const Duration(days: 365)),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Wrap(
        spacing: 12,
        children: shortcuts
            .map((s) => Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _onShortcutClick(s),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: Text(
                        s.label,
                        style: const TextStyle(
                          fontSize: 14,
                          color: EColorTypes.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildSinglePanel() {
    return EDatePickerPanel(
      initialDisplayDate: _leftDisplayMonth,
      selectedDate: _selectedDate,
      onDateSelect: _onDateSelect,
      size: widget.size,
    );
  }

  Widget _buildRangePanel() {
    return Row(
      children: [
        Expanded(
          child: EDatePickerPanel(
            initialDisplayDate: _leftDisplayMonth,
            startDate: _startDate,
            endDate: _endDate,
            hoverDate: _hoverDate,
            onDateSelect: _onDateSelect,
            onHover: (date) {
              if (_startDate != null && _endDate == null) {
                setState(() => _hoverDate = date);
              }
            },
            size: widget.size,
          ),
        ),
        Container(width: 1, height: 300, color: const Color(0xFFEBEEF5)),
        Expanded(
          child: EDatePickerPanel(
            initialDisplayDate: _rightDisplayMonth,
            startDate: _startDate,
            endDate: _endDate,
            hoverDate: _hoverDate,
            onDateSelect: _onDateSelect,
            onHover: (date) {
              if (_startDate != null && _endDate == null) {
                setState(() => _hoverDate = date);
              }
            },
            size: widget.size,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
        border: Border(
            top: BorderSide(
                color: EDatePickerStyle.borderColor.withOpacity(0.5))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildInput(_startInputController,
                      (val) => _handleManualInput(val, true),
                      isError: _hasStartError),
                ),
                if (widget.type == DatePickerType.daterange) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      '-',
                      style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: _buildInput(_endInputController,
                        (val) => _handleManualInput(val, false),
                        isError: _hasEndError),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            height: 28,
            child: EButton(
              text: 'Cancel',
              type: EColorType.info,
              isPlain: true,
              size: ESizeItem.small,
              borderRadius: 5,
              onPressed: widget.onCancel,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 28,
            child: EButton(
              text: 'Confirm',
              type: EColorType.primary,
              size: ESizeItem.small,
              borderRadius: 5,
              color: const Color.fromRGBO(52, 79, 211, 1),
              onPressed: () {
                DateTime? finalStart;
                DateTime? finalEnd;
                bool hasError = false;

                try {
                  finalStart = DateFormat('MM/dd/yyyy')
                      .parseStrict(_startInputController.text);
                  setState(() => _hasStartError = false);
                } catch (e) {
                  setState(() => _hasStartError = true);
                  hasError = true;
                }

                if (widget.type == DatePickerType.daterange) {
                  try {
                    finalEnd = DateFormat('MM/dd/yyyy')
                        .parseStrict(_endInputController.text);
                    setState(() => _hasEndError = false);
                  } catch (e) {
                    setState(() => _hasEndError = true);
                    hasError = true;
                  }
                }

                if (!hasError) {
                  widget.onConfirm(EDatePickerValue(
                    start: finalStart,
                    end: finalEnd,
                  ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(
      TextEditingController controller, ValueChanged<String> onChanged,
      {bool isError = false}) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: isError
                ? const Color(0xFFEF4444)
                : EDatePickerStyle.selectedColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF111827),
            fontWeight: FontWeight.w500,
          ),
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            hintText: 'MM/DD/YYYY',
            hintStyle: TextStyle(fontSize: 13, color: Color(0xFFC0C4CC)),
          ),
        ),
      ),
    );
  }

  void _handleManualInput(String val, bool isStart) {
    try {
      final date = DateFormat('MM/dd/yyyy').parse(val);
      setState(() {
        if (isStart) {
          _startDate = date;
          if (widget.type != DatePickerType.daterange) {
            _selectedDate = date;
          }
          _leftDisplayMonth = DateTime(date.year, date.month);
          _rightDisplayMonth = DateTime(date.year, date.month + 1);
        } else {
          _endDate = date;
        }
      });
    } catch (e) {
      // Ignore invalid input
    }
  }
}
