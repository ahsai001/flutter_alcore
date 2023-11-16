import 'package:flutter/material.dart';

class AlignedText extends StatelessWidget {
  final String text;
  final AlignmentGeometry? alignment;
  final TextStyle? style;
  const AlignedText(this.text, {Key? key, this.style, this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.centerRight,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
