import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TenderDetailPage extends StatefulWidget {
  TenderDetailPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TenderDetailPageState createState() => _TenderDetailPageState();
}



class _TenderDetailPageState extends State<TenderDetailPage> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    final regLabelStyle = TextStyle(fontSize: 15);
    final redTel = Color(0xffc90623);



    return Scaffold(
      appBar: AppBar(
        title: Text("Tender Detail"),
        backgroundColor: redTel,
      ),
      body: WebView(
        initialUrl: "http://lpse.bangkatengahkab.go.id/eproc4/lelang/2571139/pengumumanlelang",
        onWebViewCreated: (WebViewController webViewController){
          _controller.complete(webViewController);
        }

      ),


    );
  }
}
