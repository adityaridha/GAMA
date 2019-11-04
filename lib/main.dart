import 'package:flutter/material.dart';
import 'package:telkom_bidding_app/view/list_tender_page.dart';
import 'package:telkom_bidding_app/view/login_page.dart';
import 'package:telkom_bidding_app/view/search_page.dart';
import 'package:telkom_bidding_app/view/settings_page.dart';
import 'package:telkom_bidding_app/view/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telkom',
      home: SplashScreenPage(title: 'Telkom Projects Bidding'),
    );
  }
}


