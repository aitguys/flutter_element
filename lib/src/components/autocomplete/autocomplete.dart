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
  final TextEditingController? value;
  final String? placeholder;
  final bool clearable;
  final bool disabled;
  final String valueKey;
  final int debounce;
  final ESizeItem size;
  // final String placement;
  final Function(String, Function(List<dynamic>)) fetchSuggestions;
  final bool triggerOnFocus;
  // final bool selectWhenUnmatched;
  final String? name;
  final String? ariaLabel;
  final bool hideLoading;
  // final bool teleported;
  // final String? appendTo;
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

  const EAutocomplete({
    super.key,
    this.value,
    this.placeholder,
    this.clearable = false,
    this.disabled = false,
    this.valueKey = 'value',
    this.debounce = 300,
    // this.placement = 'bottom-start',
    required this.fetchSuggestions,
    this.size = ESizeItem.medium,
    this.triggerOnFocus = true,
    // this.selectWhenUnmatched = false,
    this.name,
    this.ariaLabel,
    this.hideLoading = false,
    // this.teleported = true,
    // this.appendTo,
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
  });

  @override
  State<EAutocomplete> createState() => _EAutocompleteState();
}

class _EAutocompleteState extends State<EAutocomplete> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  List<dynamic> _suggestions = [];
  bool _isLoading = false;
  bool _isFocused = false;
  final int _highlightedIndex = -1;
  OverlayEntry? _overlayEntry;
  // dynamic _selectedItem;
  bool _isSelecting = false;
  final LayerLink _layerLink = LayerLink();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller = widget.value ?? TextEditingController();
    _focusNode.addListener(_handleFocusChange);
  }

  //
  @override
  void dispose() {
    if (widget.value == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    _removeOverlay();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!mounted) return;
    setState(() {
      _isFocused = _focusNode.hasFocus;
      if (_isFocused) {
        if (widget.triggerOnFocus && !_isSelecting) {
          _fetchSuggestions(_controller.text);
        }
      }
    });
  }

  void _handleTextChange(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: widget.debounce), () {
      if (widget.onChange != null) {
        widget.onChange!(value);
      }
      // _selectedItem = null;
      _fetchSuggestions(value);
    });
  }

  void _fetchSuggestions(String query) async {
    if (_isLoading) return;

    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      widget.fetchSuggestions(query, (suggestions) {
        if (!mounted) return;
        setState(() {
          _suggestions = suggestions;
          _isLoading = false;
          if (suggestions.isNotEmpty) {
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
    if (!mounted) return;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _removeOverlay();
              _focusNode.unfocus();
            },
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
                      border: Border.all(color: EBasicColors.borderGray),
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
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                _isSelecting = true;
                                _handleSelect(item);
                                _isSelecting = false;
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: isHighlighted
                                      ? EColorTypes.primary
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
                                  title: Text(
                                    item[widget.valueKey].toString(),
                                    style: TextStyle(
                                      color: isHighlighted
                                          ? EColorTypes.primary
                                          : Colors.black87,
                                    ),
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

    final BuildContext currentContext = context;
    Overlay.of(currentContext).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _handleSelect(dynamic item) {
    setState(() {
      // _selectedItem = item;
      _controller.text = item[widget.valueKey].toString();
    });
    _removeOverlay(); // Ensure overlay is closed upon selection
    if (widget.onSelect != null) {
      widget.onSelect!(item);
    }
    // Optionally trigger onChange if needed
    if (widget.onChange != null) {
      widget.onChange!(_controller.text);
    }
    _isSelecting = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.prepend != null) widget.prepend!,
        Expanded(
          child: CompositedTransformTarget(
            link: _layerLink,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: !widget.disabled,
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: const TextStyle(color: EBasicColors.borderGray),
                prefixIcon: widget.prefix,
                contentPadding:
                    ElememtSize(size: widget.size).getInputPadding(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: EBasicColors.borderGray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: EBasicColors.borderGray),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: EColorTypes.primary),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isLoading && !widget.hideLoading)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                EColorTypes.primary),
                          ),
                        ),
                      ),
                    if (widget.clearable && _controller.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _controller.clear();
                          setState(() {
                            // _selectedItem = null;
                            _suggestions = [];
                          });
                          if (widget.onClear != null) {
                            widget.onClear!();
                          }
                        },
                      ),
                    if (widget.suffix != null) widget.suffix!,
                  ],
                ),
              ),
              onChanged: _handleTextChange,
              onTap: () {
                if (widget.onFocus != null) {
                  widget.onFocus!();
                }
              },
            ),
          ),
        ),
        if (widget.append != null) widget.append!,
      ],
    );
  }
}
