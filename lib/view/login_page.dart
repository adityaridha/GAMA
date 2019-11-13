import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_bidding_app/controller/api_call.dart';
import 'package:telkom_bidding_app/model/list_tender_model.dart';
import 'package:telkom_bidding_app/utility/local_data.dart';
import 'package:telkom_bidding_app/view/list_tender_page.dart';
import 'package:telkom_bidding_app/view/register_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final NIKFormKey = GlobalKey<FormState>();
  final passwodFormKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final redTel = Color(0xffc90623);

  List<String> whitelistWord = ["jaringan", "server"];

  LocalData data = new LocalData();

  @override
  void initState() {
    super.initState();

    data.saveWhiteListWord(whitelistWord);
  }

  TenderList user = null;

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool("login") ?? false;
    return value;
  }

  setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", value);
    print('saved $value');
  }

  @override
  Widget build(BuildContext context) {
    var status;

    final nikField = Form(
        key: NIKFormKey,
        child: TextFormField(
          onChanged: (context) {
            NIKFormKey.currentState.validate();
          },
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(35.0, 15.0, 20.0, 15.0),
              prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Icon(
                    Icons.person,
                    size: 20.0,
                  )),
              hintText: "Type Your NIK",
              hintStyle: TextStyle(fontSize: 13),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0))),
          controller: emailController,
          validator: (value) {
            if (value.isEmpty) {
              return "NIK tidak boleh kosong";
            }
            return null;
          },
        ));

    final passwordField = Form(
        key: passwodFormKey,
        child: TextFormField(
          onChanged: (context) {
            passwodFormKey.currentState.validate();
          },
          obscureText: true,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 15.0),
              prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Icon(
                    Icons.lock,
                    size: 20.0,
                  )),
              hintText: "Type Your Password",
              hintStyle: TextStyle(fontSize: 13),
              errorStyle: TextStyle(),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0))),
          controller: passwordController,
          validator: (value) {
            if (value.isEmpty) {
              return "Password tidak boleh kosong";
            }
            return null;
          },
        ));

    final gangguanServer = AlertDialog(
      title: Center(child: Text("Oops")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Sepertinya ada gangguan server. Tetap tenang tetap semangat !',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0),
          Center(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              color: redTel,
              child: Center(
                  child: Text(
                "OK",
                style: TextStyle(color: Colors.white),
              )),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
    );

    final alertLogin = AlertDialog(
      title: Center(child: Text("Oops")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Username atau Password yang anda masukan salah',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0),
          Center(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              color: redTel,
              child: Center(
                  child: Text(
                "OK",
                style: TextStyle(color: Colors.white),
              )),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
    );

    final loadingLogin = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          SpinKitThreeBounce(
            color: redTel,
            size: 20,
          ),
          SizedBox(
            height: 8,
          ),
          Text("Tunggu sebentar yaa"),
          SizedBox(
            height: 8,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
    );

    void failedLogin(BuildContext context) {
      print("Failed Login");
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertLogin;
          });
    }

    Widget loginLogic() {
      if (status == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return loadingLogin;
            });
      }
      ;

      if (passwodFormKey.currentState.validate()) {
        APICall.login(emailController.text, passwordController.text)
            .then((value) {
          setState(() {
            status = value.statusCode;
          });

          if (status == 200) {
            setLoggedIn(true);
            print("Success Login");
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return ListTenderPage();
            }));
          } else if (status == 502 || status == 500) {
            print("Gangguan Server");
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return gangguanServer;
                });
          } else {
            failedLogin(context);
          }
        });
      } else {
        print("Usernamee and password Can't be empty");
      }
    }

    ;

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: redTel,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text("LOGIN",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17.0)),
        onPressed: () {
          NIKFormKey.currentState.validate();
          passwodFormKey.currentState.validate();

          if (NIKFormKey.currentState.validate() &&
              passwodFormKey.currentState.validate()) {
            loginLogic();
          }
        },
      ),
    );

    final register = InkWell(
      child: Text(
        "REGISTER",
        style: TextStyle(color: Colors.grey),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RegisterPage();
        }));
      },
    );

    final title = Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: 'GA',
              style: TextStyle(fontFamily: 'Cocogoose', fontSize: 70)),
          TextSpan(
              text: 'M',
              style: TextStyle(
                  color: redTel, fontFamily: 'Cocogoose', fontSize: 70)),
          TextSpan(
              text: 'A',
              style: TextStyle(fontFamily: 'Cocogoose', fontSize: 70)),
        ],
      ),
    );

    final subtitle = Text(
      "Goverment Auction Monitoring Apps",
      style: TextStyle(
          fontSize: 15.0, color: redTel, fontWeight: FontWeight.normal),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                title,
                SizedBox(height: 5.0),
                subtitle,
                SizedBox(height: 90.0),
                nikField,
                SizedBox(height: 15.0),
                passwordField,
                SizedBox(height: 30.0),
                loginButton,
                SizedBox(height: 15.0),
                register,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
