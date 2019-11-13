import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:telkom_bidding_app/controller/api_call.dart';
import 'package:telkom_bidding_app/view/list_tender_page.dart';

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

  final nameFormKey = GlobalKey<FormState>();
  final NIKFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final confirmPasswordFormKey = GlobalKey<FormState>();
  final allKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final regLabelStyle = TextStyle(fontSize: 13);
    final redTel = Color(0xffc90623);

    var regsiterStatus;
    Response registerReturn;

    final nameField = Form(
        key: nameFormKey,
        child: TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            contentPadding: textBoxEdgeInset,
            labelText: "NAMA",
            labelStyle: regLabelStyle,
          ),
          controller: nameController,
          onChanged: (value) {
            nameFormKey.currentState.validate();
          },
          validator: (value) {
            if (value.isEmpty) {
              return "Nama tidak boleh kosong";
            } else
              return null;
          },
        ));

    final emailField = Form(
        key: emailFormKey,
        child: TextFormField(
          onChanged: (value) {
            emailFormKey.currentState.validate();
          },
          decoration: InputDecoration(
            icon: Icon(Icons.email),
            contentPadding: textBoxEdgeInset,
            labelText: "EMAIL",
            labelStyle: regLabelStyle,
          ),
          controller: emailController,
          validator: (value) {
            if (value.isNotEmpty) {
              if (!value.contains("@")) {
                return "Format email tidak valid";
              } else
                return null;
            } else if (value.isEmpty) {
              return "Email tidak boleh kosong";
            } else
              return null;
          },
        ));

    final passwordField = Form(
        key: passwordFormKey,
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            contentPadding: textBoxEdgeInset,
            labelText: "PASSWORD",
            labelStyle: regLabelStyle,
          ),
          controller: passwordController,
          onChanged: (value){
            passwordFormKey.currentState.validate();
          },
          validator: (value) {
            if(value.isEmpty){
              return "password tidak boleh kosong";
            } else
              return null;
          },
        ));

    final repasswordField = Form(
        key: confirmPasswordFormKey,
        child: TextFormField(
          obscureText: true,
          onChanged: (value) {
            confirmPasswordFormKey.currentState.validate();
          },
          decoration: InputDecoration(
              icon: Icon(Icons.lock),
              contentPadding: textBoxEdgeInset,
              labelText: "CONFIRM PASSWORD",
              labelStyle: regLabelStyle,
              errorMaxLines: 2),
          controller: repeatPasswordController,
          validator: (value) {
            if (value.isEmpty) {
              return "confirm password tidak boleh kosong";
            } else if (value != passwordController.text) {
              return "confirm password berbeda dengan password";
            } else
              return null;
          },
        ));

    final NIKField = Form(
        key: NIKFormKey,
        child: TextFormField(
          decoration: InputDecoration(
              icon: Icon(Icons.credit_card),
              contentPadding: textBoxEdgeInset,
              labelText: "NIK",
              labelStyle: regLabelStyle),
          controller: NIKController,
          onChanged: (value){
            NIKFormKey.currentState.validate();
          },
          validator: (value) {
            if (value.isEmpty) {
              return "NIK tidak boleh kosong";
            } else
              return null;
          },
        ));

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

    void failedRegister(BuildContext context) {
      print("Register Failed");
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return newAlertRegister;
          });
    }

    final loadingRegister = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SpinKitThreeBounce(
            color: redTel,
            size: 20,
          ),
          SizedBox(
            height: 5,
          ),
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
          print("ini hasil register ${value.body} ${value.statusCode}");
          regsiterStatus = value.statusCode;
          registerReturn = value;
        });

        if (regsiterStatus == 200) {
          print("Register success");
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ListTenderPage();
          }));
        } else {
          failedRegister(context);
        }
      });
    }

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
          nameFormKey.currentState.validate();
          NIKFormKey.currentState.validate();
          emailFormKey.currentState.validate();
          confirmPasswordFormKey.currentState.validate();
          passwordFormKey.currentState.validate();
          if (nameFormKey.currentState.validate() &&
              confirmPasswordFormKey.currentState.validate() &&
              NIKFormKey.currentState.validate() &&
              passwordFormKey.currentState.validate() &&
              emailFormKey.currentState.validate()) {
            registerLogic();
          }
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
      body: Form(
        key: allKey,
        child: Center(
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
      ),
    );
  }
}
