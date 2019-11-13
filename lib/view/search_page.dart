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

  TenderList tenderList = null;

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

              TenderList.getTenders(inputSearch).then((value) {
                setState(() {
                  tenderList = value;
                  if (tenderList != null) {
                    setState(() {
                      this.resultWidget = ListView.builder(
                          itemCount: tenderList.tenders.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                              child: Card(
                                elevation: 7,
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0), color: redTel),
                                    child: Container(
                                      margin: EdgeInsets.only(left: 4.0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(0),
                                          color: Colors.white),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.fromLTRB(15.0, 5, 15, 5),
                                        title: Text(
                                          tenderList.tenders[index].title
                                              .replaceAll(
                                              "<span class='label label-warning'>", "")
                                              .replaceAll("</span>".toString(), ""),
                                          style: TextStyle(fontSize: 15.0),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Column(children: <Widget>[
                                          SizedBox(height: 12.0),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.pin_drop,
                                                size: 20.0,
                                                color: Colors.blue,
                                              ),
                                              SizedBox(width: 7.0),
                                              Flexible(
                                                  child: Text(
                                                    tenderList.tenders[index].instansi,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: 12),
                                                  )),
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Rp " + tenderList.tenders[index].pagu,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromRGBO(12, 120, 34, 5),
                                                    fontWeight: FontWeight.w500)),
                                          ),
                                          SizedBox(height: 12.0),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.timeline,
                                                    size: 15,
                                                    color: Colors.blue,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      "${tenderList.tenders[index].status.replaceAll("[...]", "").replaceAll("Surat", "")}",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontStyle: FontStyle.italic),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.access_time,
                                                    size: 15,
                                                    color: Colors.blue,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(
                                                      "${tenderList.tenders[index].end}",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontStyle: FontStyle.italic),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                        ]),
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) {
                                                return TenderDetailPage(
                                                    url: tenderList.tenders[index].link);
                                              }));
                                        },
                                      ),
                                    )),
                              ),
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
