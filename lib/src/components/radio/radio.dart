import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';

enum ERadioSize { small, medium, large }

class ERadio extends StatefulWidget {
  final String? value;
  final String? label;
  final bool disabled;
  final bool border;
  final ERadioSize size;
  final String? name;
  final ValueChanged<String>? onChanged;

  const ERadio({
    Key? key,
    this.value,
    this.label,
    this.disabled = false,
    this.border = false,
    this.size = ERadioSize.medium,
    this.name,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ERadio> createState() => _ERadioState();
}

class _ERadioState extends State<ERadio> {
  bool _isHovered = false;

  double get _size {
    switch (widget.size) {
      case ERadioSize.small:
        return 14;
      case ERadioSize.large:
        return 18;
      case ERadioSize.medium:
      default:
        return 16;
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case ERadioSize.small:
        return 12;
      case ERadioSize.large:
        return 16;
      case ERadioSize.medium:
      default:
        return 14;
    }
  }

  @override
  Widget build(BuildContext context) {
    final radioGroup = RadioGroup.of(context);
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
          padding: EdgeInsets.all(4),
          decoration: widget.border
              ? BoxDecoration(
                  border: Border.all(
                    color: isDisabled
                        ? EColors.BorderGray
                        : isChecked
                            ? EColors.Primary
                            : _isHovered
                                ? EColors.Primary.withOpacity(0.5)
                                : EColors.BorderGray,
                  ),
                  borderRadius: BorderRadius.circular(4),
                )
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: _size,
                height: _size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDisabled
                        ? EColors.BorderGray
                        : isChecked
                            ? EColors.Primary
                            : _isHovered
                                ? EColors.Primary.withOpacity(0.5)
                                : EColors.BorderGray,
                    width: 1,
                  ),
                ),
                child: isChecked
                    ? Center(
                        child: Container(
                          width: _size * 0.5,
                          height: _size * 0.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDisabled
                                ? EColors.BorderGray
                                : EColors.Primary,
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
                      fontSize: _fontSize,
                      color: isDisabled ? EColors.TextGray : EColors.Primary,
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

class RadioGroup extends InheritedWidget {
  final String? value;
  final bool disabled;
  final ValueChanged<String>? onChanged;
  final ERadioSize size;

  const RadioGroup({
    Key? key,
    required Widget child,
    this.value,
    this.disabled = false,
    this.onChanged,
    this.size = ERadioSize.medium,
  }) : super(key: key, child: child);

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

class ERadioGroup extends StatefulWidget {
  final String? value;
  final bool disabled;
  final ValueChanged<String>? onChanged;
  final ERadioSize size;
  final List<Widget> children;

  const ERadioGroup({
    Key? key,
    this.value,
    this.disabled = false,
    this.onChanged,
    this.size = ERadioSize.medium,
    required this.children,
  }) : super(key: key);

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
