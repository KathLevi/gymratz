import 'package:flutter/material.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebsiteViewer extends StatefulWidget {
  WebsiteViewer({Key key, this.url}) : super(key: key);

  final String url;

  @override
  State<StatefulWidget> createState() {
    return WebsiteViewerState();
  }
}

class WebsiteViewerState extends State<WebsiteViewer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context: context, profile: false),
        body: SafeArea(
            child: WebView(
          initialUrl: 'https://google.com',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController _webviewController) {
            _webviewController.loadUrl(widget.url);
          },
        )));
  }
}
