import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/transparent_appbar.dart';

class TransparentScaffold extends StatelessWidget {
  final String pageTitle;
  final Widget child;
  final int? alpha;
  final double? elevation;
  final double? titleFontSize;
  final List<Widget>? actions;
  const TransparentScaffold({
    super.key,
    required this.pageTitle,
    required this.child,
    this.alpha,
    this.elevation = 1,
    this.actions,
    this.titleFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: TransparentAppBar(
          title: pageTitle,
          alpha: alpha,
          elevation: elevation,
          actions: actions,
          titleFontSize: titleFontSize,
        ),
        body: child);
  }
}
