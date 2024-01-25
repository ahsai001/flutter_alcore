import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/app_history/app_history.dart';
import 'package:flutter_alcore/src/utils/widget_util.dart';

class RightAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backExist;
  final PreferredSizeWidget? bottom;
  final String? logoAssetPath;
  final List<AppHistoryItem> Function() getHistoryList;
  const RightAppBar(
      {Key? key,
      required this.title,
      this.backExist = true,
      this.bottom,
      this.logoAssetPath,
      required this.getHistoryList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
      leading: backExist
          ? IconButton(
              onPressed: () {
                popBack(context);
              },
              icon: const Icon(Icons.arrow_back))
          : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!backExist) const SpaceWidth(),
          Expanded(
            child: Text(
              title,
              softWrap: true,
              style: const TextStyle(
                  fontSize: 18,
                  overflow: TextOverflow.visible,
                  height: 1.2,
                  fontWeight: FontWeight.bold),
            ),
          ),
          if (logoAssetPath != null)
            GestureDetector(
              onTap: () async {
                showAboutInfo(context, logoAssetPath!, getHistoryList);
              },
              child: SizedBox(
                height: kToolbarHeight - 20,
                child: Image.asset(
                  logoAssetPath!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          const SpaceWidth()
        ],
      ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
