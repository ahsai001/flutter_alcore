import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/app_history/app_history.dart';
import 'package:flutter_alcore/src/utils/widget_util.dart';

class CenteredAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight = 70;
  final String? logoAssetPath;
  final List<AppHistoryItem> Function() getHistoryList;
  const CenteredAppBar(
      {Key? key, this.logoAssetPath, required this.getHistoryList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      title: GestureDetector(
        onTap: () async {
          showAboutInfo(context, logoAssetPath!, getHistoryList);
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
