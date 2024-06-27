import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/appbar_title_text.dart';
import 'package:flutter_alcore/src/app/widgets/custom_light_theme_widget.dart';

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
  List<AppHistoryItem> historyList = [];
  @override
  void initState() {
    historyList = widget.getHistoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLightThemeWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarTitleText("Riwayat Aplikasi"),
        ),
        body: SingleChildScrollView(
          child: ExpansionPanelList(
            elevation: 3,
            // Controlling the expansion behavior
            expansionCallback: (index, isExpanded) {
              setState(() {
                historyList[index].isExpanded = isExpanded;
              });
            },
            animationDuration: const Duration(milliseconds: 600),
            children: historyList
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
