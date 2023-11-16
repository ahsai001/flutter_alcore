import 'package:flutter/material.dart';

class AppBarTitleText extends StatelessWidget {
  final String title;
  final double? fontSize;
  const AppBarTitleText(
    this.title, {
    super.key,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      softWrap: true,
      style: TextStyle(fontSize: fontSize, height: 1.2),
    );
  }
}
