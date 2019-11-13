import 'package:flutter/material.dart';
import 'package:telkom_bidding_app/model/list_tender_model.dart';
import 'package:telkom_bidding_app/view/search_page.dart';
import 'package:telkom_bidding_app/view/settings_page.dart';
import 'package:telkom_bidding_app/view/tender_detail_page.dart';

class ListTenderPage extends StatefulWidget {
  ListTenderPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListTenderPageState createState() => _ListTenderPageState();
}

class _ListTenderPageState extends State<ListTenderPage> {
  TenderList tenderList;

  final redTel = Color(0xffc90623);

  @override
  void initState() {
    super.initState();
    List<String> noSearch = ["nosearch"];
    TenderList.getTenders(noSearch).then((value) {
      setState(() {
        tenderList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final sliverListItem = SliverFixedExtentList(
      itemExtent: 160.0,
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        if (tenderList == null) {
          return Text("No Data");
        } else {
          if (index < tenderList.tenders.length) {
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
          } else {
            return null;
          }
        }
      }),
    );

    Widget listTender() {
      if (tenderList == null) {
        return SliverFillRemaining(
            child: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text("Tidak ada tender ditemukan")])));
      } else {
        return sliverListItem;
      }
    }

    final sliverList = Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              floating: true,
              pinned: true,
              elevation: 20.0,
              expandedHeight: 250.0,
              backgroundColor: redTel,
              actions: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SettingsPage();
                    }));
                  },
                  child: Container(
                      child: Icon(Icons.settings, color: Colors.white),
                      padding: EdgeInsets.only(right: 17)),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset('images/auction.jpg',
                      fit: BoxFit.cover,
                      color: Color.fromRGBO(213, 6, 32, 1.0),
                      colorBlendMode: BlendMode.darken),
                  title: Text('LIST TENDER'),
                  centerTitle: true)),
          listTender(),
        ],
      ),
    );

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Expanded(
              child: sliverList,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SearchPage();
          }));
        },
        child: Icon(Icons.search),
        backgroundColor: redTel,
        elevation: 50.0,
      ),
    );
  }
}
