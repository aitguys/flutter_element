import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 2, 0) // Start from top middle
      ..lineTo(0, size.height) // Draw line to bottom left
      ..lineTo(size.width, size.height) // Draw line to bottom right
      ..close(); // Close the path

    // Scale up the triangle by 20%
    final matrix = Matrix4.identity()..scale(1.2);
    final scaledPath = path.transform(matrix.storage);

    canvas.drawPath(scaledPath, Paint()..color = color);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class EAutocomplete extends StatefulWidget {
  final TextEditingController? textController;
  final String? placeholder;
  final bool clearable;
  final bool disabled;
  final String valueKey;
  final int debounce;
  final ESizeItem size;
  final Function(String, Function(List<Map<String, dynamic>>)) fetchSuggestions;
  final bool triggerOnFocus;
  final bool hideLoading;
  final bool highlightFirstItem;
  final bool fitInputWidth;
  final Function(dynamic)? onSelect;
  final Function(String)? onChange;
  final Function()? onFocus;
  final Function()? onBlur;
  final Function()? onClear;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prepend;
  final Widget? append;
  final Widget? loading;
  final EColorType colorType;
  final Color? customColor;
  final Color defaultColor;
  final double? customHeight;
  final double? customFontSize;
  final double? customBorderRadius;
  final bool showPlaceholderOnTop;

  const EAutocomplete({
    super.key,
    this.textController,
    this.placeholder,
    this.clearable = false,
    this.disabled = false,
    this.valueKey = 'value',
    this.debounce = 300,
    required this.fetchSuggestions,
    this.size = ESizeItem.medium,
    this.triggerOnFocus = true,
    this.hideLoading = false,
    this.highlightFirstItem = false,
    this.fitInputWidth = false,
    this.onSelect,
    this.onChange,
    this.onFocus,
    this.onBlur,
    this.onClear,
    this.prefix,
    this.suffix,
    this.prepend,
    this.append,
    this.loading,
    this.colorType = EColorType.primary,
    this.customColor,
    this.defaultColor = EBasicColors.borderGray,
    this.customHeight,
    this.customFontSize,
    this.customBorderRadius,
    this.showPlaceholderOnTop = false,
  });

  @override
  State<EAutocomplete> createState() => _EAutocompleteState();
}

class _EAutocompleteState extends State<EAutocomplete> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _hasValue = false;
  bool _isSelecting = false;
  bool _isClearing = false;
  List<Map<String, dynamic>> _suggestions = [];
  bool _isLoading = false;
  final int _highlightedIndex = -1;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  Timer? _debounceTimer;
  String? _selectedValue;
  // List<Map<String, dynamic>> _allSuggestions = [];
  Timer? _blurTimer;
  // 事件触发控制器

  @override
  void initState() {
    super.initState();
    _controller = widget.textController ?? TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _hasValue = _controller.text.isNotEmpty;
  }

  @override
  void dispose() {
    if (widget.textController == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    _removeOverlay();
    _debounceTimer?.cancel();
    _blurTimer?.cancel();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    if (_focusNode.hasFocus) {
      widget.onFocus?.call();

      // 聚焦时根据 triggerOnFocus 设置触发搜索，但不触发 onChange
      if (!widget.disabled && _controller.text.isNotEmpty) {
        _fetchSuggestions(_controller.text);
      } else if (!widget.disabled && widget.triggerOnFocus) {
        _fetchSuggestions('');
      }
    } else {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _removeOverlay();
          widget.onBlur?.call();
        }
      });
    }
  }

  void _handleTextChange() {
    // Skip text change handling if we're selecting or clearing
    if (_isSelecting || _isClearing) return;

    if (_hasValue != _controller.text.isNotEmpty) {
      setState(() {
        _hasValue = _controller.text.isNotEmpty;
      });
    }

    _selectedValue = null;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: widget.debounce), () {
      if (!_isSelecting && !_isClearing && !widget.disabled) {
        widget.onChange?.call(_controller.text);
        _fetchSuggestions(_controller.text);
      }
    });
  }

  void _handleClear() {
    setState(() {
      _isClearing = true;
      _controller.clear();
      _hasValue = false;
      _suggestions = [];
      _selectedValue = null;
    });
    widget.onClear?.call();

    // Reset clearing flag after a short delay
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _isClearing = false;
        });
      }
    });
  }

  void _handleSelect(dynamic item) {
    final selectedText = item[widget.valueKey]?.toString() ?? '';

    _removeOverlay();

    setState(() {
      _selectedValue = selectedText;
      if (_selectedValue != null && _selectedValue!.isNotEmpty) {
        _hasValue = true;
      }
      _isSelecting = true;
    });

    _controller.text = selectedText;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: selectedText.length),
    );

    widget.onSelect?.call(item);

    // Reset selecting flag after a short delay
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _isSelecting = false;
        });
      }
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _focusNode.unfocus();
      }
    });
  }

  void _fetchSuggestions(String query) async {
    if (_isLoading || _isSelecting || widget.disabled) return;

    setState(() {
      _isLoading = true;
    });

    try {
      widget.fetchSuggestions(query, (suggestions) {
        if (!mounted || _isSelecting) return;
        setState(() {
          // _allSuggestions = suggestions;
          _suggestions = suggestions.where((item) {
            final value = item[widget.valueKey]?.toString().toLowerCase() ?? '';
            return value.contains(query.toLowerCase());
          }).toList();
          _isLoading = false;
          if (_suggestions.isNotEmpty && !widget.disabled) {
            _showOverlay();
          } else {
            _removeOverlay();
          }
        });
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _removeOverlay();
      });
    }
  }

  void _showOverlay() {
    _removeOverlay();
    if (!mounted || widget.disabled) return;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomPaint(
                    size: const Size(10, 5),
                    painter: TrianglePainter(color: EBasicColors.borderGray),
                  ),
                ),
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(color: widget.defaultColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    constraints: BoxConstraints(
                      maxHeight: 200,
                      minWidth: size.width,
                    ),
                    width: size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _suggestions.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          final isHighlighted = index == _highlightedIndex;
                          return InkWell(
                            onTap: () {
                              _handleSelect(item);
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: isHighlighted
                                    ? getColorByType(
                                            type: widget.colorType,
                                            customColor: widget.customColor)
                                        .withValues(alpha: 0.1)
                                    : null,
                                border: const Border(
                                  bottom: BorderSide(
                                    color: EBasicColors.borderGray,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                dense: true,
                                title: Text(
                                  item[widget.valueKey]?.toString() ?? '',
                                  style: TextStyle(
                                    color: isHighlighted
                                        ? getColorByType(
                                            type: widget.colorType,
                                            customColor: widget.customColor)
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          children: [
            Expanded(
              child: CompositedTransformTarget(
                link: _layerLink,
                child: SizedBox(
                  height: ElememtSize(size: widget.size)
                      .getInputHeight(customHeight: widget.customHeight),
                  child: MouseRegion(
                    child: GestureDetector(
                      onTap: () {
                        if (!widget.disabled && _controller.text.isNotEmpty) {
                          _fetchSuggestions(_controller.text);
                        } else if (!widget.disabled && widget.triggerOnFocus) {
                          _fetchSuggestions('');
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: widget.prepend != null ? 0 : 8,
                            right: widget.append != null ? 0 : 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.disabled
                                ? widget.defaultColor
                                : _isFocused
                                    ? getColorByType(
                                        type: widget.colorType,
                                        customColor: widget.customColor)
                                    : widget.defaultColor,
                          ),
                          borderRadius: BorderRadius.circular(
                              ElememtSize(size: widget.size)
                                  .getInputBorderRadius(
                                      customBorderRadius:
                                          widget.customBorderRadius)),
                          color:
                              widget.disabled ? Colors.grey[100] : Colors.white,
                        ),
                        child: Row(
                          children: [
                            if (widget.prepend != null)
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                color: Colors.grey[100],
                                height: double.infinity,
                                child: widget.prepend!,
                              ),
                            if (widget.prefix != null)
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: widget.prefix,
                              ),
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                focusNode: _focusNode,
                                enabled: !widget.disabled,
                                onChanged: (value) {
                                  _handleTextChange();
                                },
                                style: TextStyle(
                                    fontSize: ElememtSize(size: widget.size)
                                        .getInputFontSize(
                                            customFontSize:
                                                widget.customFontSize)),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  isCollapsed: true,
                                  hintText:
                                      widget.showPlaceholderOnTop && _isFocused
                                          ? null
                                          : widget.placeholder,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (_isLoading && !widget.hideLoading)
                                  const Padding(
                                    padding: EdgeInsets.all(0),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                EColorTypes.primary),
                                      ),
                                    ),
                                  ),
                                if (widget.clearable &&
                                    _hasValue &&
                                    !widget.disabled)
                                  GestureDetector(
                                    onTap: _handleClear,
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.close,
                                          size: 16,
                                          color: getColorByType(
                                              type: widget.colorType,
                                              customColor: widget.customColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (widget.suffix != null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: widget.suffix,
                                  ),
                              ],
                            ),
                            if (widget.append != null)
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                color: Colors.grey[100],
                                height: double.infinity,
                                child: widget.append!,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (widget.showPlaceholderOnTop && (_isFocused || _hasValue))
          Positioned(
            left: 8,
            top: -8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              color: Colors.white,
              child: Text(
                widget.placeholder ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: _isFocused
                      ? getColorByType(
                          type: widget.colorType,
                          customColor: widget.customColor)
                      : Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
      ],
    );
  }
}
