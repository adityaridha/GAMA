import 'package:flutter/material.dart';
import 'package:telkom_bidding_app/controller/api_call.dart';
import 'package:telkom_bidding_app/view/list_tender_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final textBoxEdgeInset = EdgeInsets.fromLTRB(2.0, 15.0, 2.0, 15.0);
  final gamaTextStyle = TextStyle(fontFamily: 'Cocogoose', fontSize: 40);

  var NIKController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var repeatPasswordController = TextEditingController();
  var nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final regLabelStyle = TextStyle(fontSize: 13);
    final redTel = Color(0xffc90623);

    var regsiterStatus;

    final nameField = Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            contentPadding: textBoxEdgeInset,
            labelText: "NAMA",
            labelStyle: regLabelStyle,
          ),
          controller: nameController,
        ),
      ],
    );

    final emailField = Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.email),
            contentPadding: textBoxEdgeInset,
            labelText: "EMAIL",
            labelStyle: regLabelStyle,
          ),
          controller: emailController,
        ),
      ],
    );

    final passwordField = Column(
      children: <Widget>[
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            contentPadding: textBoxEdgeInset,
            labelText: "PASSWORD",
            labelStyle: regLabelStyle,
          ),
          controller: passwordController,
        ),
      ],
    );

    final repasswordField = Column(
      children: <Widget>[
        TextField(
          obscureText: true,
          decoration: InputDecoration(
              icon: Icon(Icons.lock),
              contentPadding: textBoxEdgeInset,
              labelText: "CONFIRM PASSWORD",
              labelStyle: regLabelStyle),
          controller: repeatPasswordController,
        ),
      ],
    );

    final NIKField = Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              icon: Icon(Icons.credit_card),
              contentPadding: textBoxEdgeInset,
              labelText: "NIK",
              labelStyle: regLabelStyle),
          controller: NIKController,
        ),
      ],
    );

    final alertRegister = AlertDialog(content: Text('Registration Gagal'));

    final newAlertRegister = AlertDialog(
      title: Center(child: Text("Oops")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Pendaftaran gagal, coba cek kembali data data yang anda masukan',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0),
          Center(
            child: FlatButton(
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
              color: redTel,
              child: Center(child: Text("OK", style: TextStyle(color: Colors.white),)),
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

    void failedRegister(BuildContext context) {
      print("Register Failed");
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return newAlertRegister;
          });
    }

    ;

    final loadingRegister = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SpinKitThreeBounce(
            color: redTel,
            size: 20,
          ),
          SizedBox(height: 5,),
          Text("Loading"),
        ],
      ),

      backgroundColor: Colors.white60,
    );

    Widget registerLogic() {
      if (regsiterStatus == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return loadingRegister;
            });
      }
      ;

      APICall.register(nameController.text, NIKController.text,
              emailController.text, passwordController.text)
          .then((value) {
        setState(() {
          regsiterStatus = value.statusCode;
        });

        if (regsiterStatus == 200) {
          print("Register success");
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ListTenderPage();
          }));
        } else {
          print("already got status ${regsiterStatus}");
          failedRegister(context);
        }
      });
    }

    ;

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: redTel,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text("REGISTER",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0)),
        onPressed: () {
          registerLogic();
        },
      ),
    );

    final title = Center(
      child: Container(
        child: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(text: 'GA', style: gamaTextStyle),
              TextSpan(
                  text: 'M',
                  style: TextStyle(
                      color: redTel, fontFamily: 'Cocogoose', fontSize: 40)),
              TextSpan(text: 'A', style: gamaTextStyle),
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
            padding: const EdgeInsets.fromLTRB(40.0, 10, 40, 10),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                title,
                SizedBox(height: 10.0),
                nameField,
                SizedBox(height: 15.0),
                NIKField,
                SizedBox(height: 15.0),
                emailField,
                SizedBox(height: 15.0),
                passwordField,
                SizedBox(height: 15.0),
                repasswordField,
                SizedBox(height: 40.0),
                registerButton
              ],
            ),
          ),
        ),
      ),
    );
  }
}
