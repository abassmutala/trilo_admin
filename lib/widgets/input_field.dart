import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trilo_admin/constants/ui_constants.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.isLoading = false,
    this.autofocus = false,
    this.focusNode,
    this.onEditingComplete,
    this.controller,
    this.validator,
    this.hintText,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.maxLength,
    this.borderRadius,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
    this.obscureText = false,
    this.inputFormatters,
    this.padding,
  }) : assert(!obscureText || maxLines == 1);
  final bool isLoading;
  final bool autofocus;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? maxLength;
  final double? borderRadius;
  final bool readOnly;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: Sizes.sm),
      child: TextFormField(
        enabled: isLoading == false,
        autofocus: true,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: Sizes.xl,
            vertical: ScreenSize.width > 400 ? Sizes.base : Sizes.med,
          ),
          filled: true,
          fillColor: theme.inputDecorationTheme.fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? Sizes.base),
            borderSide: BorderSide.none,
          ),
          floatingLabelStyle:
              theme.textTheme.titleLarge!.copyWith(color: theme.hintColor),
          hintText: hintText,
          label: labelText != null
              ? Container(
                  padding: const EdgeInsets.only(bottom: 36),
                  child: Text(labelText!),
                )
              : null,
          hintStyle: const TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        inputFormatters: inputFormatters,
        style: theme.textTheme.titleLarge,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLength: maxLength,
        maxLines: maxLines,
        readOnly: readOnly,
        onChanged: onChanged,
        onTap: onTap,
        obscureText: obscureText,
      ),
    );
  }
}
