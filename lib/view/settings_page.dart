import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

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
    FilterBy("Pangkal Pinang"),
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
//            Navigator.push(context, MaterialPageRoute(builder: (context) {
//              return LoginPage();
//            }));
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
//            Navigator.push(context, MaterialPageRoute(builder: (context) {
//              return LoginPage();
//            }));
          }),
    );

    final filterInstitutions = Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            child: Text("Filter By : "),
            alignment: Alignment.centerLeft,
          ),
          margin: EdgeInsets.only(bottom: 5),
        ),
        Container(
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              border: Border.all(
                width: 2,
                color: Colors.grey,
              ),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DropdownButton(
                    elevation: 20,
                    value: selectInstitution,
                    style: TextStyle(color: redTel),
                    items: generateListInstitutions(institution),
                    isExpanded: true,
                    icon: Icon(Icons.business),
                    onChanged: (method) {
                      setState(() {
                        selectInstitution = method;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            )),
      ],
    );

    final sortByOptions = Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            child: Text("Sort By : "),
            alignment: Alignment.centerLeft,
          ),
          margin: EdgeInsets.only(bottom: 5),
        ),
        Container(
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              border: Border.all(
                width: 2,
                color: Colors.grey,
              ),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DropdownButton(
                    elevation: 20,
                    value: selectedMethod,
                    style: TextStyle(color: redTel),
                    items: generateItem(method),
                    isExpanded: true,
                    icon: Icon(Icons.sort),
                    onChanged: (value) {
                      setState(() {
                        selectedMethod = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            )),
      ],
    );

    final blackListWord = Tags(
      textField: TagsTextField(hintTextColor: Colors.amber),
      itemCount: 5,
      heightHorizontalScroll: 50,
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
                SizedBox(
                  height: 20,
                ),
                sortByOptions,
                SizedBox(
                  height: 50,
                ),
                saveSettings,
                SizedBox(
                  height: 10,
                ),
                logoutButton,
                blackListWord,
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


