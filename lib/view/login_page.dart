import 'package:flutter/material.dart';
import 'package:telkom_bidding_app/model/list_tender_model.dart';
import 'package:telkom_bidding_app/view/list_tender_page.dart';
import 'package:telkom_bidding_app/view/register_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _NIKformKey = GlobalKey<FormState>();
  final _passwodFormKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final redTel = Color(0xffc90623);

  UserList user = null;

  @override
  void initState() {
    super.initState();
    UserList.connectToAPI("2").then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailField = Form(
        key: _NIKformKey,
        child: TextFormField(
          onEditingComplete: () {
            _NIKformKey.currentState.validate();
          },
          onTap: () {
            _NIKformKey.currentState.validate();
          },
          onChanged: (context) {
            _NIKformKey.currentState.validate();
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
                  borderRadius: BorderRadius.circular(30.0))),
          controller: emailController,
          validator: (value) {
            if (value.isEmpty) {
              return null;
            }
            return null;
          },
        ));

    final passwordField = Form(
        key: _passwodFormKey,
        child: TextFormField(
          onChanged: (context){
            _passwodFormKey.currentState.validate();
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
                  borderRadius: BorderRadius.circular(30.0))),
          controller: passwordController,
          validator: (value) {
            if (value.isEmpty) {
              return null;
            }
            return null;
          },
        ));

    final alertLogin = AlertDialog(
        title: Text("Oops"),
        content: Text('Username atau Password yang anda masukan salah'));

    Widget loginLogic() {
      if (_passwodFormKey.currentState.validate()) {
        if (emailController.text == "admin" &&
            passwordController.text == "admin") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return ListTenderPage();
          }));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return alertLogin;
              });
        }
      }
    }

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: redTel,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text("Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0)),
        onPressed: () {
          loginLogic();
        },
      ),
    );

    final register = InkWell(
      child: Text(
        "Register",
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
              style: TextStyle(fontFamily: 'Cocogoose', fontSize: 60)),
          TextSpan(
              text: 'M',
              style: TextStyle(
                  color: redTel, fontFamily: 'Cocogoose', fontSize: 60)),
          TextSpan(
              text: 'A',
              style: TextStyle(fontFamily: 'Cocogoose', fontSize: 60)),
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
                SizedBox(height: 50.0),
                emailField,
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
