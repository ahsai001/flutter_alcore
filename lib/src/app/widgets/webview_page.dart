import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/custom_padding.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatelessWidget {
  final String? url;
  final String? html;
  const WebviewPage({Key? key, this.url, this.html}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPadding(
      child: SingleChildScrollView(
        child: url != null
            ? WebViewWidget(
                controller: WebViewController()..loadRequest(Uri.parse(url!)),
              )
            : Html(
                data: html,
                shrinkWrap: true,
              ),
      ),
    );
  }
}
