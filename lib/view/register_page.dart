import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final regLabelStyle = TextStyle(fontSize: 15);
    final redTel = Color(0xffc90623);

    final emailField = Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
              labelText: "Email",
              labelStyle: regLabelStyle),
        ),
      ],
    );

    final passwordField = Column(
      children: <Widget>[
        TextField(
          obscureText: true,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
              labelText: "Password",
              labelStyle: regLabelStyle),
        ),
      ],
    );

    final repasswordField = Column(
      children: <Widget>[
        TextField(
          obscureText: true,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
              labelText: "Confirm Password",
              labelStyle: regLabelStyle),
        ),
      ],
    );

    final NIKField = Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
              labelText: "NIK",
              labelStyle: regLabelStyle),
        ),
      ],
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: redTel,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text("Register",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0)),
        onPressed: () {
          print("rge");
        },
      ),
    );

    final title = Center(
      child: Container(
        child: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'GA',
                  style: TextStyle(fontFamily: 'Cocogoose', fontSize: 40)),
              TextSpan(
                  text: 'M',
                  style: TextStyle(
                      color: redTel, fontFamily: 'Cocogoose', fontSize: 40)),
              TextSpan(
                  text: 'A',
                  style: TextStyle(fontFamily: 'Cocogoose', fontSize: 40)),
            ],
          ),
        ),
      ),
    );

    final subtitle = Text(
      "Goverment Auction Monitoring Apps",
      style: TextStyle(
          fontSize: 10.0, color: redTel, fontWeight: FontWeight.normal),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: redTel,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35.0, 0, 35, 10),
            child: Column(
              children: <Widget>[
                title,
                subtitle,
                SizedBox(height: 20.0),
                NIKField,
                SizedBox(height: 15.0),
                emailField,
                SizedBox(height: 15.0),
                passwordField,
                SizedBox(height: 15.0),
                repasswordField,
                SizedBox(height: 50.0),
                registerButton
              ],
            ),
          ),
        ),
      ),
    );
  }
}
