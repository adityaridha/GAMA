import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_bidding_app/view/list_tender_page.dart';
import 'package:telkom_bidding_app/view/login_page.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  _SettingsPageState() {
    print("Konstruktor dipanggil");
  }

  final redTel = Color(0xffc90623);

//  Blacklist word initialization section

  List<Widget> blacklistItem = [];
  List<String> blacklistWord = [];
  var blackWordController = TextEditingController();

  Future<List<String>> _readBlackListWord() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('blacklist') ?? [];
  }

  _saveBlackListWord(List<String> words) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('blacklist', words);
  }

//  Blacklist word End Section

//  Whitelist word initialization section

  List<Widget> whitelistItem = [];
  List<String> whitelistWord = [
    "jaringan",
    "server",
    "network",
    "komputer",
    "perangkat",
    "server",
    "fiber",
    "optik",
    "aplikasi",
    "internet",
    "datacenter"
  ];
  var whiteWordController = TextEditingController();

  Future<List<String>> _readWhiteListWord() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('whitelist') ?? [];
  }

  _saveWhiteListWord(List<String> words) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('whitelist', words);
  }

//  Blacklist word End Section

  String initInstitusi;
  String initSort;

  Future<String> _readFilterInstansi() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('instansiKey') ?? "";
    print('read: $value');
    return value;
  }

  _saveFilterInstansi(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('instansiKey', value);
    print('saved $value');
  }

  Future<bool> _readSorting() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool("sorting") ?? false;
    print('read: $value');
    return value;
  }

  _saveSorting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("sorting", value);
    print('saved $value');
  }

  setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", value);
    print('saved $value');
  }

  Widget templateChip(String title) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: InputChip(
        label: Text(title),
        onDeleted: () {
          setState(() {
            blacklistWord.remove(title);
            _saveBlackListWord(blacklistWord);
            blacklistItem.clear();

            for (var word in blacklistWord) {
              blacklistItem.add(templateChip(word));
            }
          });
        },
        elevation: 1,
      ),
    );
  }

  Widget whiteTemplateChip(String title) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: InputChip(
        label: Text(title),
        onDeleted: () {
          setState(() {
            whitelistWord.remove(title);
            _saveWhiteListWord(whitelistWord);
            whitelistItem.clear();

            for (var word in whitelistWord) {
              whitelistItem.add(whiteTemplateChip(word));
            }
          });
        },
        elevation: 1,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _readFilterInstansi().then((value) {
      setState(() {
        initInstitusi = value;
      });
    });

    _readSorting().then((value) {
      setState(() {
        if (value == true) {
          initSort = "Tender Value";
        } else {
          initSort = "Date";
        }
      });
    });

    _readBlackListWord().then((value) {
      setState(() {
        blacklistWord = value;
        print("ini blacklist : $blacklistWord");
        for (var word in blacklistWord) {
          blacklistItem.add(templateChip(word));
        }
      });
    });

    _readWhiteListWord().then((value) {
      setState(() {
        whitelistWord = value;
        print("ini whitelist : $whitelistWord");
        for (var word in whitelistWord) {
          whitelistItem.add(whiteTemplateChip(word));
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
    FilterBy("None"),
    FilterBy("Kabupaten Bangka Barat"),
    FilterBy("Kabupaten Bangka Selatan"),
    FilterBy("Kabupaten Bangka Tengah"),
    FilterBy("Kepulauan Bangka Belitung"),
    FilterBy("Kabupaten Belitung"),
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
            setLoggedIn(false);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return ListTenderPage();
            }));
          }),
    );

    final filterInstitutions = Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Align(
              child: Text("Filter by : "), alignment: Alignment.centerLeft),
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
                  hint: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(initInstitusi ?? "",
                          style: TextStyle(color: Colors.black))),
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
                )),
                SizedBox(width: 10),
              ],
            )),
      ],
    );

    final sortByOptions = Column(children: <Widget>[
      Container(
          padding: EdgeInsets.only(left: 10),
          child:
              Align(child: Text("Sort by : "), alignment: Alignment.centerLeft),
          margin: EdgeInsets.only(bottom: 5)),
      Container(
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey)),
          child: Row(children: <Widget>[
            SizedBox(width: 10),
            Expanded(
              child: DropdownButton(
                hint: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(initSort ?? "",
                      style: TextStyle(color: Colors.black)),
                ),
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
                    if (meth == "Tender Value") {
                      _saveSorting(true);
                    } else {
                      _saveSorting(false);
                    }
                  });
                },
              ),
            ),
            SizedBox(width: 10)
          ])),
    ]);

    final blackListInput = TextFormField(
      controller: blackWordController,
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
          hintText: "Add blacklist keyword",
          hintStyle: TextStyle(fontSize: 13),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {
        if (value != "") {
          setState(() {
            blacklistWord.add(value);
            blacklistItem.add(templateChip(value));
            blackWordController.clear();
            _saveBlackListWord(blacklistWord);
          });
        }
      },
    );

    final whiteListInput = TextFormField(
      controller: whiteWordController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          prefixIcon: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Icon(
                  Icons.spellcheck,
                  size: 22.0,
                ),
              )),
          hintText: "Add whitelits keyword",
          hintStyle: TextStyle(fontSize: 13),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {
        if (value != "") {
          setState(() {
            whitelistWord.add(value);
            whitelistItem.add(whiteTemplateChip(value));
            whiteWordController.clear();
            _saveWhiteListWord(whitelistWord);
          });
        }
      },
    );

    final lpseListInput = AutoCompleteTextField(itemSubmitted: null, key: null, suggestions: null, itemBuilder: null, itemSorter: null, itemFilter: null);

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
                whiteListInput,
                SizedBox(height: 10),
                Wrap(children: whitelistItem),
                SizedBox(height: 15),
                blackListInput,
                SizedBox(height: 10),
                Wrap(children: blacklistItem),
                SizedBox(height: 30),
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
