import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';
import 'package:flutter/services.dart';

/// Default tag builder that creates a tag widget with standard styling
Widget defaultTagBuilder(
  BuildContext context,
  String tag,
  EColorType colorType,
  Color? customColor,
  String? tagEffect,
  ESizeItem size,
  double? customFontSize,
  bool disabled,
  bool readOnly,
  String? hoveredTag,
  Function(String) onRemoveTag,
) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (_) => hoveredTag = tag,
    onExit: (_) => hoveredTag = null,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tagEffect == 'dark'
            ? getColorByType(type: colorType, customColor: customColor)
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: TextStyle(
              color: tagEffect == 'dark' ? Colors.white : Colors.black,
              fontSize: ElememtSize(size: size)
                      .getInputFontSize(customFontSize: customFontSize) -
                  2,
            ),
          ),
          if (!disabled && !readOnly)
            GestureDetector(
              onTap: () => onRemoveTag(tag),
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  hoveredTag == tag ? Icons.cancel : Icons.close,
                  size: 14,
                  color: tagEffect == 'dark' ? Colors.white : Colors.grey[600],
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

/// Defines the available sizes for the input tag component.

/// Defines the trigger events for adding a new tag.
enum EInputTagTrigger {
  /// Add tag when Enter key is pressed
  enter,

  /// Add tag when Space key is pressed
  space,
}

/// An input component that allows users to enter and manage multiple tags.
/// It follows Element Plus design guidelines and provides features like:
/// - Multiple tag input and display
/// - Customizable tag appearance
/// - Tag validation
/// - Maximum tag limit
/// - Drag and drop reordering
/// - Clearable input
/// - Disabled state
/// - Custom tag builder
/// - Prefix and suffix icons
///
/// Example:
/// ```dart
/// EInputTag(
///   value: ['tag1', 'tag2'],
///   placeholder: 'Enter tags',
///   trigger: EInputTagTrigger.enter,
///   max: 5,
///   onChanged: (tags) {
///     print('Tags: $tags');
///   },
///   onAddTag: (tag) {
///     print('Added tag: $tag');
///   },
///   onRemoveTag: (tag) {
///     print('Removed tag: $tag');
///   },
/// )
/// ```
class EInputTag extends StatefulWidget {
  /// The list of current tags.
  final List<String>? value;

  /// Callback function when the tags list changes.
  final ValueChanged<List<String>?>? onChanged;

  /// Maximum number of tags allowed.
  final int? max;

  /// The type of tag to display (e.g., 'success', 'warning', 'danger').

  /// The effect style of the tag (e.g., 'dark', 'light', 'plain').
  final String? tagEffect;

  /// The trigger event for adding a new tag.
  /// Default is [EInputTagTrigger.enter].
  final EInputTagTrigger trigger;

  /// Whether tags can be reordered by drag and drop.
  final bool draggable;

  /// The delimiter character used to split input into multiple tags.
  final String? delimiter;

  /// The size of the input tag component.
  /// Affects the height and font size.
  final ESizeItem size;

  /// Whether to save the current input as a tag when the input loses focus.
  final bool saveOnBlur;

  /// Whether to show a clear button when the input has content.
  final bool clearable;

  /// Whether the input tag component is disabled.
  final bool disabled;

  /// Whether the input is read-only.
  final bool readOnly;

  /// Placeholder text when the input is empty.
  final String? placeholder;

  /// Widget to display before the input.
  final Widget? prefix;

  /// Widget to display after the input.
  final Widget? suffix;

  /// Custom builder function for rendering tags.
  final Widget Function(BuildContext, String)? tagBuilder;

  /// Callback function when the input gains focus.
  final VoidCallback? onFocus;

  /// Callback function when the input loses focus.
  final VoidCallback? onBlur;

  /// Callback function when a new tag is added.
  final Function(String, List<String>)? onAddTag;

  /// Callback function when a tag is removed.
  final Function(String, List<String>)? onRemoveTag;

  /// Callback function when the input is cleared.
  final VoidCallback? onClear;

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

  const EInputTag({
    super.key,
    this.value,
    this.max,
    this.tagEffect,
    this.trigger = EInputTagTrigger.enter,
    this.draggable = false,
    this.delimiter,
    this.size = ESizeItem.medium,
    this.saveOnBlur = true,
    this.clearable = true,
    this.disabled = false,
    this.readOnly = false,
    this.placeholder,
    this.prefix,
    this.suffix,
    this.tagBuilder,
    this.onChanged,
    this.onFocus,
    this.onBlur,
    this.onAddTag,
    this.onRemoveTag,
    this.onClear,
    this.colorType = EColorType.primary,
    this.customColor,
    this.defaultColor = EBasicColors.borderGray,
    this.customHeight,
    this.customFontSize,
    this.customBorderRadius,
  });

  @override
  State<EInputTag> createState() => _EInputTagState();
}

class _EInputTagState extends State<EInputTag> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
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
      // 清除全部tag
      widget.value?.clear();
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
    widget.onAddTag?.call(tag, newValue);
    _controller.clear();
  }

  void _removeTag(String tag) {
    List<String> newValue = List<String>.from(widget.value ?? []);
    newValue.remove(tag);
    widget.onChanged?.call(newValue);
    widget.onRemoveTag?.call(tag, newValue);
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
        minHeight: ElememtSize(size: widget.size)
            .getInputHeight(customHeight: widget.customHeight),
      ),
      child: MouseRegion(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            borderRadius: BorderRadius.circular(ElememtSize(size: widget.size)
                .getInputBorderRadius(
                    customBorderRadius: widget.customBorderRadius)),
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
                    ...?widget.value?.map((tag) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: widget.tagBuilder != null
                              ? widget.tagBuilder!(context, tag)
                              : defaultTagBuilder(
                                  context,
                                  tag,
                                  widget.colorType,
                                  widget.customColor,
                                  widget.tagEffect,
                                  widget.size,
                                  widget.customFontSize,
                                  widget.disabled,
                                  widget.readOnly,
                                  _hoveredTag,
                                  _removeTag,
                                ),
                        )),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: double.infinity,
                      ),
                      child: KeyboardListener(
                        focusNode: FocusNode(),
                        onKeyEvent: (KeyEvent event) {
                          if (event is KeyDownEvent &&
                              event.logicalKey ==
                                  LogicalKeyboardKey.backspace &&
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
                          style: TextStyle(
                              fontSize: ElememtSize(size: widget.size)
                                  .getInputFontSize(
                                      customFontSize: widget.customFontSize)),
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
                            } else if (widget.trigger ==
                                    EInputTagTrigger.space &&
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
                    ),
                  ],
                ),
              ),
              if (widget.clearable &&
                  (widget.value?.length ?? 0) > 0 &&
                  !widget.disabled &&
                  !widget.readOnly)
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
        ),
      ),
    );
  }
}
