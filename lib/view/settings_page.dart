import 'package:flutter/material.dart';
import 'package:telkom_bidding_app/model/list_lpse_model.dart';
import 'package:telkom_bidding_app/utility/local_data.dart';
import 'package:telkom_bidding_app/view/list_tender_page.dart';
import 'package:telkom_bidding_app/view/login_page.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  _SettingsPageState() {}

  final redTel = Color(0xffc90623);
  LocalData data = new LocalData();

  TextEditingController searchController = new TextEditingController();
  String filter;
  String initInstitusi;
  String initSort;
  LPSEList initWitel;
  Widget searchResultWitel;

  List<Widget> blacklistItem = [];
  List<String> blacklistWord = [];
  List<Widget> whitelistItem = [];
  List<String> savedWitel = [];
  List<String> witelOptions = [];
  List<Widget> savedWitelItem = [];
  var blackWordController = TextEditingController();
  var whiteWordController = TextEditingController();

  List<String> whitelistWord = ["jaringan", "server"];

  Widget blackTemplateChip(String title) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: InputChip(
        label: Text(title),
        onDeleted: () {
          setState(() {
            blacklistWord.remove(title);
            data.saveBlackListWord(blacklistWord);
            blacklistItem.clear();

            for (var word in blacklistWord) {
              blacklistItem.add(blackTemplateChip(word));
            }
          });
        },
        elevation: 2,
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
            data.saveWhiteListWord(whitelistWord);
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

  Widget witelTemplateChip(String title) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: InputChip(
        label: Text(title),
        onDeleted: () {
          setState(() {
            savedWitel.remove(title);
            data.setWitel(savedWitel);
            savedWitelItem.clear();

            for (var word in savedWitel) {
              if (word != " ") {
                savedWitelItem.add(witelTemplateChip(word));
              }
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

    LPSEList.getLPSE().then((value) {
      setState(() {
        for (var i = 0; i < value.lpse.length; i++) {
          if (value.lpse[i].witel.isNotEmpty) {
            witelOptions.add(value.lpse[i].witel);
          }
        }
      });
    });

    data.readWitel().then((value) {
      setState(() {
        savedWitel = value;
        for (var word in savedWitel) {
          if (word != " ") {
            savedWitelItem.add(witelTemplateChip(word));
          }
        }
      });
    });

    data.readFilterInstansi().then((value) {
      setState(() {
        initInstitusi = value;
      });
    });

    data.readSorting().then((value) {
      setState(() {
        if (value == true) {
          initSort = "Tender Value";
        } else {
          initSort = "Date";
        }
      });
    });

    data.readBlackListWord().then((value) {
      setState(() {
        blacklistWord = value;
        for (var word in blacklistWord) {
          blacklistItem.add(blackTemplateChip(word));
        }
      });
    });

    data.readWhiteListWord().then((value) {
      setState(() {
        whitelistWord = value;
        for (var word in whitelistWord) {
          whitelistItem.add(whiteTemplateChip(word));
        }
      });
    });
  }

  SortBy selectedMethod;
  List<SortBy> method = [SortBy("Date"), SortBy("Tender Value")];

  List<DropdownMenuItem> generateItem(List<SortBy> method) {
    List<DropdownMenuItem> items = [];
    for (var item in method) {
      items.add(DropdownMenuItem(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white30))),
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

  FilterBy selectInstitution;
  List<FilterBy> institution = [
    FilterBy("None"),
    FilterBy("Kabupaten Bangka Barat"),
    FilterBy("Kabupaten Bangka Selatan"),
    FilterBy("Kabupaten Bangka Tengah"),
    FilterBy("Kepulauan Bangka Belitung"),
    FilterBy("Kabupaten Belitung"),
  ];

  List<FilterBy> witel = [
    FilterBy("Aceh"),
    FilterBy("Sumatra Utara"),
    FilterBy("Bangka Belitung"),
    FilterBy("Sumatra Barat"),
    FilterBy("DKI Jakarta"),
    FilterBy("Jawa Barat"),
    FilterBy("Kalimantan"),
    FilterBy("Sulawesi"),
    FilterBy("Papua"),
    FilterBy("Maluku"),
    FilterBy("Nusa Tenggara"),
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
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(width: 12),
                Expanded(
                    child: DropdownButton(
                  underline: Container(),
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
                      data.saveFilterInstansi(ins);
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
            SizedBox(width: 12),
            Expanded(
              child: DropdownButton(
                hint: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(initSort ?? "",
                      style: TextStyle(color: Colors.black)),
                ),
                underline: Container(),
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
                      data.saveSorting(true);
                    } else {
                      data.saveSorting(false);
                    }
                  });
                },
              ),
            ),
            SizedBox(width: 10)
          ])),
    ]);

    final filterAreaWitel = Material(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: new BorderRadius.circular(10.0)),
        child: MaterialButton(
          splashColor: Colors.blue,
          minWidth: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Icon(
                Icons.place,
                color: redTel,
                size: 22,
              ),
              SizedBox(
                width: 13,
              ),
              Text("Select Witel area",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w400))
            ],
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text("Select Witel"),
                    content: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: ListView.builder(
                          itemCount: witelOptions.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.2)),
                              child: ListTile(
                                title: Text("${witelOptions[index]}"),
                                onTap: () {
                                  setState(() {
                                    if (!savedWitel
                                        .contains(witelOptions[index])) {
                                      savedWitel.add(witelOptions[index]);
                                      savedWitelItem.add(witelTemplateChip(
                                          witelOptions[index]));
                                      data.setWitel(savedWitel);
                                    }
                                  });

                                  print("${witelOptions[index]}");
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          }),
                    ),
                  );
                });
          },
        ),
      ),
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
                  color: Colors.green,
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
            data.saveWhiteListWord(whitelistWord);
          });
        }
      },
    );

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
                  color: Colors.black,
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
            blacklistItem.add(blackTemplateChip(value));
            blackWordController.clear();
            data.saveBlackListWord(blacklistWord);
          });
        }
      },
    );

    final saveSettings = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.amber,
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: Text("Save Settings",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 17.0)),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return ListTenderPage();
            }));
          }),
    );

    final logoutButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: redTel,
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: Text("Logout",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 17.0)),
          onPressed: () {
            data.setLoggedIn(false);
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return LoginPage();
            }));
          }),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: redTel,
        titleSpacing: 15,
        title: Text("Settings"),
      ),
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: <Widget>[
                filterAreaWitel,
                SizedBox(height: 10),
                Wrap(children: savedWitelItem),
                SizedBox(height: 15),
                whiteListInput,
                SizedBox(height: 10),
                Wrap(children: whitelistItem),
                SizedBox(height: 15),
                blackListInput,
                SizedBox(height: 10),
                Wrap(children: blacklistItem),
                SizedBox(height: 15),
                SizedBox(height: 15),
                sortByOptions,
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
