import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/color_loader.dart';

class CustomLoadingWidget extends StatelessWidget {
  final String? loadingMessage;
  final bool showLoadingMessage;
  final Color? textColor;
  final double radius;
  final double? width;
  final double? height;
  final bool isSquare;
  const CustomLoadingWidget(
      {Key? key,
      this.loadingMessage,
      this.textColor,
      this.radius = 30,
      this.width,
      this.height,
      this.showLoadingMessage = true,
      this.isSquare = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var calculatedHeight = height ?? 4.3 * radius;
    var calculatedWidth = width;
    if (isSquare) {
      calculatedWidth = calculatedHeight;
    }
    return Container(
      height: calculatedHeight,
      width: calculatedWidth,
      alignment: Alignment.center,
      //color: Colors.amber,
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ColorLoader(
            radius: radius,
          ),
          if (showLoadingMessage)
            Text(
              loadingMessage ?? "Harap tunggu...",
              style: textColor != null ? TextStyle(color: textColor) : null,
            )
        ],
      ),
    );
  }
}
