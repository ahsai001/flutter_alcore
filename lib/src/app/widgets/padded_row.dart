import 'package:flutter/material.dart';

class PaddedRow extends StatelessWidget {
  final List<Widget> children;
  const PaddedRow({super.key, this.children = const []});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        children: children,
      ),
    );
  }
}
