import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final String suffixText;
  final bool obscureText;
  final FocusNode focusNode;
  final TextCapitalization textCapitalization;
  final void Function(String) onChanged;
  final void Function(String) onFieldSubmitted;
  final void Function() suffixIconOnTap;
  final TextEditingController controller;
  final String Function(String) validator;
  final TextInputType keyboardType;
  final Iterable<String> autofillHints;
  final List<TextInputFormatter> inputFormatters;
  final bool readOnly;
  final String initialValue;

  const TextFieldWidget({
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.suffixText,
    this.obscureText = false,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onFieldSubmitted,
    this.suffixIconOnTap,
    this.controller,
    this.validator,
    this.keyboardType,
    this.autofillHints,
    this.inputFormatters,
    this.readOnly,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final _controller = (controller == null && initialValue != null)
        ? TextEditingController(text: initialValue)
        : controller;

    final theme = Theme.of(context);

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _controller,
      style: TextStyle(color: theme.primaryColor, fontSize: 14.0),
      cursorColor: theme.primaryColor,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: hintText,
        suffixText: suffixText,
        prefixIcon: prefixIconData == null
            ? null
            : Icon(
                prefixIconData,
                size: 18,
                color: theme.primaryColor,
              ),
        suffixIcon: suffixIconData == null
            ? null
            : GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: suffixIconOnTap,
                child: Icon(
                  suffixIconData,
                  size: 18,
                  color: theme.primaryColor,
                ),
              ),
        labelStyle: TextStyle(color: theme.primaryColor),
      ),
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      enableSuggestions: true,
      inputFormatters: inputFormatters,
      readOnly: readOnly != null ? readOnly : false,
    );
  }
}
