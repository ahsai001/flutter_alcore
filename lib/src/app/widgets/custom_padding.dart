import 'package:flutter/material.dart';

class CustomPadding extends StatelessWidget {
  final Widget child;
  const CustomPadding({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}
