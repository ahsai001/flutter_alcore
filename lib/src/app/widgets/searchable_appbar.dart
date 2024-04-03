import 'package:flutter/material.dart';

import 'appbar_title_text.dart';

class SearchableAppBar extends StatefulWidget implements PreferredSizeWidget {
  final void Function(String newKeyword)? onSubmitted;
  final void Function(String newKeyword)? onChanged;
  final void Function()? onClosed;
  final String? searchHintText;
  final String? appBarTitleText;
  final Widget? appBarTitleWidget;
  final PreferredSizeWidget? bottom;
  const SearchableAppBar(
      {Key? key,
      this.bottom,
      this.onSubmitted,
      this.onChanged,
      this.onClosed,
      this.searchHintText,
      this.appBarTitleText,
      this.appBarTitleWidget})
      : super(key: key);

  @override
  State<SearchableAppBar> createState() => _SearchableAppBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}

class _SearchableAppBarState extends State<SearchableAppBar> {
  bool showSearch = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: showSearch
          ? TextField(
              autofocus: true,
              onSubmitted: widget.onSubmitted,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                  filled: true,
                  hintText: widget.searchHintText,
                  fillColor: Colors.white),
            )
          : (widget.appBarTitleWidget ??
              AppBarTitleText(widget.appBarTitleText ?? "")),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                showSearch = !showSearch;
                if (!showSearch) {
                  widget.onClosed?.call();
                }
              });
            },
            icon: Icon(showSearch ? Icons.close : Icons.search))
      ],
      bottom: widget.bottom,
    );
  }
}
