import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/extensions/color_manipulation.dart';

class HeaderBackgroundWidget extends StatelessWidget {
  final Widget? child;
  final double? height;
  const HeaderBackgroundWidget({super.key, this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      //constraints: const BoxConstraints.expand(),
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.lighten(70),
          ],
              stops: const [
            0.5,
            1
          ])
          // image: DecorationImage(
          //     image: AssetImage("assets/images/background.png"),
          //     fit: BoxFit.cover)
          ),
      child: child,
    );
  }
}
