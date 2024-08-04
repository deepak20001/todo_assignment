import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_assignment/utils/common/common_color.dart';
import 'package:todo_assignment/utils/common/common_const.dart';

/// ::::: Common Text FormField :::::
class CustomTextFormField extends StatelessWidget {
  final Size size;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? fillColor;
  final double borderWidth;
  final String? labelText;
  final Function()? onTap;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Widget? suffixIcon;
  final String? suffixText;
  final String hintText;
  final String errorText;
  final double textSize;
  final double? fontTextSize;
  final double? containerHeight;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool showCounterText;
  final bool isRead;
  final bool isObscure;
  final double prefixIconWidth;
  final double prefixIconHeight;
  final double suffixIconWidth;
  final double suffixIconHeight;
  final double borderRadius;
  final String? Function(String?)? validation;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Function(String)? onDone;
  final bool enabled;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? hintStyle;
  final double? horizontalPadding;
  final double? verticalPadding;
  final bool? showBorder;
  final bool? filled;
  final bool? autofocus;
  final FocusNode? focusNode;
  final TextInputFormatter? inputFormatter;

  const CustomTextFormField({
    super.key,
    required this.size,
    required this.hintText,
    this.controller,
    this.suffixIcon,
    this.suffixText,
    this.maxLines,
    this.maxLength,
    this.keyboardType,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixWidget,
    this.onTap,
    this.validation,
    this.textSize = numD04,
    this.fontTextSize = numD04,
    this.containerHeight = 0.07,
    this.textColor,
    this.hintTextColor,
    this.fillColor,
    this.borderWidth = numD001,
    this.borderColor,
    this.errorText = '',
    this.isRead = false,
    this.showCounterText = false,
    this.isObscure = false,
    this.prefixIconWidth = 50.0,
    this.prefixIconHeight = 50.0,
    this.suffixIconWidth = 50.0,
    this.suffixIconHeight = 50.0,
    this.enabled = false,
    this.borderRadius = num1,
    this.labelText,
    this.onChange,
    this.onDone,
    this.textCapitalization,
    this.textInputAction = TextInputAction.done,
    this.hintStyle,
    this.horizontalPadding,
    this.verticalPadding,
    this.showBorder,
    this.filled,
    this.autofocus = false,
    this.focusNode,
    this.inputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      keyboardAppearance: Brightness.light,
      cursorColor: CommonColor.blackColor,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: autofocus!,
      readOnly: isRead,
      onTap: onTap,
      maxLines: isObscure ? 1 : maxLines,
      maxLength: maxLength,
      autocorrect: false,
      obscureText: isObscure,
      keyboardType: keyboardType,
      onChanged: onChange,
      onFieldSubmitted: onDone,
      textInputAction: textInputAction,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: size.width * (fontTextSize ?? numD04),
        fontStyle: FontStyle.normal,
        color: textColor ?? Colors.black,
      ),
      validator: validation,
      decoration: _buildDecoration(),
      inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      errorStyle: const TextStyle(
        height: 0,
        color: Colors.red,
      ),
      counterText: showCounterText ? null : "",
      hintText: hintText,
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? size.width * numD035,
        vertical: verticalPadding ?? size.width * numD038,
      ),
      prefixIcon: prefixIcon,
      prefixIconConstraints: BoxConstraints(
        minWidth: prefixIconWidth,
        minHeight: prefixIconHeight,
      ),
      suffixIconConstraints: BoxConstraints(
        minWidth: suffixIconWidth,
        minHeight: suffixIconHeight,
      ),
      prefix: prefixWidget,
      suffixIcon: suffixIcon,
      suffixText: suffixText,
      suffixStyle: const TextStyle(color: Colors.grey),
      suffix: suffixWidget,
      hintStyle: hintStyle ??
          TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: size.width * numD035,
            color: hintTextColor ?? CommonColor.hintTextColor,
          ),
      labelText: labelText,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: textSize,
        color: Colors.black,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      filled: filled ?? false,
      fillColor: fillColor,
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: CommonColor.errorColor, width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: CommonColor.errorColor, width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      border: OutlineInputBorder(
        borderSide:
            BorderSide(color: borderColor ?? CommonColor.blackColor, width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: borderColor ?? CommonColor.blackColor, width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: borderColor ?? CommonColor.blackColor, width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
