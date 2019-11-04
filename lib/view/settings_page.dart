import 'package:flutter/material.dart';
import 'package:telkom_bidding_app/view/list_tender_page.dart';
import 'package:telkom_bidding_app/view/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<Widget> blacklistItem = [];
  List<String> blacklistWord = [];
  var wordController = TextEditingController();

  final instansikey = 'instansiKey';
  String initInstitusi;

  Future<String> _readFilterInstansi() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(instansikey) ?? "";
    print('read: $value');
    return value;
  }

  _saveFilterInstansi(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(instansikey, value);
    print('saved $value');
  }

  Future<List<String>> _readBlackListWord() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getStringList('blacklist') ?? [""];
    print('read: $value');
    return value;
  }

  _saveBlackListWord(List<String> words) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('blacklist', words);
    print('saved $words');
  }

  Widget templateChip(String title) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: InputChip(
        label: Text(title),
        onDeleted: () {
          setState(() {
            print(blacklistWord);
            blacklistWord.remove(title);
            _saveBlackListWord(blacklistWord);
            print(blacklistWord);
            blacklistItem.clear();

            for(var word in blacklistWord){
              blacklistItem.add(templateChip(word));
            }


          });
        },
        elevation: 1,
      ),
    );
  }


  _SettingsPageState() {
    print("Konstruktor dipanggil");
  }

  @override
  void initState() {
    super.initState();

    print("Init State Settings Page");

    _readFilterInstansi().then((value){
      setState(() {
        initInstitusi = value;
      });
    });

    _readBlackListWord().then((value){
      setState(() {
        blacklistWord = value;
        print(blacklistWord);
        for(var word in blacklistWord){
          blacklistItem.add(templateChip(word));
        }
      });
    });


  }

  // Item Generator For Sorting
  SortBy selectedMethod;
  List<SortBy> method = [SortBy("Date"), SortBy("Tender Value")];

  List<DropdownMenuItem> generateItem(List<SortBy> method) {
    List<DropdownMenuItem> items = [];
    for (var item in method) {
      items.add(DropdownMenuItem(
        child: Container(
          child: Align(
            child: Text(item.method),
            alignment: Alignment.centerLeft,
          ),
        ),
        value: item,
      ));
    }
    return items;
  }

  // Item Generator For Filtering
  FilterBy selectInstitution;
  List<FilterBy> institution = [
    FilterBy("Kabupaten Bangka Barat"),
    FilterBy("Kabupaten Bangka Selatan"),
    FilterBy("Kabupaten Bangka Tengah"),
  ];

  List<DropdownMenuItem> generateListInstitutions(List<FilterBy> institution) {
    List<DropdownMenuItem> items = [];
    for (var item in institution) {
      items.add(DropdownMenuItem(
        child: Container(
          child: Align(
            child: Text(item.institution),
            alignment: Alignment.centerLeft,
          ),
        ),
        value: item,
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final redTel = Color(0xffc90623);

    final logoutButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: redTel,
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: Text("LOGOUT",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0)),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginPage();
            }));
          }),
    );

    final saveSettings = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.amber,
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: Text("Save Settings",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0)),
          onPressed: () {
            _readFilterInstansi();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ListTenderPage();
            }));
          }),
    );

    final filterInstitutions = Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Align(
              child: Text("Filter By : "), alignment: Alignment.centerLeft),
          margin: EdgeInsets.only(bottom: 5),
        ),
        Container(
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButton(
                    elevation: 20,
                    hint: Text(initInstitusi ?? ""),
                    value: selectInstitution,
                    style: TextStyle(color: Colors.black),
                    items: generateListInstitutions(institution),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (method) {
                      setState(() {
                        selectInstitution = method;
                        var ins = selectInstitution.institution;
                        print("Institution yang dipilih $ins");
                        _saveFilterInstansi(ins);
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
              ],
            )),
      ],
    );

    final sortByOptions = Column(children: <Widget>[
      Container(
          padding: EdgeInsets.only(left: 10),
          child:
              Align(child: Text("Sort By : "), alignment: Alignment.centerLeft),
          margin: EdgeInsets.only(bottom: 5)),
      Container(
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey)),
          child: Row(children: <Widget>[
            SizedBox(width: 10),
            Expanded(
              child: DropdownButton(
                elevation: 20,
                value: selectedMethod,
                style: TextStyle(color: Colors.black),
                items: generateItem(method),
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                onChanged: (value) {
                  setState(() {
                    selectedMethod = value;
                    var meth = selectedMethod.method;
                    print("Method yang dipilih $meth");

                  });
                },
              ),
            ),
            SizedBox(width: 10)
          ])),
    ]);

    final blackListInput = TextFormField(
      controller: wordController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          prefixIcon: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Icon(
                  Icons.security,
                  size: 22.0,
                ),
              )),
          hintText: "Add Black List Keyword",
          hintStyle: TextStyle(fontSize: 13),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {
        setState(() {
          blacklistWord.add(value);
          blacklistItem.add(templateChip(value));
          wordController.clear();
          _saveBlackListWord(blacklistWord);
        });

      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: redTel,
        titleSpacing: 20,
        title: Text("Settings"),
      ),
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: <Widget>[
                filterInstitutions,
                SizedBox(height: 15),
                sortByOptions,
                SizedBox(height: 15),
                blackListInput,
                SizedBox(height: 10),
                Wrap(children: blacklistItem),
                SizedBox(height: 20),
                saveSettings,
                SizedBox(height: 10),
                logoutButton
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SortBy {
  String method;

  SortBy(this.method);
}

class FilterBy {
  String institution;

  FilterBy(this.institution);
}
