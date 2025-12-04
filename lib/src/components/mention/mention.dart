import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';
import 'package:flutter/services.dart';

/// Represents an option in the mention component.
class MentionOption {
  /// The value of the mention option.
  final String value;

  /// The display label for the mention option.
  /// If not provided, the value will be used as the label.
  final String? label;

  /// Whether this mention option is disabled.
  /// Disabled options cannot be selected.
  final bool disabled;

  const MentionOption({
    required this.value,
    this.label,
    this.disabled = false,
  });
}

/// A mention component that allows users to mention other users or entities
/// by typing a trigger prefix (e.g., @) followed by text.
/// It follows Element Plus design guidelines and provides features like:
/// - Customizable trigger prefixes
/// - Filterable options
/// - Loading state
/// - Custom option filtering
/// - Dropdown placement control
/// - Search callback
/// - Selection callback
///
/// Example:
/// ```dart
/// EMention(
///   value: 'Hello @John',
///   options: [
///     MentionOption(value: 'John', label: 'John Doe'),
///     MentionOption(value: 'Jane', label: 'Jane Smith'),
///   ],
///   triggerPrefixes: ['@'],
///   onSearch: (query) {
///     print('Searching for: $query');
///   },
///   onSelect: (option) {
///     print('Selected: ${option.label}');
///   },
///   onChanged: (value) {
///     print('Input value: $value');
///   },
/// )
/// ```
class EMention extends StatefulWidget {
  /// The current value of the input.
  final String? value;

  /// Callback function when the input value changes.
  final ValueChanged<String>? onChanged;

  /// The list of mention options to display in the dropdown.
  final List<MentionOption> options;

  /// The list of characters that trigger the mention dropdown.
  /// Default is ['@'].
  final List<String>? triggerPrefixes;

  /// The character used to split the input text.
  /// Default is space (' ').
  final String? split;

  /// Custom function to filter mention options.
  /// If not provided, a default case-insensitive contains search is used.
  final bool Function(String, String)? filterOption;

  /// The placement of the dropdown relative to the input.
  /// Default is 'bottom'.
  final String placement;

  /// Whether to show an arrow pointing to the input.
  final bool showArrow;

  /// The offset of the dropdown from the input.
  final double offset;

  /// Whether to match the whole word when filtering options.
  final bool whole;

  /// Custom function to check if a word is whole.
  final bool Function(String, String)? checkIsWhole;

  /// Whether to show a loading state in the dropdown.
  final bool loading;

  /// Placeholder text when the input is empty.
  final String? placeholder;

  /// Whether the mention component is disabled.
  final bool disabled;

  /// Whether the input is read-only.
  final bool readOnly;

  /// Whether the input should be focused on mount.
  final bool autofocus;

  /// Widget to display before the input.
  final Widget? prefixIcon;

  /// Widget to display after the input.
  final Widget? suffixIcon;

  /// Callback function when searching for mention options.
  /// Called with the current search query.
  final Function(String)? onSearch;

  /// Callback function when a mention option is selected.
  /// Called with the selected option.
  final Function(MentionOption)? onSelect;

  const EMention({
    super.key,
    this.value,
    this.onChanged,
    this.options = const [],
    this.triggerPrefixes = const ['@'],
    this.split = ' ',
    this.filterOption,
    this.placement = 'bottom',
    this.showArrow = false,
    this.offset = 0,
    this.whole = false,
    this.checkIsWhole,
    this.loading = false,
    this.placeholder,
    this.disabled = false,
    this.readOnly = false,
    this.autofocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSearch,
    this.onSelect,
  });

  @override
  State<EMention> createState() => _EMentionState();
}

class _EMentionState extends State<EMention> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  List<MentionOption> _filteredOptions = [];
  int _selectedIndex = 0;
  String _currentPrefix = '';
  int _prefixStart = -1;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(EMention oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.text = widget.value ?? '';
    }
    if (widget.options != oldWidget.options) {
      _filterOptions();
    }
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _filterOptions() {
    if (_currentPrefix.isEmpty) {
      _filteredOptions = widget.options;
      return;
    }

    if (widget.filterOption != null) {
      _filteredOptions = widget.options
          .where((option) => widget.filterOption!(option.value, _currentPrefix))
          .toList();
    } else {
      _filteredOptions = widget.options
          .where((option) =>
              option.value.toLowerCase().contains(_currentPrefix.toLowerCase()))
          .toList();
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 320,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 40),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(4),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredOptions.length,
                itemBuilder: (context, index) {
                  final option = _filteredOptions[index];
                  return ListTile(
                    title: Text(option.label ?? option.value),
                    selected: index == _selectedIndex,
                    enabled: !option.disabled,
                    onTap: () => _handleOptionSelected(option),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _handleTextChanged(String text) {
    widget.onChanged?.call(text);

    // 如果文本为空，隐藏弹窗
    if (text.isEmpty) {
      _hideOverlay();
      return;
    }

    // 保存当前光标位置
    int currentCursorPosition = _controller.selection.baseOffset;

    // 检查是否输入了触发前缀
    for (var prefix in widget.triggerPrefixes ?? ['@']) {
      int index = text.lastIndexOf(prefix);
      if (index != -1) {
        String afterPrefix = text.substring(index + 1);
        if (afterPrefix.contains(widget.split ?? ' ')) {
          _hideOverlay();
          continue;
        }

        setState(() {
          _currentPrefix = afterPrefix;
          _prefixStart = index;
          _selectedIndex = 0;
        });
        _filterOptions();
        widget.onSearch?.call(_currentPrefix);

        if (_filteredOptions.isNotEmpty) {
          _showOverlay();
        } else {
          _hideOverlay();
        }
        return;
      }
    }

    _hideOverlay();

    // 恢复光标位置
    if (currentCursorPosition != -1) {
      _controller.selection =
          TextSelection.collapsed(offset: currentCursorPosition);
    }
  }

  void _handleOptionSelected(MentionOption option) {
    if (option.disabled) return;

    String text = _controller.text;
    String newText =
        '${text.substring(0, _prefixStart + 1)}${option.value} ${text.substring(_prefixStart + 1 + _currentPrefix.length)}';

    _controller.text = newText;
    // 只设置光标位置，不选中文本
    // _controller.selection = TextSelection.collapsed(
    //   offset: _prefixStart + 1 + option.value.length + 1, // +1 因为添加了空格
    // );

    _hideOverlay();
    widget.onChanged?.call(newText);
    widget.onSelect?.call(option);

    Future.delayed(const Duration(milliseconds: 10), () {
      _controller.selection =
          TextSelection.collapsed(offset: _controller.text.length);
    });
    // 保持焦点

    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) {
          if (event.logicalKey == LogicalKeyboardKey.backspace &&
              widget.whole) {
            // 获取当前光标位置
            final cursorPosition = _controller.selection.baseOffset;
            final text = _controller.text;

            // 查找最近的 @ 符号位置
            int atIndex = text.lastIndexOf('@', cursorPosition - 1);
            if (atIndex != -1) {
              // 查找下一个空格位置
              int spaceIndex = text.indexOf(' ', atIndex);
              if (spaceIndex == -1) {
                spaceIndex = text.length;
              }

              // 如果光标位置在@和空格之间，才删除整个@项
              if (cursorPosition > atIndex && cursorPosition <= spaceIndex) {
                String newText =
                    text.substring(0, atIndex) + text.substring(spaceIndex);
                _controller.text = newText;
                _controller.selection =
                    TextSelection.collapsed(offset: atIndex);

                // 如果删除后文本为空，确保弹窗消失
                if (newText.isEmpty) {
                  _hideOverlay();
                } else {
                  // 重置状态，避免显示错误的弹窗
                  setState(() {
                    _currentPrefix = '';
                    _prefixStart = -1;
                  });
                  _hideOverlay();
                }
              }
            }
          }
        },
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          enabled: !widget.disabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: const TextStyle(
              color: EBasicColors.defaultTextColor,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color:
                    _isFocused ? EColorTypes.primary : EBasicColors.borderGray,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: EBasicColors.borderGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: EColorTypes.primary),
            ),
          ),
          onChanged: _handleTextChanged,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hideOverlay();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
