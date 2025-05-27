import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';
import 'radio_style.dart';

/// A radio button component that follows Element Plus design guidelines.
/// 
/// The [ERadio] widget provides a single radio button that can be used independently
/// or as part of a [ERadioGroup]. It supports different sizes, states, and styles.
/// 
/// ## Example
/// 
/// ```dart
/// // Single radio button
/// ERadio(
///   value: '1',
///   label: 'Option 1',
///   onChanged: (value) => print('Selected: $value'),
/// )
/// 
/// // Radio group
/// ERadioGroup(
///   value: '1',
///   onChanged: (value) => print('Selected: $value'),
///   children: [
///     ERadio(value: '1', label: 'Option 1'),
///     ERadio(value: '2', label: 'Option 2'),
///   ],
/// )
/// ```
class ERadio extends StatefulWidget {
  /// The value of the radio button.
  /// 
  /// This value is used to identify the radio button in a group.
  final String? value;

  /// The label text to display next to the radio button.
  final String? label;

  /// Whether the radio button is disabled.
  /// 
  /// When true, the radio button cannot be selected and will show a disabled style.
  final bool disabled;

  /// Whether to show a border around the radio button.
  /// 
  /// When true, the radio button will be displayed with a border.
  final bool border;

  /// The size of the radio button.
  /// 
  /// If not provided, the size will be inherited from the parent [ERadioGroup]
  /// or default to [ERadioSize.medium].
  final ERadioSize? size;

  /// The name of the radio button.
  /// 
  /// This is used for form submission and accessibility.
  final String? name;

  /// Callback function when the radio button is selected.
  /// 
  /// The callback receives the [value] of the selected radio button.
  final ValueChanged<String>? onChanged;

  /// Creates an [ERadio] widget.
  const ERadio({
    super.key,
    this.value,
    this.label,
    this.disabled = false,
    this.border = false,
    this.size,
    this.name,
    this.onChanged,
  });

  @override
  State<ERadio> createState() => _ERadioState();
}

class _ERadioState extends State<ERadio> {
  bool _isHovered = false;

  double getSize(ERadioSize size) {
    switch (size) {
      case ERadioSize.small:
        return 14;
      case ERadioSize.large:
        return 18;
      case ERadioSize.medium:
        return 16;
    }
  }

  double getFontSize(ERadioSize size) {
    switch (size) {
      case ERadioSize.small:
        return 12;
      case ERadioSize.large:
        return 16;
      case ERadioSize.medium:
        return 14;
    }
  }

  @override
  Widget build(BuildContext context) {
    final radioGroup = RadioGroup.of(context);
    final ERadioSize effectiveSize =
        widget.size ?? radioGroup?.size ?? ERadioSize.medium;
    final isChecked = radioGroup?.value == widget.value;
    final isDisabled = widget.disabled || radioGroup?.disabled == true;

    Widget radio = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: isDisabled
            ? null
            : () => radioGroup?.onChanged?.call(widget.value ?? ''),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: widget.border
              ? BoxDecoration(
                  border: Border.all(
                    color: isDisabled
                        ? EBasicColors.borderGray
                        : isChecked
                            ? EColorTypes.primary
                            : _isHovered
                                ? EColorTypes.primary.withValues(alpha: 0.5)
                                : EBasicColors.borderGray,
                  ),
                  borderRadius: BorderRadius.circular(4),
                )
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: getSize(effectiveSize),
                height: getSize(effectiveSize),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDisabled
                        ? EBasicColors.borderGray
                        : isChecked
                            ? EColorTypes.primary
                            : _isHovered
                                ? EColorTypes.primary.withValues(alpha: 0.5)
                                : EBasicColors.borderGray,
                    width: 1,
                  ),
                ),
                child: isChecked
                    ? Center(
                        child: Container(
                          width: getSize(effectiveSize) * 0.5,
                          height: getSize(effectiveSize) * 0.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDisabled
                                ? EBasicColors.borderGray
                                : EColorTypes.primary,
                          ),
                        ),
                      )
                    : null,
              ),
              if (widget.label != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    widget.label!,
                    style: TextStyle(
                      fontSize: getFontSize(effectiveSize),
                      color: isDisabled
                          ? EBasicColors.textGray
                          : EColorTypes.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    return radio;
  }
}

/// An inherited widget that provides radio group state to its descendants.
/// 
/// This widget is used internally by [ERadioGroup] to manage the state of
/// a group of radio buttons.
class RadioGroup extends InheritedWidget {
  /// The currently selected value in the radio group.
  final String? value;

  /// Whether all radio buttons in the group are disabled.
  final bool disabled;

  /// Callback function when a radio button in the group is selected.
  final ValueChanged<String>? onChanged;

  /// The size of radio buttons in the group.
  final ERadioSize size;

  /// Creates a [RadioGroup] widget.
  const RadioGroup({
    super.key,
    required super.child,
    this.value,
    this.disabled = false,
    this.onChanged,
    this.size = ERadioSize.medium,
  });

  /// Returns the nearest [RadioGroup] widget in the widget tree.
  /// 
  /// This method is used by [ERadio] widgets to access the group's state.
  static RadioGroup? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RadioGroup>();
  }

  @override
  bool updateShouldNotify(RadioGroup oldWidget) {
    return value != oldWidget.value ||
        disabled != oldWidget.disabled ||
        size != oldWidget.size;
  }
}

/// A group of radio buttons that work together.
/// 
/// The [ERadioGroup] widget manages a group of [ERadio] widgets, ensuring that
/// only one radio button can be selected at a time.
/// 
/// ## Example
/// 
/// ```dart
/// ERadioGroup(
///   value: '1',
///   onChanged: (value) => print('Selected: $value'),
///   children: [
///     ERadio(value: '1', label: 'Option 1'),
///     ERadio(value: '2', label: 'Option 2'),
///     ERadio(value: '3', label: 'Option 3'),
///   ],
/// )
/// ```
class ERadioGroup extends StatefulWidget {
  /// The currently selected value in the radio group.
  final String? value;

  /// Whether all radio buttons in the group are disabled.
  final bool disabled;

  /// Callback function when a radio button in the group is selected.
  final ValueChanged<String>? onChanged;

  /// The size of radio buttons in the group.
  final ERadioSize size;

  /// The list of radio buttons in the group.
  /// 
  /// Each child should be an [ERadio] widget.
  final List<Widget> children;

  /// Creates an [ERadioGroup] widget.
  /// 
  /// The [children] argument must not be null and must contain [ERadio] widgets.
  const ERadioGroup({
    super.key,
    this.value,
    this.disabled = false,
    this.onChanged,
    this.size = ERadioSize.medium,
    required this.children,
  });

  @override
  State<ERadioGroup> createState() => _ERadioGroupState();
}

class _ERadioGroupState extends State<ERadioGroup> {
  @override
  Widget build(BuildContext context) {
    return RadioGroup(
      value: widget.value,
      disabled: widget.disabled,
      onChanged: widget.onChanged,
      size: widget.size,
      child: Wrap(
        spacing: 16,
        children: widget.children,
      ),
    );
  }
}
