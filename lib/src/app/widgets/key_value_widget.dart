import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class KeyValueWidget extends StatelessWidget {
  final String keyText;
  final String valueText;
  final double width;
  final bool valueIsHtml;
  final String? url;
  const KeyValueWidget(this.keyText, this.valueText,
      {super.key, this.width = 70, this.valueIsHtml = false, this.url});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: width,
          child: Text(keyText),
        ),
        const Text(" : "),
        Expanded(
          child: valueIsHtml
              ? Html(data: valueText)
              : Text(
                  valueText,
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
