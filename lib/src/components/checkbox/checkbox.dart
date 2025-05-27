import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

class ECheckbox extends StatefulWidget {
  final bool? value;
  final String? label;
  final bool disabled;
  final bool border;
  final ESizeItem size;
  final String? name;
  final bool checked;
  final bool indeterminate;
  final bool validateEvent;
  final String? tabindex;
  final String? id;
  final String? ariaControls;
  final Function(bool?)? onChange;

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
