import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/utils/widget_util.dart';

class CustomErrorWidget extends StatelessWidget {
  final void Function()? onAction;
  final String? errorMessage;
  final String? actionButtonText;

  final double? height;
  const CustomErrorWidget(
      {Key? key,
      this.onAction,
      this.errorMessage,
      this.actionButtonText,
      this.height})
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
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 40,
            ),
            const SpaceHeight(),
            Text(
              errorMessage ?? "Maaf ada masalah...",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.error, fontSize: 14),
            ),
            const SpaceHeight(
              height: 15,
            ),
            if (onAction != null)
              ElevatedButton(
                  onPressed: onAction,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100))),
                  child: Text(actionButtonText ?? "Muat ulang"))
          ],
        ),
      ),
    );
  }
}
