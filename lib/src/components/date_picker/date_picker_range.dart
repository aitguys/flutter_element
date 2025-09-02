import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';
import '../input/input.dart';
import 'calendar_range.dart';
import 'package:intl/intl.dart';

class EDatePickerRange extends StatefulWidget {
  final TextEditingController? startController;
  final TextEditingController? endController;
  final String? format;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool disabled;
  final bool clearable;
  final ESizeItem size;
  final Widget? prefix;
  final Widget? suffix;
  final EColorType colorType;
  final Color? customColor;
  final Color defaultColor;
  final double? customHeight;
  final double? customFontSize;
  final double? customBorderRadius;
  final ValueChanged<DateTimeRange?>? onRangeSelect;
  final String? startPlaceholder;
  final String? endPlaceholder;
  final String? separator;

  const EDatePickerRange({
    super.key,
    this.startController,
    this.endController,
    this.onRangeSelect,
    this.format,
    this.minDate,
    this.maxDate,
    this.startPlaceholder = '开始日期',
    this.endPlaceholder = '结束日期',
    this.separator = '至',
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
  State<EDatePickerRange> createState() => _EDatePickerRangeState();
}

class _EDatePickerRangeState extends State<EDatePickerRange> {
  late TextEditingController _startController;
  late TextEditingController _endController;
  late FocusNode _startFocusNode;
  late FocusNode _endFocusNode;
  DateTimeRange? _selectedRange;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _startController = widget.startController ?? TextEditingController();
    _endController = widget.endController ?? TextEditingController();
    _startFocusNode = FocusNode();
    _endFocusNode = FocusNode();
  }

  @override
  void didUpdateWidget(EDatePickerRange oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startController?.text != oldWidget.startController?.text) {
      _startController.text = widget.startController?.text ?? '';
    }
    if (widget.endController?.text != oldWidget.endController?.text) {
      _endController.text = widget.endController?.text ?? '';
    }
  }

  void _showCalendar() {
    if (widget.disabled || _isDisposed) return;
    
    _removeOverlay();
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    final screenSize = MediaQuery.of(context).size;
    const double popupHeight = 400;
    const double margin = 8;

    final bottomSpace = screenSize.height - offset.dy - size.height - margin;
    double topOffset;

    if (bottomSpace >= popupHeight) {
      topOffset = size.height + margin;
    } else {
      topOffset = -popupHeight - margin;
    }

    const double popupWidth = 600;

    final leftSpace = offset.dx;
    final rightSpace = screenSize.width - offset.dx - size.width;
    double leftOffset = 0;

    if (leftSpace >= popupWidth / 2 && rightSpace >= popupWidth / 2) {
      leftOffset = -(popupWidth / 2) + (size.width / 2);
    } else if (leftSpace < popupWidth / 2) {
      leftOffset = -leftSpace + margin;
    } else {
      leftOffset = -(popupWidth - rightSpace) + margin;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx + leftOffset,
        top: offset.dy + topOffset,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: popupWidth,
            height: popupHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: widget.customColor ?? 
                       Theme.of(context).primaryColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: CalendarRange(
              initialRange: _selectedRange,
              minDate: widget.minDate,
              maxDate: widget.maxDate,
              format: widget.format,
              onSelect: (range) {
                if (range != null) {
                  setState(() {
                    _selectedRange = range;
                  });
                  
                  final formatter = DateFormat(widget.format ?? 'yyyy-MM-dd');
                  _startController.text = formatter.format(range.start);
                  _endController.text = formatter.format(range.end);
                  
                  widget.onRangeSelect?.call(range);
                }
                _removeOverlay();
              },
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
    _isDisposed = true;
    _removeOverlay();
    if (widget.startController == null) {
      _startController.dispose();
    }
    if (widget.endController == null) {
      _endController.dispose();
    }
    _startFocusNode.dispose();
    _endFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: EInput(
            textController: _startController,
            placeholder: widget.startPlaceholder,
            disabled: widget.disabled,
            clearable: widget.clearable,
            size: widget.size,
            prefix: widget.prefix,
            colorType: widget.colorType,
            customColor: widget.customColor,
            borderColor: widget.defaultColor,
            customHeight: widget.customHeight,
            customFontSize: widget.customFontSize,
            customBorderRadius: widget.customBorderRadius,
            onFocus: _showCalendar,
            readOnly: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            widget.separator!,
            style: TextStyle(
              color: widget.disabled ? Colors.grey : Colors.black87,
              fontSize: widget.customFontSize ?? 14,
            ),
          ),
        ),
        Expanded(
          child: EInput(
            textController: _endController,
            placeholder: widget.endPlaceholder,
            disabled: widget.disabled,
            clearable: widget.clearable,
            size: widget.size,
            suffix: widget.suffix,
            colorType: widget.colorType,
            customColor: widget.customColor,
            borderColor: widget.defaultColor,
            customHeight: widget.customHeight,
            customFontSize: widget.customFontSize,
            customBorderRadius: widget.customBorderRadius,
            onFocus: _showCalendar,
            readOnly: true,
          ),
        ),
      ],
    );
  }
}
