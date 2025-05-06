import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:math';
import 'package:flutter_element/src/methods/index.dart';

class EColorPicker extends StatefulWidget {
  final Color? value;
  final ValueChanged<Color>? onChange;
  final bool showAlpha;
  final List<Color>? predefine;
  final bool disabled;
  final String? size;
  final double? width;

  const EColorPicker({
    Key? key,
    this.value,
    this.onChange,
    this.showAlpha = false,
    this.predefine,
    this.disabled = false,
    this.size,
    this.width,
  }) : super(key: key);

  @override
  State<EColorPicker> createState() => _EColorPickerState();
}

class _EColorPickerState extends State<EColorPicker> {
  final GlobalKey _buttonKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  Color _currentColor = Colors.blue;
  Color? _tempColor;
  bool _isOpen = false;
  TextEditingController? _hexInputController;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.value ?? Colors.blue;
    _hexInputController =
        TextEditingController(text: _colorToHex(_currentColor));
  }

  @override
  void dispose() {
    _hexInputController?.dispose();
    super.dispose();
  }

  String _colorToHex(Color color) {
    print('red: $color');

    return widget.showAlpha
        ? '${color.r.toInt().toRadixString(16).padLeft(2, '0')}${color.g.toInt().toRadixString(16).padLeft(2, '0')}${color.b.toInt().toRadixString(16).padLeft(2, '0')}${color.a.toInt().toRadixString(16).padLeft(2, '0')}'
        : '${color.r.toInt().toRadixString(16).padLeft(2, '0')}${color.g.toInt().toRadixString(16).padLeft(2, '0')}${color.b.toInt().toRadixString(16).padLeft(2, '0')}';
  }

  void _showColorPicker() {
    if (widget.disabled) return;

    _tempColor = _currentColor;

    final RenderBox button =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final buttonPosition = button.localToGlobal(Offset.zero);
    final overlayPosition = overlay.localToGlobal(Offset.zero);

    final left = buttonPosition.dx - overlayPosition.dx;
    final top = buttonPosition.dy - overlayPosition.dy + button.size.height;

    // Calculate available space below and above
    final screenHeight = MediaQuery.of(context).size.height;
    final spaceBelow = screenHeight - (buttonPosition.dy + button.size.height);
    final spaceAbove = buttonPosition.dy;

    // Determine if we should show above or below
    final showAbove = spaceBelow < 480 && spaceAbove > spaceBelow;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _hideColorPicker,
              behavior: HitTestBehavior.opaque,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            left: left,
            top: showAbove ? null : top,
            bottom: showAbove ? (screenHeight - buttonPosition.dy) : null,
            child: Material(
              elevation: 4,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: widget.width ??
                      min(400, MediaQuery.of(context).size.width * 0.8),
                  constraints: BoxConstraints(maxHeight: 480),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildColorPicker(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
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
    setState(() => _isOpen = true);
  }

  void _hideColorPicker() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  Widget _buildColorPicker() {
    Debouncer colorDebouncer = Debouncer(milliseconds: 200);
    return Column(
      children: [
        ColorPicker(
          pickerColor: _currentColor,
          onColorChanged: (color) {
            if (color != _currentColor &&
                color != Color.from(alpha: 0, red: 0, green: 0, blue: 0)) {
              colorDebouncer.run(() {
                setState(() {
                  print('执行');
                  _tempColor = color;
                  _currentColor = color;
                  _hexInputController?.text = _colorToHex(color);
                  widget.onChange?.call(color);
                });
              });
            }
          },
          colorPickerWidth: 400,
          pickerAreaHeightPercent: 0.5,
          enableAlpha: widget.showAlpha,
          labelTypes: const [],
          displayThumbColor: true,
          pickerAreaBorderRadius: BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
          ),
          portraitOnly: true,
          hexInputController: _hexInputController,
        ),
        if (widget.predefine != null) _buildPredefineColors(),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: CupertinoTextField(
                  controller: _hexInputController,
                  prefix: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(Icons.tag)),
                  suffix: IconButton(
                      onPressed: () async {
                        final data = await Clipboard.getData('text/plain');
                        if (data != null && data.text != null) {
                          _hexInputController?.text = data.text!;
                          // TODO: Convert hex to color and update
                        }
                      },
                      icon: const Icon(Icons.content_paste_go_rounded)),
                  onChanged: (value) {
                    if (value.length >= 6) {
                      try {
                        final color = Color(int.parse(
                            '0xFF${value.substring(value.length - 6)}'));
                        setState(() {
                          _tempColor = color;
                          _currentColor = color;
                        });
                      } catch (e) {
                        print('Invalid hex color');
                      }
                    }
                  },
                  maxLength: widget.showAlpha ? 8 : 6,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9A-Fa-f]')),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _tempColor = Colors.blue;
                      setState(() {
                        _currentColor = Colors.blue;
                      });
                      _hexInputController?.text = _colorToHex(Colors.blue);
                      widget.onChange?.call(Colors.blue);
                      _hideColorPicker();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Text(
                      'Clear',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _currentColor = _tempColor!;
                      });
                      widget.onChange?.call(_currentColor);
                      _hideColorPicker();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildPredefineColors() {
    if (widget.predefine == null) return SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.predefine!.map((color) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _tempColor = color;
              _currentColor = color;
              _hexInputController?.text = _colorToHex(color);
              _overlayEntry?.markNeedsBuild();
            });
          },
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: _currentColor == color ? Colors.blue : Colors.grey,
                width: _currentColor == color ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: GestureDetector(
        key: _buttonKey,
        onTap: _isOpen ? _hideColorPicker : _showColorPicker,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: widget.size == 'large'
                    ? 40
                    : widget.size == 'small'
                        ? 24
                        : 32,
                height: widget.size == 'large'
                    ? 40
                    : widget.size == 'small'
                        ? 24
                        : 32,
                decoration: BoxDecoration(
                  color: widget.disabled ? Colors.grey[300] : _currentColor,
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              if (widget.disabled && widget.value != null)
                Icon(
                  Icons.close,
                  size: widget.size == 'large'
                      ? 20
                      : widget.size == 'small'
                          ? 10
                          : 15,
                  color: Colors.white,
                )
              else
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: widget.size == 'large'
                      ? 20
                      : widget.size == 'small'
                          ? 15
                          : 20,
                  color: Colors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
