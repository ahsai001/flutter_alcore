import 'package:flutter/material.dart';

class CustomEmptyWidget extends StatelessWidget {
  final String? emptyMessage;
  final Widget? emptyIcon;
  final double? height;
  const CustomEmptyWidget(
      {Key? key, this.emptyMessage, this.emptyIcon, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            emptyIcon ??
                const Icon(
                  Icons.info,
                  size: 40,
                ),
            Text(
              emptyMessage ?? "Maaf data belum tersedia",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
