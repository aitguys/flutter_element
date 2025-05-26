import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';
import 'package:flutter/services.dart';

enum EInputTagSize { small, medium, large }

enum EInputTagTrigger { enter, space }

class EInputTag extends StatefulWidget {
  final List<String>? value;
  final ValueChanged<List<String>?>? onChanged;
  final int? max;
  final String? tagType;
  final String? tagEffect;
  final EInputTagTrigger trigger;
  final bool draggable;
  final String? delimiter;
  final EInputTagSize size;
  final bool saveOnBlur;
  final bool clearable;
  final bool disabled;
  final bool validateEvent;
  final bool readOnly;
  final bool autofocus;
  final String? id;
  final dynamic tabindex;
  final dynamic maxlength;
  final dynamic minlength;
  final String? placeholder;
  final String? autocomplete;
  final String? ariaLabel;
  final Widget? prefix;
  final Widget? suffix;
  final Widget Function(BuildContext, String)? tagBuilder;
  final VoidCallback? onFocus;
  final VoidCallback? onBlur;
  final Function(String)? onAddTag;
  final Function(String)? onRemoveTag;
  final VoidCallback? onClear;

  const EInputTag({
    super.key,
    this.value,
    this.onChanged,
    this.max,
    this.tagType,
    this.tagEffect,
    this.trigger = EInputTagTrigger.enter,
    this.draggable = false,
    this.delimiter,
    this.size = EInputTagSize.medium,
    this.saveOnBlur = true,
    this.clearable = false,
    this.disabled = false,
    this.validateEvent = true,
    this.readOnly = false,
    this.autofocus = false,
    this.id,
    this.tabindex,
    this.maxlength,
    this.minlength,
    this.placeholder,
    this.autocomplete,
    this.ariaLabel,
    this.prefix,
    this.suffix,
    this.tagBuilder,
    this.onFocus,
    this.onBlur,
    this.onAddTag,
    this.onRemoveTag,
    this.onClear,
  });

  @override
  State<EInputTag> createState() => _EInputTagState();
}

class _EInputTagState extends State<EInputTag> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  // ignore: unused_field
  bool _isHovered = false;
  bool _isFocused = false;
  String? _hoveredTag;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(EInputTag oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.clear();
    }
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    if (_focusNode.hasFocus) {
      widget.onFocus?.call();
    } else {
      widget.onBlur?.call();
      if (widget.saveOnBlur && _controller.text.isNotEmpty) {
        _addTag(_controller.text);
      }
    }
  }

  void _handleClear() {
    setState(() {
      _controller.clear();
    });
    widget.onClear?.call();
  }

  void _addTag(String tag) {
    if (tag.isEmpty) return;
    if (widget.max != null && (widget.value?.length ?? 0) >= widget.max!) {
      return;
    }

    // 检查标签是否已存在（不区分大小写）

    List<String> newValue = List<String>.from(widget.value ?? []);
    newValue.add(tag);
    widget.onChanged?.call(newValue);
    widget.onAddTag?.call(tag);
    _controller.clear();
  }

  void _removeTag(String tag) {
    List<String> newValue = List<String>.from(widget.value ?? []);
    newValue.remove(tag);
    widget.onChanged?.call(newValue);
    widget.onRemoveTag?.call(tag);
  }

  double get _height {
    switch (widget.size) {
      case EInputTagSize.small:
        return 32;
      case EInputTagSize.large:
        return 48;
      case EInputTagSize.medium:
        // default:
        return 40;
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case EInputTagSize.small:
        return 14;
      case EInputTagSize.large:
        return 18;
      case EInputTagSize.medium:
        // default:
        return 16;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasValue = _controller.text.isNotEmpty;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: _height,
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() {
          _isHovered = true;
        }),
        onExit: (_) => setState(() {
          _isHovered = false;
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.disabled
                  ? EBasicColors.borderGray
                  : _isFocused
                      ? EColorTypes.primary
                      : EBasicColors.borderGray,
            ),
            borderRadius: BorderRadius.circular(6),
            color: widget.disabled ? Colors.grey[100] : Colors.white,
          ),
          child: Row(
            children: [
              if (widget.prefix != null)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: widget.prefix,
                ),
              Expanded(
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    ...?widget.value?.map((tag) => _buildTag(tag)),
                    KeyboardListener(
                      focusNode: FocusNode(),
                      onKeyEvent: (KeyEvent event) {
                        if (event is KeyDownEvent &&
                            event.logicalKey == LogicalKeyboardKey.backspace &&
                            _controller.text.isEmpty &&
                            widget.value?.isNotEmpty == true) {
                          _removeTag(widget.value!.last);
                        } else if (widget.trigger == EInputTagTrigger.space &&
                            event is KeyDownEvent &&
                            event.logicalKey == LogicalKeyboardKey.space) {
                          _addTag(_controller.text);
                        } else if (widget.trigger == EInputTagTrigger.enter &&
                            event is KeyDownEvent &&
                            event.logicalKey == LogicalKeyboardKey.enter) {
                          _addTag(_controller.text);
                        }
                      },
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        enabled: !widget.disabled,
                        readOnly: widget.readOnly,
                        style: TextStyle(fontSize: _fontSize),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          isCollapsed: true,
                          hintText: widget.placeholder,
                        ),
                        onChanged: (value) {
                          if (widget.delimiter != null &&
                              value.contains(widget.delimiter!)) {
                            final tags = value.split(widget.delimiter!);
                            for (var tag in tags) {
                              if (tag.isNotEmpty) _addTag(tag.trim());
                            }
                            _controller.clear();
                          } else if (widget.trigger == EInputTagTrigger.space &&
                              value.endsWith(' ')) {
                            final tag = value.trim();
                            if (tag.isNotEmpty) {
                              _addTag(tag);
                              _controller.clear();
                            }
                          }
                        },
                        onSubmitted: (value) {
                          _focusNode.requestFocus(); // 保持焦点
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.clearable &&
                  hasValue &&
                  !widget.disabled &&
                  !widget.readOnly)
                IconButton(
                  onPressed: _handleClear,
                  icon: const Icon(Icons.close),
                ),
              if (widget.suffix != null)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: widget.suffix,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    if (widget.tagBuilder != null) {
      return widget.tagBuilder!(context, tag);
    }
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredTag = tag),
      onExit: (_) => setState(() => _hoveredTag = null),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: widget.tagEffect == 'dark'
              ? EColorTypes.primary
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tag,
              style: TextStyle(
                color: widget.tagEffect == 'dark' ? Colors.white : Colors.black,
                fontSize: _fontSize - 2,
              ),
            ),
            if (!widget.disabled && !widget.readOnly)
              GestureDetector(
                onTap: () => _removeTag(tag),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(
                    _hoveredTag == tag ? Icons.cancel : Icons.close,
                    size: 14,
                    color: widget.tagEffect == 'dark'
                        ? Colors.white
                        : Colors.grey[600],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
