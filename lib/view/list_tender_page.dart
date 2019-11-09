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
  TenderList tenderList = null;

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
          return Container(
            color: Color(0xFFf6f6f6),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Container(
                color: Colors.red,
                child: Container(
                  margin: EdgeInsets.fromLTRB(4.0, 0.0, 0, 0),
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15.0, 5, 5, 5),
                    subtitle: Column(children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.pin_drop,
                            size: 15.0,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 7.0),
                          Text("",
                              style: TextStyle(backgroundColor: Colors.grey))
                        ],
                      ),
                    ]),
                    trailing: Icon(
                      Icons.arrow_right,
                      color: Colors.blue,
                    ),
                  ),
                )),
          );
        } else {
          if (index < tenderList.tenders.length) {
            return Container(
              padding: EdgeInsets.fromLTRB(11, 6, 11, 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFf6f6f6)),
              child: Container(
                  color: Colors.red,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(4.0, 0.0, 0, 0),
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 5, 5, 5),
                      title: Text(
                        tenderList.tenders[index].title,
                        style: TextStyle(fontSize: 15.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(children: <Widget>[
                        SizedBox(height: 15.0),
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
                              style: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(height: 15.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "status : ${tenderList.tenders[index].status}",
                            style: TextStyle(
                                fontSize: 10, fontStyle: FontStyle.italic),
                          ),
                        )
                      ]),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.blue,
                        size: 30,
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          print(tenderList.tenders[index].id);
                          return TenderDetailPage(
                              url: tenderList.tenders[index].link);
                        }));
                      },
                    ),
                  )),
            );
          } else {
            return null;
          }
        }
      }),
    );

    final sliverList = Container(
      color: Color(0xFFf6f6f6),
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
                  child: Center(
                    child: Container(
                        child: Icon(Icons.settings, color: Colors.white),
                        padding: EdgeInsets.only(right: 20)),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset('images/auction.jpg',
                      fit: BoxFit.cover,
                      color: Color.fromRGBO(213, 6, 32, 1.0),
                      colorBlendMode: BlendMode.darken),
                  title: Text('LIST TENDER'),
                  centerTitle: true)),
          sliverListItem
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
