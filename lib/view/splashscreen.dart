
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:telkom_bidding_app/view/login_page.dart';


class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}



class _SplashScreenPageState extends State<SplashScreenPage> {


  @override
  Widget build(BuildContext context) {
    final redTel = Color(0xffc90623);

    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new LoginPage(),
        title: Text('GAMA',
          style:TextStyle(fontFamily: 'Cocogoose', fontSize: 60, color: Colors.white),),
        backgroundColor: redTel,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: ()=>print("Flutter Egypt"),
        loaderColor: redTel
    );
  }
  }

