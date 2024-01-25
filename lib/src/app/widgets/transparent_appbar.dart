import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/appbar_title_text.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int? alpha;
  final double? elevation;
  final double? titleFontSize;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const TransparentAppBar({
    Key? key,
    required this.title,
    this.alpha,
    this.elevation,
    this.titleFontSize,
    this.actions,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent.withAlpha(alpha ?? 0),
        title: AppBarTitleText(
          title,
          fontSize: titleFontSize,
        ),
        titleSpacing: 0.0,
        elevation: elevation ?? 0,
        actions: actions);
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
