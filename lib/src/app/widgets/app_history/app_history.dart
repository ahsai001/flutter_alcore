import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/custom_light_theme_widget.dart';
import 'package:flutter_alcore/src/app/widgets/right_appbar.dart';

class AppHistoryPage extends StatefulWidget {
  const AppHistoryPage({Key? key}) : super(key: key);

  @override
  State<AppHistoryPage> createState() => _AppHistoryPageState();
}

class _AppHistoryPageState extends State<AppHistoryPage> {
  final List<Map<String, dynamic>> _items = [
    {
      "version": "1.0.0",
      "changelog": ["versi awal"],
      "isExpanded": true
    }
  ];
  @override
  Widget build(BuildContext context) {
    return CustomLightThemeWidget(
      child: Scaffold(
        appBar: const RightAppBar(
          title: "Riwayat Aplikasi",
        ),
        body: SingleChildScrollView(
          child: ExpansionPanelList(
            elevation: 3,
            // Controlling the expansion behavior
            expansionCallback: (index, isExpanded) {
              setState(() {
                _items[index]['isExpanded'] = !isExpanded;
              });
            },
            animationDuration: const Duration(milliseconds: 600),
            children: _items
                .map(
                  (item) => ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (_, isExpanded) => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        child: Text(
                          item['version'],
                          style: const TextStyle(fontSize: 20),
                        )),
                    body: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: (item['changelog'] as List<String>)
                            .map((e) => Text("- $e"))
                            .toList(),
                      ),
                    ),
                    isExpanded: item['isExpanded'],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
