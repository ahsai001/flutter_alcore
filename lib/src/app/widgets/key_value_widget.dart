import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KeyValueWidget extends StatelessWidget {
  final String keyLabel;
  final String valueLabel;
  final String? url;
  const KeyValueWidget(
      {Key? key, required this.keyLabel, required this.valueLabel, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 120,
          child: Text(keyLabel),
        ),
        const Text(" : "),
        Expanded(
          child: Text(
            valueLabel,
            overflow: TextOverflow.visible,
          ),
        ),
        if (url != null && url!.isNotEmpty)
          IconButton(
              onPressed: () async {
                var uri = Uri.parse(url!);
                if (!await launchUrl(uri,
                    mode: LaunchMode.externalApplication)) {
                  throw 'Could not launch $uri';
                }
              },
              icon: const Icon(Icons.download))
      ],
    );
  }
}
