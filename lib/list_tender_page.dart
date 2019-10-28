import 'package:flutter/material.dart';
import 'package:telkom_bidding_app/list_tender_model.dart';

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
      'Armenia',
      'Austria',
      'Azerbaijan',
      'Belarus',
      'Belgium',
      'Bosnia and Herzegovina',
      'Bulgaria',
      'Croatia',
      'Cyprus',
      'Czech Republic',
      'Denmark',
      'Estonia',
      'Finland',
    ];

    final banner = Container(
      color: Colors.white70,
      width: 400,
      height: 200,
      padding: EdgeInsets.all(2.0),
      child: Image(
        image: AssetImage("images/auction.jpg"),
        fit: BoxFit.fill,
      ),
    );

    Widget tenderCard(int index) {}

    final sliverListItem = SliverFixedExtentList(
      itemExtent: 100.0,
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        if (userList == null) {
          return Text("Loading..");
        } else {
          if (index < userList.users.length) {
            return Container(
              color: Colors.white70,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                  color: Colors.red,
                  child: Container(
                    margin: EdgeInsets.only(left: 4.0),
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        "Tender Tittle " + userList.users[index].title,
                        style: TextStyle(fontSize: 15.0),
                      ),
                      subtitle: Column(children: <Widget>[
                        SizedBox(height: 5.0),
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
                        SizedBox(height: 10.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Rp " + userList.users[index].value,
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ]),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                        print("Hai");
                        user = userList.users[index];
                        print(user);
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

    final sliverList = CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          pinned: true,
          elevation: 40.0,
          expandedHeight: 250.0,
          backgroundColor: redTel,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'images/auction.jpg',
              fit: BoxFit.cover,
            ),
            title: Text('List Bid Tender'),
            centerTitle: true,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        ),
        sliverListItem
      ],
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
