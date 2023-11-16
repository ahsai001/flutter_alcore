import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  final ValueChanged<bool?> onChanged;
  final bool value;
  final EdgeInsets padding;
  final String label;
  final Color? color;

  const CheckBox(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.label,
      required this.padding,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Checkbox(
              key: key,
              value: value,
              onChanged: onChanged,
              side: color != null
                  ? MaterialStateBorderSide.resolveWith(
                      (_) => BorderSide(width: 1, color: color!))
                  : null,
              checkColor: color,
            ),
            Text(
              label,
              style: color != null ? TextStyle(color: color) : null,
            ),
          ],
        ),
      ),
    );
  }
}
