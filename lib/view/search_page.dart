import 'package:flutter/material.dart';
import 'package:telkom_bidding_app/controller/search_controller.dart';
import 'package:telkom_bidding_app/model/list_tender_model.dart';
import 'package:telkom_bidding_app/view/tender_detail_page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchController = TextEditingController();
  FilterTender filterTender = new FilterTender();

  Widget resultWidget = Text("No Tender Found");

  UserList searchResult = null;

  @override
  Widget build(BuildContext context) {
    final redTel = Color(0xffc90623);
    var result = [];

    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.search),
          title: TextField(
            controller: searchController,
            textInputAction: TextInputAction.go,
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "Search Tender",
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none),
            onSubmitted: (context) {

              List<String> inputSearch = [searchController.text.toString()];
              print("Input search nya $inputSearch");

              UserList.connectToAPI(inputSearch).then((value) {
                setState(() {
                  searchResult = value;
                  if (searchResult != null) {
                    setState(() {
                      this.resultWidget = ListView.builder(
                          itemCount: searchResult.users.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              color: Color(0xFFf6f6f6),
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Container(
                                  color: Colors.red,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(4.0, 0.0, 0, 0),
                                    color: Colors.white,
                                    child: ListTile(
                                      contentPadding:
                                      EdgeInsets.fromLTRB(15.0, 5, 5, 5),
                                      title: Text(
                                        searchResult.users[index].title,
                                        style: TextStyle(fontSize: 15.0),
                                        maxLines: 2,
                                      ),
                                      subtitle: Column(children: <Widget>[
                                        SizedBox(height: 15.0),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.pin_drop,
                                              size: 15.0,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(width: 7.0),
                                            Flexible(
                                                child: Text(
                                                  searchResult.users[index].instansi,
                                                  maxLines: 2,
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 7.0),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Rp " + searchResult.users[index].pagu,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        )
                                      ]),
                                      trailing: Icon(
                                        Icons.arrow_right,
                                        color: Colors.blue,
                                      ),
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                              return TenderDetailPage(
                                                url: searchResult.users[index].link,
                                              );
                                            }));
                                      },
                                    ),
                                  )),
                            );
                          });
                    });
                  } else {
                    print("Result empty builder");
                    setState(() {
                      print("Result empty builder");
                      this.resultWidget = Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Tender tidak ditemukan", textAlign: TextAlign.center,),
                          ]);
                    });
                  }
                });
              });




            },
          ),
          backgroundColor: redTel,
          actions: <Widget>[
            InkWell(
                onTap: () {
                  searchController.clear();
                  setState(() {
                    result.clear();
                    print("Result empty builder");
                    this.resultWidget = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Tender tidak ditemukan", textAlign: TextAlign.center,),
                        ]);
                  });
                },
                child: Icon(
                  Icons.cancel,
                  size: 20,
                )),
            SizedBox(
              width: 60,
            )
          ],
        ),
        body: Center(child: resultWidget));
  }
}
