import 'package:flutter/material.dart';
import 'package:telkom_bidding_app/model/list_tender_model.dart';
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

    UserList.connectToAPI("2").then((value) {
      print(value.users);
      setState(() {
        userList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final europeanCountries = [
      'Belanja modal pengadaan jalan khusus (conblock) di RTH Taman Terentang',
      'Pembangunan Jalan Dusun Pangkalraya Kel. Sungaiselan Kec. Sungaiselan',
    ];

    final sliverListItem = SliverFixedExtentList(
      itemExtent: 125.0,
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
                              style: TextStyle(backgroundColor: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 7.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("",
                            style: TextStyle(backgroundColor: Colors.red)),
                      )
                    ]),
                    trailing: Icon(Icons.arrow_right),
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
                        "Tender Tittle Bangka Belitung " +
                            userList.users[index].title,
                        style: TextStyle(fontSize: 15.0),
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
                            Text(userList.users[index].institution),
                          ],
                        ),
                        SizedBox(height: 7.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Rp " + userList.users[index].value + " Juta",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ]),
                      trailing: Icon(Icons.arrow_right),
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
            elevation: 60.0,
            expandedHeight: 250.0,
            backgroundColor: redTel,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'images/auction.jpg',
                fit: BoxFit.cover,
                color: Color.fromRGBO(213, 6, 32, 1.0),
                colorBlendMode: BlendMode.darken,
              ),
              title: Text('LIST TENDER'),
              centerTitle: true,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
          ),
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
            )
          ],
        ),
      ),
    );
  }
}