import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/utils/widget_util.dart';

class CenteredAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight = 70;
  final String? logoAssetPath;
  const CenteredAppBar({Key? key, this.logoAssetPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      title: GestureDetector(
        onTap: () async {
          showAboutInfo(context, logoAssetPath!);
        },
        child: SizedBox(
          height: toolbarHeight - 10,
          child: Image.asset(
            logoAssetPath!,
            fit: BoxFit.contain,
          ),
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
