import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.label,
    this.filled,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.validator,
    this.obscureText,
    this.controller,
    this.keyboardType,
    this.textAlign,
    this.maxLines,
    this.errorStyle,
    this.hintStyle,
    this.onChanged,
    this.onSaved,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.focusNode,
    this.onFieldSubmitted,
    this.contentPadding,
    this.isDense,
    this.prefix,
    this.style, this.prefixText, this.prefixStyle, this.inputFormatters,
  });
  final String? hintText;
  final Widget? prefix;
  final Function(dynamic)? onChanged;
  final Function(dynamic)? onSaved;
  final Function(dynamic)? onFieldSubmitted;
  final Widget? label;
  final bool? filled;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextStyle? errorStyle;
  final TextStyle? hintStyle;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isDense;
  final TextStyle? style;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      style: style,
      focusNode: focusNode,
      maxLines: obscureText == true ? 1 : maxLines,
      textAlign: textAlign ?? TextAlign.start,
      onTap: onTap,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      onTapUpOutside: (event) {
        FocusScope.of(context).unfocus();
      },

      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: isDense,
        hintStyle: hintStyle,
        errorStyle: errorStyle,
        contentPadding: contentPadding,
        hintText: hintText,
        label: label,
        border: border,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        filled: filled,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefix: prefix,
        prefixText: prefixText,
        prefixStyle: prefixStyle,
      ),
    );
  }
}
