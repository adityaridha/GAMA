import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:telkom_bidding_app/model/list_lpse_model.dart';
import 'package:telkom_bidding_app/pusher_service.dart';
import 'package:telkom_bidding_app/view/list_tender_page.dart';
import 'package:telkom_bidding_app/view/login_page.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  FirebaseMessaging _messaging = FirebaseMessaging();
  bool status = false;

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool("login") ?? false;
    return value;
  }

  Widget checkLogin() {
    isLoggedIn().then((value) {
      setState(() {
        status = value;
      });
    });

    if (status == true) {
      return ListTenderPage();
    } else {
      return LoginPage();
    }
  }

  PusherService pusherService = PusherService();

  @override
  void initState() {

//    pusherService = PusherService();
//    pusherService.firePusher('my-channel', 'my-event');

    super.initState();
    _messaging.getToken().then((token) {
      print(token);
    });

    _messaging.subscribeToTopic("tender");

  }

  @override
  Widget build(BuildContext context) {
    final redTel = Color(0xffc90623);

    return SplashScreen(
        seconds: 4,
        navigateAfterSeconds: this.checkLogin(),
        title: Text(
          'GAMA',
          style: TextStyle(
              fontFamily: 'Cocogoose', fontSize: 60, color: Colors.white),
        ),
        backgroundColor: redTel,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: redTel);
  }
}
