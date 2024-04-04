import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/text_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    required this.hint,
    super.key,
    bool isDisable = false,
    this.error,
    this.obscureText = false,
    this.textStyle,
    this.hintStyle,
    this.decoration,
    this.keyboardAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.validators,
    this.inputFormatters,
    this.maxLength,
    this.enabled = true,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.obscuringCharacter,
    this.onTap,
    this.readOnly = false,
    this.enableInteractiveSelection = true,
    this.suffixIcon,
    this.initValue,
    this.onSubmitted,
    this.paddingLeft = false,
    this.contentPadding,
    this.prefixIcon,
    this.onSaved,
    this.prefixText,
    this.maxLines = 1,
    this.minLise = 1,
    this.height = 1,
    this.filled = true,
    this.fillColor = AppColor.textFieldSecondaryColor,
    this.suffix,
    this.prefix,
    this.onChanged,
    this.errorText,
    this.buildCounter,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.isDense,
    this.autocorrect = true,
    this.borderRadius,
    this.cursorColor,
    this.enableSuggestions,
    this.autovalidateMode,
  });

  final String label;
  final String hint;
  final String? prefixText;
  final String? errorText;
  final String? error;
  final bool obscureText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final InputDecoration? decoration;
  final TextInputAction keyboardAction;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validators;
  final List<TextInputFormatter>? inputFormatters;
  final InputCounterWidgetBuilder? buildCounter;
  final int? maxLength;
  final Widget? prefixIcon;
  final bool enabled;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final Widget? suffixIcon;
  final String? initValue;
  final FormFieldSetter<String>? onSaved;
  final bool paddingLeft;
  final EdgeInsets? contentPadding;
  final int maxLines;
  final int minLise;
  final double height;
  final bool filled;
  final Color fillColor;
  final Widget? suffix;
  final Widget? prefix;
  final ValueSetter<String?>? onChanged;
  final VoidCallback? onSubmitted;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final bool? isDense;
  final bool? autocorrect;
  final String? obscuringCharacter;
  final double? borderRadius;
  final Color? cursorColor;
  final bool? enableSuggestions;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: autocorrect ?? true,
      enableSuggestions: enableSuggestions ?? true,
      initialValue: initValue,
      onSaved: onSaved,
      cursorColor: cursorColor ?? AppColor.colorHint,
      enableInteractiveSelection: enableInteractiveSelection,
      readOnly: readOnly,
      onTap: onTap,
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      minLines: minLise,
      maxLines: maxLines,
      autovalidateMode: autovalidateMode,
      obscuringCharacter: obscuringCharacter ?? '*',
      style: textStyle ??
          textRegular.copyWith(
            color: fillColor == AppColor.textFieldSecondaryColor
                ? AppColor.textColor
                : AppColor.textTertiary,
            fontSize: AppSize.sp12,
          ),
      obscureText: obscureText,
      validator: validators ??
          (value) {
            return null;
          },
      keyboardType: keyboardType,
      textInputAction: keyboardAction,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      onFieldSubmitted: (_) => submit(context),
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      decoration: decoration ??
          InputDecoration(
            counterStyle: textMedium.copyWith(
                color: AppColor.accentColor.withOpacity(0.50)),
            counterText: '',
            prefixText: prefixText,
            isDense: isDense,
            prefix: prefix,
            prefixStyle: textMedium.copyWith(color: Colors.black),
            prefixIcon: prefixIcon,
            prefixIconConstraints: prefixIconConstraints,
            filled: filled,
            fillColor: fillColor,
            hintText: hint,
            hintMaxLines: 1,
            suffixIcon: suffixIcon,
            suffix: suffix,
            suffixIconConstraints: suffixIconConstraints,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: hintStyle ??
                textStyle ??
                textRegular.copyWith(
                  color: AppColor.placeholderColor,
                  fontSize: AppSize.sp12,
                ),
            errorStyle: textRegular.copyWith(
              color: AppColor.errorColor,
              fontSize: AppSize.sp16,
            ),
            errorMaxLines: 2,
            labelStyle: textRegular.copyWith(
              color: AppColor.colorHint,
              fontSize: AppSize.sp16,
            ),
            alignLabelWithHint: true,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                    horizontal: AppSize.w16, vertical: AppSize.h18),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? AppSize.h10),
              borderSide: filled
                  ? (fillColor == AppColor.textFieldSecondaryColor)
                      ? const BorderSide(color: AppColor.colorHint, width: 2)
                      : BorderSide.none
                  : const BorderSide(color: AppColor.colorHint, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? AppSize.h10),
              borderSide:
                  const BorderSide(color: AppColor.colorHint, width: 0.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? AppSize.h10),
              borderSide: const BorderSide(
                color: AppColor.errorColor,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColor.colorHint,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? AppSize.h10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? AppSize.h10),
              borderSide: const BorderSide(
                color: AppColor.errorColor,
                width: 2,
              ),
            ),
          ),
    );
  }

  void submit(BuildContext context) {
    onSubmitted?.call();
    switch (keyboardAction) {
      case TextInputAction.done:
        FocusScope.of(context).unfocus();
      case TextInputAction.next:
        FocusScope.of(context).requestFocus(nextFocusNode);
      // ignore: no_default_cases
      default:
        FocusScope.of(context).nextFocus();
    }
  }
}

class AppFormTextField extends StatelessWidget {
  const AppFormTextField({
    required this.label,
    required this.hint,
    super.key,
    bool isDisable = false,
    this.error,
    this.obscureText = false,
    this.textStyle,
    this.hintStyle,
    this.decoration,
    this.keyboardAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.validators,
    this.inputFormatters,
    this.maxLength,
    this.enabled = true,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.obscuringCharacter,
    this.onTap,
    this.readOnly = false,
    this.enableInteractiveSelection = true,
    this.suffixIcon,
    this.initValue,
    this.onSubmitted,
    this.paddingLeft = false,
    this.contentPadding,
    this.prefixIcon,
    this.onSaved,
    this.prefixText,
    this.maxLines = 1,
    this.minLise = 1,
    this.height = 1,
    this.filled = true,
    this.fillColor = AppColor.textFieldSecondaryColor,
    this.suffix,
    this.prefix,
    this.onChanged,
    this.errorText,
    this.buildCounter,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.isDense,
    this.autocorrect = true,
    this.borderRadius,
    this.cursorColor,
    this.enableSuggestions,
    this.autovalidateMode,
  });

  final String label;
  final String hint;
  final String? prefixText;
  final String? errorText;
  final String? error;
  final bool obscureText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final InputDecoration? decoration;
  final TextInputAction keyboardAction;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validators;
  final List<TextInputFormatter>? inputFormatters;
  final InputCounterWidgetBuilder? buildCounter;
  final int? maxLength;
  final Widget? prefixIcon;
  final bool enabled;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final Widget? suffixIcon;
  final String? initValue;
  final FormFieldSetter<String>? onSaved;
  final bool paddingLeft;
  final EdgeInsets? contentPadding;
  final int maxLines;
  final int minLise;
  final double height;
  final bool filled;
  final Color fillColor;
  final Widget? suffix;
  final Widget? prefix;
  final ValueSetter<String?>? onChanged;
  final VoidCallback? onSubmitted;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final bool? isDense;
  final bool? autocorrect;
  final String? obscuringCharacter;
  final double? borderRadius;
  final Color? cursorColor;
  final bool? enableSuggestions;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: autocorrect ?? true,
      enableSuggestions: enableSuggestions ?? true,
      initialValue: initValue,
      onSaved: onSaved,
      cursorColor: cursorColor ?? AppColor.colorHint,
      enableInteractiveSelection: enableInteractiveSelection,
      readOnly: readOnly,
      onTap: onTap,
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      minLines: minLise,
      maxLines: maxLines,
      autovalidateMode: autovalidateMode,
      obscuringCharacter: obscuringCharacter ?? '*',
      style: textStyle ??
          textRegular.copyWith(
            color: fillColor == AppColor.textFieldSecondaryColor
                ? AppColor.textColor
                : AppColor.textTertiary,
            fontSize: AppSize.sp12,
          ),
      obscureText: obscureText,
      validator: validators ??
          (value) {
            return null;
          },
      keyboardType: keyboardType,
      textInputAction: keyboardAction,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      onFieldSubmitted: (_) => submit(context),
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      decoration: decoration ??
          InputDecoration(
            counterStyle: textMedium.copyWith(
                color: AppColor.accentColor.withOpacity(0.50)),
            counterText: '',
            prefixText: prefixText,
            isDense: isDense,
            prefix: prefix,
            prefixStyle: textMedium.copyWith(color: Colors.black),
            prefixIcon: prefixIcon,
            prefixIconConstraints: prefixIconConstraints,
            filled: filled,
            fillColor: fillColor,
            hintText: hint,
            hintMaxLines: 1,
            suffixIcon: suffixIcon,
            suffix: suffix,
            suffixIconConstraints: suffixIconConstraints,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: hintStyle ??
                textStyle ??
                textRegular.copyWith(
                  color: AppColor.placeholderColor,
                  fontSize: AppSize.sp12,
                ),
            errorStyle: textRegular.copyWith(
              color: AppColor.errorColor,
              fontSize: AppSize.sp12,
            ),
            errorMaxLines: 2,
            labelStyle: textRegular.copyWith(
              color: AppColor.colorHint,
              fontSize: AppSize.sp16,
            ),
            alignLabelWithHint: true,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                    horizontal: AppSize.w16, vertical: AppSize.h18),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
              borderSide: filled
                  ? (fillColor == AppColor.textFieldSecondaryColor)
                      ? const BorderSide(color: AppColor.colorHint, width: 2)
                      : BorderSide.none
                  : const BorderSide(color: AppColor.colorHint, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
              borderSide:
                  const BorderSide(color: AppColor.colorHint, width: 0.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
              borderSide: const BorderSide(
                color: AppColor.errorColor,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColor.colorHint,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
              borderSide: const BorderSide(
                color: AppColor.errorColor,
                width: 2,
              ),
            ),
          ),
    );
  }

  void submit(BuildContext context) {
    onSubmitted?.call();
    switch (keyboardAction) {
      case TextInputAction.done:
        FocusScope.of(context).unfocus();
      case TextInputAction.next:
        FocusScope.of(context).requestFocus(nextFocusNode);
      // ignore: no_default_cases
      default:
        FocusScope.of(context).nextFocus();
    }
  }
}
