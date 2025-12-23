import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/index.dart';
import '../input/input.dart';
import 'date_picker_style.dart';
import 'date_picker_model.dart';
import 'internal/date_picker_popup.dart';

class EDatePicker extends StatefulWidget {
  final TextEditingController? textController;
  final String? format;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DatePickerType type;
  final String? placeholder;
  final bool disabled;
  final bool clearable;
  final bool readOnly;
  final ESizeItem size;
  final Widget? prefix;
  final Widget? suffix;
  final EColorType colorType;
  final Color? customColor;
  final Color borderColor;
  final double? customHeight;
  final double? customFontSize;
  final double? customBorderRadius;
  final ValueChanged<String?>? onSelect;
  final ValueChanged<EDatePickerValue>? onValueChange;

  const EDatePicker({
    super.key,
    this.textController,
    this.onSelect,
    this.onValueChange,
    this.format,
    this.type = DatePickerType.date,
    this.minDate,
    this.maxDate,
    this.placeholder = 'Select date',
    this.disabled = false,
    this.clearable = true,
    this.readOnly = false,
    this.prefix,
    this.suffix,
    this.colorType = EColorType.primary,
    this.customColor,
    this.borderColor = EBasicColors.borderGray,
    this.size = ESizeItem.medium,
    this.customHeight,
    this.customFontSize,
    this.customBorderRadius,
  });

  @override
  State<EDatePicker> createState() => _EDatePickerState();

  EDatePicker copyWith({
    TextEditingController? textController,
    String? format,
    DateTime? minDate,
    DateTime? maxDate,
    DatePickerType? type,
    String? placeholder,
    bool? disabled,
    bool? clearable,
    bool? readOnly,
    ESizeItem? size,
    Widget? prefix,
    Widget? suffix,
    EColorType? colorType,
    Color? customColor,
    Color? borderColor,
    double? customHeight,
    double? customFontSize,
    double? customBorderRadius,
    ValueChanged<String?>? onSelect,
    ValueChanged<EDatePickerValue>? onValueChange,
  }) {
    return EDatePicker(
      textController: textController ?? this.textController,
      format: format ?? this.format,
      minDate: minDate ?? this.minDate,
      maxDate: maxDate ?? this.maxDate,
      type: type ?? this.type,
      placeholder: placeholder ?? this.placeholder,
      disabled: disabled ?? this.disabled,
      clearable: clearable ?? this.clearable,
      readOnly: readOnly ?? this.readOnly,
      size: size ?? this.size,
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
      colorType: colorType ?? this.colorType,
      customColor: customColor ?? this.customColor,
      borderColor: borderColor ?? this.borderColor,
      customHeight: customHeight ?? this.customHeight,
      customFontSize: customFontSize ?? this.customFontSize,
      customBorderRadius: customBorderRadius ?? this.customBorderRadius,
      onSelect: onSelect ?? this.onSelect,
      onValueChange: onValueChange ?? this.onValueChange,
    );
  }
}

class _EDatePickerState extends State<EDatePicker> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isDisposed = false;

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _controller = widget.textController ?? TextEditingController();
    _focusNode = FocusNode();
    _parseInitialValue();
  }

  void _parseInitialValue() {
    if (_controller.text.isEmpty) return;
    try {
      final fmt = widget.format ?? 'MM/dd/yyyy';
      if (widget.type == DatePickerType.daterange) {
        final parts = _controller.text.split(' - ');
        if (parts.length == 2) {
          _startDate = DateFormat(fmt).parse(parts[0]);
          _endDate = DateFormat(fmt).parse(parts[1]);
        }
      } else {
        _startDate = DateFormat(fmt).parse(_controller.text);
      }
    } catch (e) {
      // Ignore
    }
  }

  void _showPicker() {
    if (widget.disabled || _isDisposed || widget.readOnly) return;
    _removeOverlay();

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final viewPortSize = MediaQuery.of(context).size;

    // Predicted popup size - matches EDatePickerPopup internal defaults
    bool isRange = widget.type == DatePickerType.daterange;
    bool isMobileWidth = viewPortSize.width < 600;
    double popupWidth = isRange ? (isMobileWidth ? 320 : 640) : 320;
    double popupHeight = isRange ? (isMobileWidth ? 720 : 400) : 400;

    // Adjust width if screen is small
    if (popupWidth > viewPortSize.width - 20) {
      popupWidth = viewPortSize.width - 20;
    }

    // Determine vertical position
    bool showAbove = false;
    if (offset.dy + size.height + popupHeight > viewPortSize.height - 10 &&
        offset.dy > popupHeight + 10) {
      showAbove = true;
    }

    // Determine horizontal position (防止超出右边界)
    double horizontalOffset = 0;
    if (offset.dx + popupWidth > viewPortSize.width - 10) {
      horizontalOffset = (viewPortSize.width - offset.dx - popupWidth - 10);
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _removeOverlay,
              child: Container(color: Colors.transparent),
            ),
          ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            targetAnchor: showAbove ? Alignment.topLeft : Alignment.bottomLeft,
            followerAnchor:
                showAbove ? Alignment.bottomLeft : Alignment.topLeft,
            offset: Offset(horizontalOffset, showAbove ? -4 : 4),
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(4),
              child: EDatePickerPopup(
                type: widget.type,
                initialStartDate: _startDate,
                initialEndDate: _endDate,
                initialDate: _startDate,
                size: widget.size,
                onCancel: _removeOverlay,
                onConfirm: (value) {
                  setState(() {
                    _startDate = value.start;
                    _endDate = value.end;
                    _updateText();
                  });
                  widget.onValueChange?.call(value);
                  widget.onSelect?.call(_controller.text);
                  _removeOverlay();
                },
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _updateText() {
    final fmt = widget.format ?? 'MM/dd/yyyy';
    if (widget.type == DatePickerType.daterange) {
      if (_startDate != null && _endDate != null) {
        _controller.text =
            '${DateFormat(fmt).format(_startDate!)} - ${DateFormat(fmt).format(_endDate!)}';
      } else {
        _controller.text = '';
      }
    } else {
      if (_startDate != null) {
        _controller.text = DateFormat(fmt).format(_startDate!);
      } else {
        _controller.text = '';
      }
    }
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
    if (!_isDisposed) {
      _focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _removeOverlay();
    if (widget.textController == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _showPicker,
        child: EInput(
          textController: _controller,
          focusNode: _focusNode,
          placeholder: widget.placeholder,
          clearable: widget.clearable,
          disabled: widget.disabled,
          prefix: widget.prefix ??
              const Icon(Icons.calendar_month_rounded, size: 20),
          suffix: widget.suffix,
          size: widget.size,
          readOnly: widget.readOnly,
          onFocus: _showPicker,
          onBlur: () {
            // Optional: validate manual input here if needed
          },
          colorType: widget.colorType,
          customColor: widget.customColor,
          borderColor: widget.borderColor,
          customHeight: widget.customHeight,
          customFontSize: widget.customFontSize,
          customBorderRadius: widget.customBorderRadius,
        ),
      ),
    );
  }
}
