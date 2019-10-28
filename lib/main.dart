import 'package:flutter/material.dart';
import 'package:telkom_bidding_app/list_tender_page.dart';
import 'package:telkom_bidding_app/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telkom',
      home: LoginPage(title: 'Telkom Projects Bidding'),
    );
  }
}


