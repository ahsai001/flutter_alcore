import 'package:flutter/material.dart';

class RoundedElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Widget child;

  const RoundedElevatedButton(
      {super.key,
      this.onPressed,
      required this.child,
      this.foregroundColor,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(1000)))),
        onPressed: onPressed,
        child: child);
  }
}
