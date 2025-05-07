import 'package:flutter/material.dart';
import 'package:flutter_element/src/theme/index.dart';

class EBasicTextField extends TextField {
  final bool clearable;
  final bool hideLoading;
  final bool isLoading;
  final Widget? prefix;
  final Widget? suffix;
  final Function()? onFocus;
  final Function()? onClear;

  EBasicTextField({
    super.key,
    super.controller,
    super.focusNode,
    super.keyboardType,
    super.textInputAction,
    super.textCapitalization,
    super.style,
    super.enabled,
    super.strutStyle,
    super.textAlign,
    super.textAlignVertical,
    super.textDirection,
    super.readOnly,
    super.showCursor,
    super.autofocus,
    super.obscuringCharacter,
    super.obscureText,
    super.autocorrect,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions,
    super.maxLines,
    super.minLines,
    super.expands,
    super.maxLength,
    super.maxLengthEnforcement,
    super.onChanged,
    super.onEditingComplete,
    super.onSubmitted,
    super.onAppPrivateCommand,
    super.inputFormatters,
    super.cursorWidth,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.selectionHeightStyle,
    super.selectionWidthStyle,
    super.keyboardAppearance,
    super.scrollPadding,
    super.enableInteractiveSelection,
    super.selectionControls,
    super.mouseCursor,
    super.buildCounter,
    super.scrollController,
    super.scrollPhysics,
    super.autofillHints,
    super.clipBehavior,
    super.restorationId,
    super.scribbleEnabled,
    super.enableIMEPersonalizedLearning,
    InputDecoration? decoration,
    String? placeholder,
    this.clearable = false,
    bool disabled = false,
    SizeItem size = SizeItem.medium,
    this.prefix,
    this.suffix,
    this.onFocus,
    this.onClear,
    this.hideLoading = false,
    this.isLoading = false,
  }) : super(
          decoration: (decoration ?? const InputDecoration()).copyWith(
            hintText: placeholder,
            hintStyle: TextStyle(color: EColors.BorderGray),
            contentPadding: ElememtSize(size: size).getInputPadding(size),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: EColors.BorderGray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: EColors.BorderGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: EColors.Primary),
            ),
          ),
        );
}
