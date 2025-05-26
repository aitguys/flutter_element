import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';
import 'package:flutter/services.dart';

class MentionOption {
  final String value;
  final String? label;
  final bool disabled;

  const MentionOption({
    required this.value,
    this.label,
    this.disabled = false,
  });
}

class EMention extends StatefulWidget {
  final String? value;
  final ValueChanged<String>? onChanged;
  final List<MentionOption> options;
  final List<String>? triggerPrefixes;
  final String? split;
  final bool Function(String, String)? filterOption;
  final String placement;
  final bool showArrow;
  final double offset;
  final bool whole;
  final bool Function(String, String)? checkIsWhole;
  final bool loading;
  final String? placeholder;
  final bool disabled;
  final bool readOnly;
  final bool autofocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onSearch;
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
    print('_handleTextChanged: $text');
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
    print('_handleOptionSelected: $option');
    if (option.disabled) return;

    String text = _controller.text;
    String newText = '${text.substring(0, _prefixStart + 1)}${option.value} ${text.substring(_prefixStart + 1 + _currentPrefix.length)}';

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
