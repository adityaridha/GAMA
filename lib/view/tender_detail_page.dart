import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TenderDetailPage extends StatefulWidget {
  final String url;
  TenderDetailPage({Key key, this.url}) : super(key: key);

  @override
  _TenderDetailPageState createState() => _TenderDetailPageState();
}



class _TenderDetailPageState extends State<TenderDetailPage> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    final regLabelStyle = TextStyle(fontSize: 15);
    final redTel = Color(0xffc90623);


    final String url = widget.url;
    print(url);

    return Scaffold(
      appBar: AppBar(
        title: Text("Tender Detail"),
        backgroundColor: redTel,
      ),
      body: WebView(
        initialUrl: url,
        onWebViewCreated: (WebViewController webViewController){
          _controller.complete(webViewController);
        }

      ),


    );
  }
}
