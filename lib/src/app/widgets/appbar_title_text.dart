import 'package:flutter/material.dart';

class AppBarTitleText extends StatelessWidget {
  final String title;
  const AppBarTitleText(
    this.title, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.visible,
      softWrap: true,
      style: const TextStyle(height: 1.2),
    );
  }
}
