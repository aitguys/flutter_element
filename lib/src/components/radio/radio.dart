import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';
import 'radio_style.dart';

class ERadio extends StatefulWidget {
  final String? value;
  final String? label;
  final bool disabled;
  final bool border;
  final ERadioSize? size;
  final String? name;
  final ValueChanged<String>? onChanged;

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

class RadioGroup extends InheritedWidget {
  final String? value;
  final bool disabled;
  final ValueChanged<String>? onChanged;
  final ERadioSize size;

  const RadioGroup({
    super.key,
    required super.child,
    this.value,
    this.disabled = false,
    this.onChanged,
    this.size = ERadioSize.medium,
  });

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
