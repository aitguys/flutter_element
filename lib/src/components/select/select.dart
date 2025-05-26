import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';

enum ESelectSize { small, medium, large }

class SelectOption {
  final String value;
  final String label;
  final bool disabled;
  final dynamic extra;

  const SelectOption({
    required this.value,
    required this.label,
    this.disabled = false,
    this.extra,
  });
}

class ESelect extends StatefulWidget {
  final dynamic value; // 可以是 String 或 List<String>
  final List<SelectOption> options;
  final bool disabled;
  final bool clearable;
  final bool multiple;
  final ESelectSize size;
  final String? placeholder;
  final String? emptyText;
  final Widget? header;
  final ValueChanged<dynamic>? onChanged;
  final VoidCallback? onClear;

  const ESelect({
    super.key,
    this.value,
    required this.options,
    this.disabled = false,
    this.clearable = false,
    this.multiple = false,
    this.size = ESelectSize.medium,
    this.placeholder,
    this.emptyText,
    this.header,
    this.onChanged,
    this.onClear,
  });

  @override
  State<ESelect> createState() => _ESelectState();
}

class _ESelectState extends State<ESelect> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final FocusNode _focusNode = FocusNode();
  bool _isHovered = false;
  // ignore: prefer_final_fields
  bool _isFocused = false;
  List<String> _selectedValues = [];
  double get _height {
    switch (widget.size) {
      case ESelectSize.small:
        return 24;
      case ESelectSize.large:
        return 40;
      case ESelectSize.medium:
        return 32;
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case ESelectSize.small:
        return 12;
      case ESelectSize.large:
        return 16;
      case ESelectSize.medium:
        return 14;
    }
  }

  List<SelectOption> get _selectedOptions {
    if (widget.value == null) return [];
    if (widget.multiple) {
      return widget.options
          .where((option) => _selectedValues.contains(option.value))
          .toList();
    } else {
      return widget.options
          .where((option) => option.value == widget.value)
          .toList();
    }
  }

  String get _displayText {
    if (_selectedOptions.isEmpty) return widget.placeholder ?? '';
    if (widget.multiple) {
      return _selectedOptions.map((e) => e.label).join(', ');
    } else {
      return _selectedOptions.first.label;
    }
  }

  void _handleOptionSelected(SelectOption option) {
    if (widget.multiple) {
      setState(() {
        if (_selectedValues.contains(option.value)) {
          _selectedValues.remove(option.value);
        } else {
          _selectedValues.add(option.value);
        }
        widget.onChanged?.call(_selectedValues);
      });
    } else {
      setState(() {
        widget.onChanged?.call(option.value);
        _hideOverlay();
      });
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _hideOverlay();
              },
            ),
          ),
          Positioned(
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 38),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: size.width,
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.header != null)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: EBasicColors.borderGray,
                                width: 1,
                              ),
                            ),
                          ),
                          child: widget.header,
                        ),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.options.length,
                          itemBuilder: (context, index) {
                            final option = widget.options[index];
                            final isSelected = widget.multiple
                                ? _selectedValues.contains(option.value)
                                : option.value == widget.value;
                            final isDisabled =
                                option.disabled || widget.disabled;

                            return InkWell(
                              onTap: isDisabled
                                  ? null
                                  : () => _handleOptionSelected(option),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                color: isSelected
                                    ? EColorTypes.primary.withValues(alpha: 0.1)
                                    : null,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        option.label,
                                        style: TextStyle(
                                          fontSize: _fontSize,
                                          color: isDisabled
                                              ? EBasicColors.textGray
                                              : isSelected
                                                  ? EColorTypes.primary
                                                  : EBasicColors.textGray,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check,
                                        size: _fontSize,
                                        color: EColorTypes.primary,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlay();
      }
    });
    if (widget.multiple && widget.value != null) {
      _selectedValues = List<String>.from(widget.value);
    }
  }

  @override
  void didUpdateWidget(ESelect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.multiple && widget.value != null) {
      _selectedValues = List<String>.from(widget.value);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.disabled
              ? null
              : () {
                  if (_overlayEntry == null) {
                    _showOverlay();
                  } else {
                    _hideOverlay();
                  }
                },
          child: Container(
            height: _height,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.disabled
                    ? EBasicColors.borderGray
                    : _isFocused
                        ? EColorTypes.primary
                        : _isHovered
                            ? EColorTypes.primary
                            : EBasicColors.borderGray,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _displayText,
                    style: TextStyle(
                      fontSize: _fontSize,
                      color: widget.disabled
                          ? EBasicColors.textGray
                          : _selectedOptions.isNotEmpty
                              ? EBasicColors.textGray
                              : EBasicColors.textGray,
                    ),
                  ),
                ),
                if (widget.clearable && _selectedOptions.isNotEmpty)
                  GestureDetector(
                    onTap: widget.disabled ? null : widget.onClear,
                    child: Icon(
                      Icons.close,
                      size: _fontSize,
                      color: EBasicColors.textGray,
                    ),
                  ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_drop_down,
                  size: _fontSize,
                  color: EBasicColors.textGray,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
