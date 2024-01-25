import 'package:flutter/material.dart';

class PaddedText extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  const PaddedText(this.text, {super.key, this.padding, this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
