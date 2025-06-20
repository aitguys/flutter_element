// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';
import '../input/input.dart';
import 'calendar.dart';
import 'package:intl/intl.dart';

class EDatePicker extends StatefulWidget {
  final String? value;
  final String? format;
  final DateTime? minDate;
  final DateTime? maxDate;
  final CalendarType type;
  // 继承自input
  final String? placeholder;
  final bool disabled;
  final bool clearable;
  final ESizeItem size;
  final Widget? prefix;
  final Widget? suffix;
  final bool weekDate;
  final Widget? prevMonth;
  final Widget? nextMonth;
  final Widget? prevYear;
  final Widget? nextYear;
  final EColorType colorType;
  final Color? customColor;
  final Color defaultColor;
  final double? customHeight;
  final double? customFontSize;
  final double? customBorderRadius;
  final ValueChanged<String?>? onSelect;
  const EDatePicker({
    super.key,
    this.value,
    this.onSelect,
    this.format,
    this.type = CalendarType.date,
    this.weekDate = false,
    this.minDate,
    this.maxDate,
    this.prevMonth = const Icon(Icons.chevron_left, size: 20),
    this.nextMonth = const Icon(Icons.chevron_right, size: 20),
    this.prevYear = const Icon(Icons.keyboard_double_arrow_left, size: 20),
    this.nextYear = const Icon(Icons.keyboard_double_arrow_right, size: 20),
    // 继承自input
    this.placeholder = '选择日期',
    this.disabled = false,
    this.clearable = true,
    this.prefix,
    this.suffix,
    this.colorType = EColorType.primary,
    this.customColor,
    this.defaultColor = EBasicColors.borderGray,
    this.size = ESizeItem.medium,
    this.customHeight,
    this.customFontSize,
    this.customBorderRadius,
  });
  @override
  State<EDatePicker> createState() => _EDatePickerState();
}

class _EDatePickerState extends State<EDatePicker> {
  late TextEditingController _controller;
  String? _selectedDate;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isDisposed = false; // 添加标志防止重复销毁

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.value;
    _controller = TextEditingController(
      text: _selectedDate ?? '',
    );
  }

  @override
  void didUpdateWidget(EDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _selectedDate = widget.value;
      _controller.text = _selectedDate ?? '';
    }
  }

  void _showCalendar() {
    if (widget.disabled || _isDisposed) return; // 添加disposed检查
    if (_controller.text.isNotEmpty) {
      _selectedDate = _controller.text;
    }
    _removeOverlay();
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    // 获取屏幕尺寸和弹窗高度
    final screenSize = MediaQuery.of(context).size;
    final double popupHeight =
        widget.weekDate && widget.type == CalendarType.date
            ? 180
            : 320; // 周视图高度较小
    const double margin = 8; // 边距

    // 计算底部可用空间
    final bottomSpace = screenSize.height - offset.dy - size.height - margin;

    // 动态决定弹窗位置
    double topOffset;

    if (bottomSpace >= popupHeight) {
      // 底部空间充足：显示在下方
      topOffset = size.height + margin;
    } else {
      // 底部空间不足：显示在上方
      if (widget.type == CalendarType.dates) {
        topOffset = -430;
      } else if (widget.type == CalendarType.date) {
        if (widget.weekDate) {
          topOffset = -180; // 周视图高度较小
        } else {
          topOffset = -390;
        }
      } else if (widget.type == CalendarType.years ||
          widget.type == CalendarType.months) {
        topOffset = -260;
      } else if (widget.type == CalendarType.year ||
          widget.type == CalendarType.month) {
        topOffset = -220;
      } else {
        topOffset = -220;
      }
    }

    final bool isWeekView = widget.weekDate && widget.type == CalendarType.date;
    final double popupWidth = isWeekView ? 400 : 320;

    // 计算左右可用空间
    final leftSpace = offset.dx;
    final rightSpace = screenSize.width - offset.dx - size.width;

    // 动态决定水平偏移
    double leftOffset = 0;
    if (rightSpace < popupWidth) {
      // 右侧空间不足,向左偏移
      leftOffset = -(popupWidth - size.width);
    }
    if (leftSpace + leftOffset < 0) {
      // 左侧空间不足,调整偏移确保不超出左边界
      leftOffset = -leftSpace;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _removeOverlay,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            width: popupWidth,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(leftOffset, topOffset),
              child: GestureDetector(
                onTap: () {},
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
                      size: widget.size,
                      maxDate: widget.maxDate,
                      onSelect: (date) {
                        _removeOverlay();
                        if (date != null && !_isDisposed) { // 添加disposed检查
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
                          widget.onSelect?.call(date);
                        }
                      },
                      prevMonth: widget.prevMonth,
                      nextMonth: widget.nextMonth,
                      prevYear: widget.prevYear,
                      nextYear: widget.nextYear,
                      format: widget.format ?? getDefaultFormat(widget.type),
                      weekDate: widget.weekDate,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  @override
  void dispose() {
    _isDisposed = true; // 设置销毁标志
    _removeOverlay();
    _controller.dispose(); // 直接销毁控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          if (!widget.disabled && !_isDisposed) {
            _showCalendar();
          }
        },
        child: EInput(
          textController: _controller,
          placeholder: widget.placeholder,
          clearable: widget.clearable,
          disabled: widget.disabled,
          prefix:
              widget.prefix ?? const Icon(Icons.calendar_month_rounded, size: 20),
          suffix: widget.suffix,
          size: widget.size,
          readOnly: true,
          onFocus: _showCalendar,
          colorType: widget.colorType,
          customColor: widget.customColor,
          borderColor: widget.defaultColor,
          customHeight: widget.customHeight,
          customFontSize: widget.customFontSize,
          customBorderRadius: widget.customBorderRadius,
        ),
      ),
    );
  }
}
