import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/custom_light_theme_widget.dart';
import 'package:flutter_alcore/src/app/widgets/right_appbar.dart';

class AppHistoryItem {
  final String version;
  final List<String> changeLogs;
  bool isExpanded = false;

  AppHistoryItem(this.version, this.changeLogs);
}

class AppHistoryPage extends StatefulWidget {
  final List<AppHistoryItem> Function() getHistoryList;
  const AppHistoryPage({Key? key, required this.getHistoryList})
      : super(key: key);

  @override
  State<AppHistoryPage> createState() => _AppHistoryPageState();
}

class _AppHistoryPageState extends State<AppHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return CustomLightThemeWidget(
      child: Scaffold(
        appBar: RightAppBar(
          title: "Riwayat Aplikasi",
          getHistoryList: widget.getHistoryList,
        ),
        body: SingleChildScrollView(
          child: ExpansionPanelList(
            elevation: 3,
            // Controlling the expansion behavior
            expansionCallback: (index, isExpanded) {
              setState(() {
                widget.getHistoryList()[index].isExpanded = isExpanded;
              });
            },
            animationDuration: const Duration(milliseconds: 600),
            children: widget
                .getHistoryList()
                .map(
                  (item) => ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (_, isExpanded) => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        child: Text(
                          item.version,
                          style: const TextStyle(fontSize: 20),
                        )),
                    body: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children:
                            item.changeLogs.map((e) => Text("- $e")).toList(),
                      ),
                    ),
                    isExpanded: item.isExpanded,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
