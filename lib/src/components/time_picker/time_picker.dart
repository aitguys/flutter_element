import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';

class ETimePicker extends StatefulWidget {
  final DateTime? value;
  final ValueChanged<TimeOfDay>? onChange;
  final String? placeholder;
  final Widget? prefix;
  final ESizeItem size;
  const ETimePicker({
    super.key,
    this.value,
    this.onChange,
    this.placeholder = '请选择时间',
    this.prefix,
    this.size = ESizeItem.medium,
  });

  @override
  State<ETimePicker> createState() => _ETimePickerState();
}

class _ETimePickerState extends State<ETimePicker> {
  late TimeOfDay _selected;
  late TextEditingController _controller;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isHovered = false;
  bool _isOpen = false;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  int _selectedHour = 0;
  int _selectedMinute = 0;
  int _selectedSecond = 0;
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _secondController;
  Widget? _defaultPrefix;
  @override
  void initState() {
    super.initState();
    final now = widget.value ?? DateTime.now();
    _selected = TimeOfDay(hour: now.hour, minute: now.minute);
    _selectedHour = _selected.hour;
    _selectedMinute = _selected.minute;
    _selectedSecond = 0;
    _controller = TextEditingController(
      text: _formatTime(_selected),
    );
    print('widget.value: $_isHovered');
    print('widget.value: $_isFocused');
    _focusNode.addListener(_handleFocusChange);
    _hourController = FixedExtentScrollController(initialItem: _selectedHour);
    _minuteController =
        FixedExtentScrollController(initialItem: _selectedMinute);
    _secondController =
        FixedExtentScrollController(initialItem: _selectedSecond);
    _defaultPrefix = widget.prefix ??
        Icon(
          Icons.access_time,
          size: ElememtSize(size: widget.size).getIconSize(),
          color: EColorTypes.primary,
        );
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus && !_isOpen) {
      _showPicker();
    }
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  String _formatTime(TimeOfDay t) {
    final h = _selectedHour.toString().padLeft(2, '0');
    final m = _selectedMinute.toString().padLeft(2, '0');
    final s = _selectedSecond.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  void _showPicker() {
    if (_overlayEntry != null) {
      return;
    }

    final int initialHour = _selectedHour;
    final int initialMinute = _selectedMinute;
    final int initialSecond = _selectedSecond;

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
                              max: 23,
                              onChanged: (v) {
                                setState(() {
                                  _selectedHour = v;
                                  _selected = TimeOfDay(
                                      hour: v, minute: _selectedMinute);
                                  _controller.text = _formatTime(_selected);
                                });
                              },
                              controller: _hourController,
                            ),
                            const SizedBox(width: 8),
                            _buildPicker(
                              value: _selectedMinute,
                              max: 59,
                              onChanged: (v) {
                                setState(() {
                                  _selectedMinute = v;
                                  _selected =
                                      TimeOfDay(hour: _selectedHour, minute: v);
                                  _controller.text = _formatTime(_selected);
                                });
                              },
                              controller: _minuteController,
                            ),
                            const SizedBox(width: 8),
                            _buildPicker(
                              value: _selectedSecond,
                              max: 59,
                              onChanged: (v) {
                                setState(() {
                                  _selectedSecond = v;
                                  _controller.text = _formatTime(_selected);
                                });
                              },
                              controller: _secondController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedHour = initialHour;
                                  _selectedMinute = initialMinute;
                                  _selectedSecond = initialSecond;
                                  _selected = TimeOfDay(
                                      hour: _selectedHour,
                                      minute: _selectedMinute);
                                  _controller.text = _formatTime(_selected);
                                  _hourController.jumpToItem(_selectedHour);
                                  _minuteController.jumpToItem(_selectedMinute);
                                  _secondController.jumpToItem(_selectedSecond);
                                });
                                _hidePicker();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                widget.onChange?.call(TimeOfDay(
                                    hour: _selectedHour,
                                    minute: _selectedMinute));
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
    setState(() {
      _isOpen = true;
    });
  }

  void _hidePicker() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
    });
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
          setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ElememtSize(size: widget.size).getContainerHeight(),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isOpen ? Colors.blue : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: CompositedTransformTarget(
            link: _layerLink,
            child: Row(
              children: [
                SizedBox(
                  child: Center(
                    child: _defaultPrefix,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: _showPicker,
                    child: TextFormField(
                      controller: _controller,
                      focusNode: _focusNode,
                      readOnly: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        isCollapsed: true,
                        hintText: widget.placeholder,
                      ),
                      style: const TextStyle(fontSize: 16),
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
    _overlayEntry?.remove();
    _focusNode.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    _secondController.dispose();
    super.dispose();
  }
}
