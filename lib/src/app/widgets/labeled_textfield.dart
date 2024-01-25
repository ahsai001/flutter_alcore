import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  const LabeledTextField(
      {super.key,
      required this.label,
      this.controller,
      this.readOnly = false,
      this.onTap,
      this.validator,
      this.onSaved,
      this.onChanged,
      this.initialValue,
      this.maxLines,
      this.decoration,
      this.inputFormatters,
      this.textInputAction,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          //style: const TextStyle(fontFeatures: [FontFeature.superscripts()]),
        ),
        TextFormField(
          initialValue: initialValue,
          readOnly: readOnly,
          controller: controller,
          onTap: onTap,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
          maxLines: maxLines,
          decoration: decoration,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          //decoration: InputDecoration(labelText: label),
        )
      ],
    );
  }
}
