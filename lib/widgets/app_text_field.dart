import '../config/config.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType textInputType;
  final bool obscure;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final ValueChanged<String>? fieldSubmitted;
  final TextCapitalization textCapitalization;
  final AutovalidateMode autoValidateMode;
  final Function(String)? onChanged;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final Color backgroundColor;
  final Color? borderColor;
  final bool enabled;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final Iterable<String>? autoFillHints;
  final List<TextInputFormatter>? inputFormatters;
  final bool showOutlines;
  final int? errorLines;
  final String? errorText;
  final int? maxLines;
  final int? minLines;
  final EdgeInsetsGeometry? contentPadding;
  final int? textLength;
  final bool showCounterText;
  final double borderRadius;
  final Color? fillColor;
  final TextAlign align;
  final InputBorder? border;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;

  const AppTextField(
    this.controller, {
    this.textInputType = TextInputType.text,
    this.hintText,
    this.obscure = false,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.focusNode,
    this.fieldSubmitted,
    this.textCapitalization = TextCapitalization.words,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.initialValue,
    this.suffixIcon,
    this.style,
    this.hintStyle = AppTextStyle.textFieldHint,
    this.errorStyle,
    this.backgroundColor = AppColor.transparent,
    this.borderColor,
    this.enabled = true,
    this.prefixIcon,
    this.onTap,
    this.autoFillHints,
    this.inputFormatters,
    this.showOutlines = true,
    this.errorLines,
    this.errorText,
    this.maxLines = 1,
    this.minLines,
    this.textLength,
    this.showCounterText = false,
    this.borderRadius = 50,
    this.fillColor,
    this.align = TextAlign.start,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    Key? key,
  })  : border = const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide(color: AppColor.textSecondaryLight, width: 0.25)),
        contentPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        super(key: key);

  const AppTextField.fill(
    this.controller, {
    this.textInputType = TextInputType.text,
    this.hintText,
    this.obscure = false,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.focusNode,
    this.fieldSubmitted,
    this.textCapitalization = TextCapitalization.words,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.initialValue,
    this.suffixIcon,
    this.style = AppTextStyle.textFieldText,
    this.errorStyle = AppTextStyle.textFieldError,
    this.backgroundColor = AppColor.transparent,
    this.borderColor,
    this.enabled = true,
    this.prefixIcon,
    this.onTap,
    this.autoFillHints,
    this.inputFormatters,
    this.showOutlines = true,
    this.errorLines,
    this.errorText,
    this.maxLines = 1,
    this.minLines,
    this.textLength,
    this.showCounterText = false,
    this.borderRadius = 50,
    this.fillColor = AppColor.textFieldBG,
    this.align = TextAlign.start,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    Key? key,
  })  : border = const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: AppColor.transparent),
        ),
        hintStyle = AppTextStyle.textFieldFillHint,
        contentPadding = const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = border ?? UnderlineInputBorder(borderSide: BorderSide(color: borderColor ?? AppColor.black));
    final child = TextFormField(
      key: key,
      validator: validator,
      readOnly: !enabled,
      textInputAction: textInputAction,
      onFieldSubmitted: fieldSubmitted,
      autovalidateMode: autoValidateMode,
      controller: controller,
      autofillHints: autoFillHints ?? [],
      textCapitalization: textCapitalization,
      onSaved: (value) {},
      focusNode: focusNode,
      obscureText: obscure,
      onChanged: onChanged ?? (_) {},
      keyboardType: textInputType,
      maxLines: obscure ? 1 : maxLines,
      minLines: minLines,
      maxLength: textLength,
      inputFormatters: inputFormatters,
      onTap: onTap,
      style: style ?? AppTextStyle.defaultText,
      initialValue: initialValue,
      cursorColor: AppColor.textSecondary,
      textAlign: align,
      buildCounter: (context, {required currentLength, required maxLength, required isFocused}) =>
          showCounterText ? AppText.regular('$currentLength/$maxLength', size: 10, color: AppColor.textSecondary) : null,
      decoration: InputDecoration(
        fillColor: fillColor ?? AppColor.transparent,
        errorText: errorText,
        filled: true,
        isDense: contentPadding != null,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        errorMaxLines: errorLines ?? 1,
        hintText: hintText ?? '',
        focusedErrorBorder: inputBorder,
        disabledBorder: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        errorBorder: inputBorder.copyWith(borderSide: const BorderSide(color: AppColor.error)),
        errorStyle: errorStyle,
        hintStyle: hintStyle ?? AppTextStyle.defaultHint,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints ?? const BoxConstraints(minHeight: 35, maxHeight: 60, maxWidth: 50, minWidth: 35),
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints ?? const BoxConstraints(minHeight: 35, maxHeight: 60, maxWidth: 50, minWidth: 35),
      ),
    );
    return child;
  }
}
