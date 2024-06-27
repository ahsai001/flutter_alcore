import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/extensions/custom_extension.dart';

class RoundedTextField extends StatefulWidget {
  final Color? backgroundColor;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final bool isPassword;
  final bool isReadOnly;
  final bool autoFocus;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const RoundedTextField(
      {super.key,
      this.backgroundColor,
      this.hintText,
      this.labelText,
      this.controller,
      this.validator,
      this.onSaved,
      this.isPassword = false,
      this.isReadOnly = false,
      this.autoFocus = false,
      this.textInputType,
      this.textInputAction,
      this.icon,
      this.prefixIcon,
      this.suffixIcon});

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    var labelStyle = TextStyle(color: context.colorScheme.primary);
    return TextFormField(
        controller: widget.controller,
        validator: (value) {
          if (value?.isEmpty ?? false) {
            return "Tidak boleh kosong";
          }
          return widget.validator?.call(value);
        },
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        onSaved: widget.onSaved,
        readOnly: widget.isReadOnly,
        autofocus: widget.autoFocus,
        obscureText: widget.isPassword && obscureText,
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: labelStyle,
            labelText: widget.labelText,
            labelStyle: labelStyle,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(100.0), // Set the desired border radius
            ),
            filled: widget.backgroundColor != null ? true : false,
            fillColor: widget.backgroundColor, // Set the background color
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            icon: widget.icon,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon != null || widget.isPassword
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.suffixIcon != null) widget.suffixIcon!,
                      if (widget.isPassword)
                        IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(obscureText
                                ? Icons.visibility_off
                                : Icons.visibility))
                    ],
                  )
                : null));
  }
}
