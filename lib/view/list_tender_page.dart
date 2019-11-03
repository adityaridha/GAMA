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
  UserList userList = null;
  User user = null;

  final redTel = Color(0xffc90623);

  @override
  void initState() {
    super.initState();

    UserList.connectToAPI().then((value) {
      setState(() {
        userList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final sliverListItem = SliverFixedExtentList(
      itemExtent: 135.0,
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        if (userList == null) {
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
                    title: Text(
                      "",
                      style: TextStyle(backgroundColor: Colors.grey),
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
                          Text("",
                              style: TextStyle(backgroundColor: Colors.grey))
                        ],
                      ),
                      SizedBox(height: 7.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("",
                            style: TextStyle(backgroundColor: Colors.red)),
                      )
                    ]),
                    trailing: Icon(
                      Icons.arrow_right,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return TenderDetailPage();
                      }));
                    },
                  ),
                )),
          );
        } else {
          if (index < userList.users.length) {
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
                      title: Text(
                        userList.users[index].title,
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
                              size: 15.0,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 7.0),
                            Flexible(
                                child: Text(
                              userList.users[index].instansi,
                              maxLines: 2,
                            )),
                          ],
                        ),
                        SizedBox(height: 7.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Rp " + userList.users[index].pagu,
                              style: TextStyle(color: Colors.black)),
                        )
                      ]),
                      trailing: Icon(Icons.arrow_right, color: Colors.blue),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          print(userList.users[index].id);
                          return TenderDetailPage(
                              url: userList.users[index].link);
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
              elevation: 50.0,
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
