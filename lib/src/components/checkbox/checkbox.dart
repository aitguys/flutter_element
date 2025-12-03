import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

/// A checkbox component that follows Element Plus design guidelines.
///
/// The [ECheckbox] widget provides a checkbox input that can be used to select
/// or deselect an option. It supports different sizes, states, and styles.
///
/// ## Example
///
/// ```dart
/// ECheckbox(
///   label: 'Accept terms and conditions',
///   checked: false,
///   onChange: (value) => print('Checked: $value'),
/// )
/// ```
class ECheckbox extends StatefulWidget {
  /// The value of the checkbox.
  ///
  /// This is used for form submission and accessibility.
  final bool? value;

  /// The label text to display next to the checkbox.
  final String? label;

  /// Whether the checkbox is disabled.
  ///
  /// When true, the checkbox cannot be selected and will show a disabled style.
  final bool disabled;

  /// Whether the checkbox is read-only.
  ///
  /// When true, the checkbox cannot be changed but can still be focused.
  final bool readOnly;

  /// Whether to show a border around the checkbox.
  ///
  /// When true, the checkbox will be displayed with a border.
  final bool border;

  /// The size of the checkbox.
  ///
  /// Defaults to [ESizeItem.medium].
  final ESizeItem size;

  /// Whether the checkbox is checked.
  ///
  /// This controls the initial checked state of the checkbox.
  final bool checked;

  /// The color type of the checkbox text.
  ///
  /// This determines the color scheme used for the checkbox's text.
  /// Defaults to [EColorType.primary].
  final EColorType fontColorType;

  /// A custom color to use for the checkbox text.
  ///
  /// If provided, this overrides the color determined by [fontColorType].
  final Color? fontCustomColor;

  /// The color type of the checkbox icon.
  ///
  /// This determines the color scheme used for the checkbox's icon.
  /// Defaults to [EColorType.primary].
  final EColorType iconColorType;

  /// A custom color to use for the checkbox icon.
  ///
  /// If provided, this overrides the color determined by [iconColorType].
  final Color? iconCustomColor;

  /// A custom font size for the checkbox.
  ///
  /// If provided, this overrides the font size determined by [size].
  final double? customFontSize;

  /// A custom size for the checkbox.
  ///
  /// If provided, this overrides the size determined by [size].
  final double? customIconSize;

  /// Callback function when the checkbox state changes.
  ///
  /// The callback receives the new checked state of the checkbox.
  final Function(bool)? onChange;

  /// Creates an [ECheckbox] widget.
  ///
  /// The [checked] argument defaults to false.
  const ECheckbox({
    super.key,
    this.value,
    this.label,
    this.disabled = false,
    this.readOnly = false,
    this.border = false,
    this.size = ESizeItem.medium,
    this.checked = false,
    this.fontColorType = EColorType.primary,
    this.fontCustomColor,
    this.iconColorType = EColorType.primary,
    this.iconCustomColor,
    this.customFontSize,
    this.customIconSize,
    this.onChange,
  });

  @override
  State<ECheckbox> createState() => _ECheckboxState();
}

class _ECheckboxState extends State<ECheckbox> {
  late bool _isChecked;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.checked;
  }

  @override
  void didUpdateWidget(ECheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.checked != widget.checked) {
      _isChecked = widget.checked;
    }
  }

  void _handleTap() {
    if (widget.disabled || widget.readOnly) return;
    setState(() {
      _isChecked = !_isChecked;
    });
    if (widget.onChange != null) {
      widget.onChange!(_isChecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkboxSize = ElememtSize(size: widget.size)
        .getCheckboxSize(customSize: widget.customIconSize);

    Widget checkbox = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: widget.border
              ? BoxDecoration(
                  border: Border.all(
                    color: widget.disabled
                        ? EBasicColors.borderGray
                        : _isChecked
                            ? getColorByType(
                                type: widget.iconColorType,
                                customColor: widget.iconCustomColor)
                            : _isHovered
                                ? getColorByType(
                                        type: widget.iconColorType,
                                        customColor: widget.iconCustomColor)
                                    .withValues(alpha: 0.5)
                                : EBasicColors.borderGray,
                  ),
                  borderRadius: BorderRadius.circular(4),
                )
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: checkboxSize,
                height: checkboxSize,
                child: _isChecked
                    ? Icon(
                        Icons.check_box,
                        size: checkboxSize,
                        color: widget.disabled
                            ? EBasicColors.borderGray
                            : getColorByType(
                                type: widget.iconColorType,
                                customColor: widget.iconCustomColor),
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        size: checkboxSize,
                        color: widget.disabled
                            ? EBasicColors.borderGray
                            : _isHovered
                                ? getColorByType(
                                        type: widget.iconColorType,
                                        customColor: widget.iconCustomColor)
                                    .withValues(alpha: 0.5)
                                : EBasicColors.borderGray,
                      ),
              ),
              if (widget.label != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    widget.label!,
                    style: TextStyle(
                      color: widget.disabled
                          ? EBasicColors.borderGray
                          : getColorByType(
                              type: widget.fontColorType,
                              customColor: widget.fontCustomColor),
                      fontSize: ElememtSize(size: widget.size).getInputFontSize(
                          customFontSize: widget.customFontSize),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    return checkbox;
  }
}
