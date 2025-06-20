import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';
import '../input/input.dart';

/// Represents an option in the select component.
class SelectOption {
  /// The value associated with this option.
  final String value;

  /// The text label to display for this option.
  final String label;

  /// Whether this option is disabled.
  /// Disabled options cannot be selected.
  final bool disabled;

  /// Additional data associated with this option.
  final dynamic extra;

  const SelectOption({
    required this.value,
    required this.label,
    this.disabled = false,
    this.extra,
  });
}

class ESelect extends StatefulWidget {
  final dynamic value;

  final List<SelectOption> options;

  /// Whether the select component is disabled.
  /// When disabled, the component cannot be interacted with.
  final bool disabled;

  /// Whether the selected value can be cleared.
  /// When true, a clear button appears when a value is selected.
  final bool clearable;

  /// Whether multiple options can be selected.
  /// When true, the component allows selecting multiple values.
  final bool multiple;

  /// The size of the select component.
  /// Affects the height and font size of the component.
  final ESizeItem size;

  /// The placeholder text to display when no value is selected.
  final String? placeholder;

  /// A custom widget to display at the top of the dropdown.
  final Widget? header;

  /// The color type of the select.
  final EColorType colorType;

  /// A custom widget to display at the end of the select.
  final Widget? suffix;
  final Widget? prefix;
  final Widget? prepend;
  final Widget? append;

  /// A custom color to use for the select.
  final Color? customColor;

  /// The default color for the select's border.
  final Color defaultColor;

  /// A custom height for the select.
  final double? customHeight;

  /// A custom font size for the select text.
  final double? customFontSize;

  /// A custom border radius for the select.
  final double? customBorderRadius;

  /// Whether to show the placeholder text above the select when focused.
  final bool showPlaceholderOnTop;

  /// Callback function when the selected value(s) change.
  /// For single select, the callback receives a `String`.
  /// For multiple select, the callback receives a `List<String>`.
  final ValueChanged<dynamic>? onChanged;

  /// Callback function when the clear button is clicked.
  final VoidCallback? onClear;

  const ESelect({
    super.key,
    this.value,
    required this.options,
    this.disabled = false,
    this.clearable = false,
    this.multiple = false,
    this.size = ESizeItem.medium,
    this.placeholder,
    this.header,
    this.colorType = EColorType.primary,
    this.customColor,
    this.defaultColor = EBasicColors.borderGray,
    this.customHeight,
    this.customFontSize,
    this.customBorderRadius,
    this.showPlaceholderOnTop = false,
    this.onChanged,
    this.onClear,
    this.suffix,
    this.prefix,
    this.prepend,
    this.append,
  });

  @override
  State<ESelect> createState() => _ESelectState();
}

class _ESelectState extends State<ESelect> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  late FocusNode _focusNode;
  late TextEditingController _controller;
  List<String> _selectedValues = [];
  bool _isDisposed = false;

  String get _displayText {
    if (widget.multiple) {
      if (_selectedValues.isEmpty) return '';
      return _selectedValues
          .map((value) => widget.options
              .firstWhere((option) => option.value == value,
                  orElse: () => SelectOption(label: value, value: value))
              .label)
          .join(', ');
    } else {
      if (widget.value == null) return '';
      return widget.options
          .firstWhere((option) => option.value == widget.value,
              orElse: () => SelectOption(label: widget.value!, value: widget.value!))
          .label;
    }
  }

  void _handleOptionSelected(SelectOption option) {
    if (!_isDisposed) {
      if (widget.multiple) {
        setState(() {
          if (_selectedValues.contains(option.value)) {
            _selectedValues.remove(option.value);
          } else {
            _selectedValues.add(option.value);
          }
          widget.onChanged?.call(_selectedValues);
          _updateOverlay();
        });
        _controller.text = _displayText;
      } else {
        setState(() {
          widget.onChanged?.call(option.value);
          _hideOverlay();
        });
        _controller.text = _displayText;
      }
    }
  }

  void _updateOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
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
              offset: Offset(
                  0,
                  ElememtSize(size: widget.size)
                      .getInputHeight(customHeight: widget.customHeight)),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(
                    ElememtSize(size: widget.size).getInputBorderRadius(
                        customBorderRadius: widget.customBorderRadius)),
                child: Container(
                  width: size.width,
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.header != null) widget.header!,
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
                                    ? getColorByType(
                                            type: widget.colorType,
                                            customColor: widget.customColor)
                                        .withValues(alpha: 0.1)
                                    : null,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        option.label,
                                        style: TextStyle(
                                          fontSize:
                                              ElememtSize(size: widget.size)
                                                  .getInputFontSize(
                                                      customFontSize: widget
                                                          .customFontSize),
                                          color: isDisabled
                                              ? const Color.fromARGB(
                                                  255, 146, 148, 155)
                                              : isSelected
                                                  ? getColorByType(
                                                      type: widget.colorType,
                                                      customColor:
                                                          widget.customColor)
                                                  : EBasicColors.textGray,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check,
                                        size: ElememtSize(size: widget.size)
                                            .getInputFontSize(
                                                customFontSize:
                                                    widget.customFontSize),
                                        color: getColorByType(
                                            type: widget.colorType,
                                            customColor: widget.customColor),
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
    _focusNode = FocusNode();
    _controller = TextEditingController(text: _displayText);
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
    if (!_isDisposed) {
      _controller.text = _displayText;
    }
  }

  void _handleClear() {
    if (!_isDisposed) {
      setState(() {
        _selectedValues = [];
        if (widget.multiple) {
          widget.onChanged?.call(_selectedValues);
        } else {
          widget.onChanged?.call(null);
        }
        _hideOverlay();
      });
      _controller.text = _displayText;
      widget.onClear?.call();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _focusNode.dispose();
    _controller.dispose();
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: EInput(
        textController: _controller,
        focusNode: _focusNode,
        disabled: widget.disabled,
        readOnly: true,
        clearable: widget.clearable,
        placeholder: widget.placeholder,
        colorType: widget.colorType,
        customColor: widget.customColor,
        defaultColor: widget.defaultColor,
        size: widget.size,
        customHeight: widget.customHeight,
        customFontSize: widget.customFontSize,
        customBorderRadius: widget.customBorderRadius,
        showPlaceholderOnTop: widget.showPlaceholderOnTop,
        onClear: _handleClear,
        suffix: widget.suffix ??
            Icon(
              Icons.arrow_drop_down,
              size: ElememtSize(size: widget.size)
                  .getInputFontSize(customFontSize: widget.customFontSize),
              color: EBasicColors.textGray,
            ),
        prefix: widget.prefix,
        prepend: widget.prepend,
        append: widget.append,
      ),
    );
  }
}
