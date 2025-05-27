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

  /// Whether to show a border around the checkbox.
  ///
  /// When true, the checkbox will be displayed with a border.
  final bool border;

  /// The size of the checkbox.
  ///
  /// Defaults to [ESizeItem.medium].
  final ESizeItem size;

  /// The name of the checkbox.
  ///
  /// This is used for form submission and accessibility.
  final String? name;

  /// Whether the checkbox is checked.
  ///
  /// This controls the initial checked state of the checkbox.
  final bool checked;

  /// Whether the checkbox is in an indeterminate state.
  ///
  /// When true, the checkbox will show a different style to indicate
  /// that it is neither checked nor unchecked.
  final bool indeterminate;

  /// Whether to trigger validation events.
  ///
  /// When true, the checkbox will trigger form validation when its state changes.
  final bool validateEvent;

  /// The tab index of the checkbox.
  ///
  /// This is used for keyboard navigation and accessibility.
  final String? tabindex;

  /// The unique identifier of the checkbox.
  ///
  /// This is used for accessibility and testing.
  final String? id;

  /// The ARIA controls attribute of the checkbox.
  ///
  /// This is used for accessibility to indicate which elements
  /// are controlled by this checkbox.
  final String? ariaControls;

  /// Callback function when the checkbox state changes.
  ///
  /// The callback receives the new checked state of the checkbox.
  final Function(bool?)? onChange;

  /// Creates an [ECheckbox] widget.
  ///
  /// The [checked] argument defaults to false.
  const ECheckbox({
    super.key,
    this.value,
    this.label,
    this.disabled = false,
    this.border = false,
    this.size = ESizeItem.medium,
    this.name,
    this.checked = false,
    this.indeterminate = false,
    this.validateEvent = true,
    this.tabindex,
    this.id,
    this.ariaControls,
    this.onChange,
  });

  @override
  State<ECheckbox> createState() => _ECheckboxState();
}

class _ECheckboxState extends State<ECheckbox> {
  late bool _isChecked;

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
    if (widget.disabled) return;
    setState(() {
      // widget.value = _isChecked;
      _isChecked = !_isChecked;
    });
    if (widget.onChange != null) {
      widget.onChange!(_isChecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkboxSize = ElememtSize(size: widget.size).getCheckboxSize();
    // final backgroundColor =
    //     widget.disabled ? EBasicColors.borderGray : EColorTypes.primary;

    Widget checkbox = SizedBox(
      width: checkboxSize,
      height: checkboxSize,
      // decoration: BoxDecoration(
      //   border: Border.all(color: EBasicColors.borderGray),
      // ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleTap,
          child: Center(
            child: _isChecked
                ? Transform.translate(
                    offset: const Offset(-2, -2),
                    child: Icon(
                      Icons.check_box,
                      size: checkboxSize + 4,
                      color: widget.disabled
                          ? EBasicColors.borderGray
                          : EColorTypes.primary,
                    ),
                  )
                : Transform.translate(
                    offset: const Offset(-2, -2),
                    child: Icon(
                      Icons.check_box_outline_blank,
                      size: checkboxSize + 4,
                      color: widget.disabled
                          ? EBasicColors.borderGray
                          : EBasicColors.borderGray,
                    ),
                  ),
          ),
        ),
      ),
    );

    if (widget.label != null) {
      checkbox = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          checkbox,
          const SizedBox(width: 8),
          Text(
            widget.label!,
            style: TextStyle(
              color: widget.disabled ? EBasicColors.borderGray : Colors.black87,
              fontSize: 14,
            ),
          ),
        ],
      );
    }

    return checkbox;
  }
}
