import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';
import 'package:flutter_element_plus/src/components/input/input.dart';

/// A time picker component that allows users to select a time of day.
/// It follows Element Plus design guidelines and provides features like:
/// - Hour, minute, and second selection
/// - 12/24 hour format support
/// - Customizable placeholder text
/// - Custom prefix icon
/// - Different sizes
/// - Dropdown picker interface
///
/// Example:
/// ```dart
/// ETimePicker(
///   value: DateTime.now(),
///   placeholder: 'Select time',
///   use24HourFormat: false,
///   onChange: (time) {
///     print('Selected time: ${time.hour}:${time.minute}');
///   },
/// )
/// ```
class ETimePicker extends StatefulWidget {
  /// The currently selected time.
  /// If null, the current time will be used as default.
  final DateTime? value;

  /// Callback function when the selected time changes.
  /// The callback receives a TimeOfDay object with the selected hour and minute.
  final ValueChanged<TimeOfDay>? onChange;

  /// The placeholder text to display when no time is selected.
  /// Default is '请选择时间'.
  final String? placeholder;

  /// A custom widget to display before the time input.
  /// If not provided, a clock icon will be used as default.
  final Widget? prefix;

  /// The size of the time picker.
  /// Affects the height and font size of the component.
  final ESizeItem size;

  /// Whether the input is disabled.
  final bool disabled;

  /// Whether the input is read-only.
  final bool readOnly;

  /// Whether to show a clear button when the input has text.
  final bool clearable;

  /// The color type of the input.
  final EColorType colorType;

  /// A custom color to use for the input.
  final Color? customColor;

  /// The default color for the input's border.
  final Color defaultColor;

  /// A custom height for the input.
  final double? customHeight;

  /// A custom font size for the input text.
  final double? customFontSize;

  /// A custom border radius for the input.
  final double? customBorderRadius;

  /// Whether to show the placeholder text above the input when focused.
  final bool showPlaceholderOnTop;

  /// Whether to use 24-hour format (true) or 12-hour format with AM/PM (false)
  final bool use24HourFormat;

  /// Callback function when the input gains focus.
  final VoidCallback? onFocus;

  /// Callback function when the input loses focus.
  final VoidCallback? onBlur;

  /// Callback function when the input is cleared.
  final VoidCallback? onClear;

  const ETimePicker({
    super.key,
    this.value,
    this.onChange,
    this.placeholder = '请选择时间',
    this.prefix,
    this.size = ESizeItem.medium,
    this.disabled = false,
    this.readOnly = false,
    this.clearable = false,
    this.colorType = EColorType.primary,
    this.customColor,
    this.defaultColor = EBasicColors.borderGray,
    this.customHeight,
    this.customFontSize,
    this.customBorderRadius,
    this.showPlaceholderOnTop = false,
    this.use24HourFormat = true,
    this.onFocus,
    this.onBlur,
    this.onClear,
  });

  @override
  State<ETimePicker> createState() => _ETimePickerState();
}

class _ETimePickerState extends State<ETimePicker> {
  late TextEditingController _controller;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  TimeOfDay? _selected;
  int _selectedHour = 0;
  int _selectedMinute = 0;
  int _selectedSecond = 0;
  bool _isAM = true;
  bool _isDisposed = false;

  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _secondController;
  late FixedExtentScrollController _periodController;
  Widget? _defaultPrefix;

  @override
  void initState() {
    super.initState();
    final now = widget.value ?? DateTime.now();
    _selected = TimeOfDay(hour: now.hour, minute: now.minute);
    _selectedHour =
        widget.use24HourFormat ? _selected!.hour : _selected!.hourOfPeriod;
    _selectedMinute = _selected!.minute;
    _selectedSecond = now.second;
    _isAM = _selected!.hour < 12;
    _controller = TextEditingController(
      text: _formatTime(_selected!),
    );
    _hourController = FixedExtentScrollController(initialItem: _selectedHour);
    _minuteController =
        FixedExtentScrollController(initialItem: _selectedMinute);
    _secondController =
        FixedExtentScrollController(initialItem: _selectedSecond);
    _periodController = FixedExtentScrollController(initialItem: _isAM ? 0 : 1);
    _defaultPrefix = widget.prefix ??
        Icon(
          Icons.access_time,
          size: ElememtSize(size: widget.size).getIconSize(),
          color: EColorTypes.primary,
        );
  }

  String _formatTime(TimeOfDay t) {
    final h = widget.use24HourFormat
        ? _selectedHour.toString().padLeft(2, '0')
        : (_selectedHour == 0 ? '12' : _selectedHour.toString())
            .padLeft(2, '0');
    final m = _selectedMinute.toString().padLeft(2, '0');
    final s = _selectedSecond.toString().padLeft(2, '0');
    final period = widget.use24HourFormat ? '' : (_isAM ? ' AM' : ' PM');
    return '$h:$m:$s$period';
  }

  void _showPicker() {
    if (_overlayEntry != null || widget.disabled || widget.readOnly) {
      return;
    }

    final int initialHour = _selectedHour;
    final int initialMinute = _selectedMinute;
    final int initialSecond = _selectedSecond;
    final bool initialIsAM = _isAM;

    _overlayEntry = OverlayEntry(
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return GestureDetector(
          onTap: _hidePicker,
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              Positioned.fill(child: Container(color: Colors.transparent)),
              CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: const Offset(0, 48),
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 320,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildPicker(
                              value: _selectedHour,
                              max: widget.use24HourFormat ? 23 : 11,
                              onChanged: (v) {
                                if (!_isDisposed) {
                                  setState(() {
                                    _selectedHour = v;
                                    if (!widget.use24HourFormat) {
                                      final actualHour = _isAM ? v : (v + 12);
                                      _selected = TimeOfDay(
                                          hour: actualHour,
                                          minute: _selectedMinute);
                                    } else {
                                      _selected = TimeOfDay(
                                          hour: v, minute: _selectedMinute);
                                    }
                                    _controller.text = _formatTime(_selected!);
                                  });
                                }
                              },
                              controller: _hourController,
                            ),
                            const SizedBox(width: 8),
                            _buildPicker(
                              value: _selectedMinute,
                              max: 59,
                              onChanged: (v) {
                                if (!_isDisposed) {
                                  setState(() {
                                    _selectedMinute = v;
                                    final hour = widget.use24HourFormat
                                        ? _selectedHour
                                        : (_isAM
                                            ? _selectedHour
                                            : _selectedHour + 12);
                                    _selected =
                                        TimeOfDay(hour: hour, minute: v);
                                    _controller.text = _formatTime(_selected!);
                                  });
                                }
                              },
                              controller: _minuteController,
                            ),
                            const SizedBox(width: 8),
                            _buildPicker(
                              value: _selectedSecond,
                              max: 59,
                              onChanged: (v) {
                                if (!_isDisposed) {
                                  setState(() {
                                    _selectedSecond = v;
                                    _controller.text = _formatTime(_selected!);
                                  });
                                }
                              },
                              controller: _secondController,
                            ),
                            if (!widget.use24HourFormat) ...[
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 60,
                                height: 150,
                                child: ListWheelScrollView.useDelegate(
                                  itemExtent: 36,
                                  diameterRatio: 1.2,
                                  physics: const FixedExtentScrollPhysics(),
                                  controller: _periodController,
                                  onSelectedItemChanged: (index) {
                                    if (!_isDisposed) {
                                      setState(() {
                                        _isAM = index == 0;
                                        final actualHour = _isAM
                                            ? _selectedHour
                                            : (_selectedHour + 12);
                                        _selected = TimeOfDay(
                                            hour: actualHour,
                                            minute: _selectedMinute);
                                        _controller.text =
                                            _formatTime(_selected!);
                                      });
                                    }
                                  },
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 2,
                                    builder: (context, index) {
                                      final isSelected =
                                          _periodController.selectedItem ==
                                              index;
                                      return Center(
                                        child: Text(
                                          index == 0 ? 'AM' : 'PM',
                                          style: TextStyle(
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            fontSize: 18,
                                            color: isSelected
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                if (!_isDisposed) {
                                  setState(() {
                                    _selectedHour = initialHour;
                                    _selectedMinute = initialMinute;
                                    _selectedSecond = initialSecond;
                                    _isAM = initialIsAM;
                                    final hour = widget.use24HourFormat
                                        ? _selectedHour
                                        : (_isAM
                                            ? _selectedHour
                                            : _selectedHour + 12);
                                    _selected = TimeOfDay(
                                        hour: hour, minute: _selectedMinute);
                                    _controller.text = _formatTime(_selected!);
                                    _hourController.jumpToItem(_selectedHour);
                                    _minuteController
                                        .jumpToItem(_selectedMinute);
                                    _secondController
                                        .jumpToItem(_selectedSecond);
                                    if (!widget.use24HourFormat) {
                                      _periodController
                                          .jumpToItem(_isAM ? 0 : 1);
                                    }
                                  });
                                }
                                _hidePicker();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                if (!_isDisposed) {
                                  final hour = widget.use24HourFormat
                                      ? _selectedHour
                                      : (_isAM
                                          ? _selectedHour
                                          : _selectedHour + 12);
                                  widget.onChange?.call(TimeOfDay(
                                      hour: hour, minute: _selectedMinute));
                                }
                                _hidePicker();
                              },
                              child: const Text('OK',
                                  style: TextStyle(color: Colors.blue)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
    Overlay.of(context).insert(_overlayEntry!);
    if (!_isDisposed) {
      setState(() {
        // _isOpen = true;
      });
    }
  }

  void _hidePicker() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (!_isDisposed) {
      setState(() {
        // _isOpen = false;
      });
    }
  }

  Widget _buildPicker({
    required int value,
    required int max,
    required ValueChanged<int> onChanged,
    required FixedExtentScrollController controller,
  }) {
    return SizedBox(
      width: 60,
      height: 150,
      child: NotificationListener<ScrollNotification>(
        onNotification: (_) {
          if (!_isDisposed) {
            setState(() {});
          }
          return false;
        },
        child: ListWheelScrollView.useDelegate(
          itemExtent: 36,
          diameterRatio: 1.2,
          physics: const FixedExtentScrollPhysics(),
          controller: controller,
          onSelectedItemChanged: onChanged,
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: max + 1,
            builder: (context, idx) {
              final isSelected = controller.selectedItem == idx;
              return Center(
                child: Text(
                  idx.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 18,
                    color: isSelected ? Colors.black : Colors.grey,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleClear() {
    if (!_isDisposed) {
      setState(() {
        _controller.clear();
        _selectedHour = 0;
        _selectedMinute = 0;
        _selectedSecond = 0;
        _isAM = true;
        _selected = const TimeOfDay(hour: 0, minute: 0);
      });
      widget.onClear?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: EInput(
        textController: _controller,
        placeholder: widget.placeholder,
        prefix: _defaultPrefix,
        disabled: widget.disabled,
        readOnly: widget.readOnly,
        clearable: widget.clearable,
        colorType: widget.colorType,
        customColor: widget.customColor,
        borderColor: widget.defaultColor,
        size: widget.size,
        customHeight: widget.customHeight,
        customFontSize: widget.customFontSize,
        customBorderRadius: widget.customBorderRadius,
        showPlaceholderOnTop: widget.showPlaceholderOnTop,
        onFocus: () {
          widget.onFocus?.call();
          _showPicker();
        },
        onBlur: widget.onBlur,
        onClear: _handleClear,
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    _overlayEntry?.remove();
    _hourController.dispose();
    _minuteController.dispose();
    _secondController.dispose();
    _periodController.dispose();
    super.dispose();
  }
}
