import 'package:flutter/material.dart';

class ListTenderPage extends StatefulWidget {
  @override
  _ListTenderPageState createState() => _ListTenderPageState();
}

class _ListTenderPageState extends State<ListTenderPage> {
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
      'France',
      'Georgia',
      'Germany',
      'Greece',
      'Hungary',
      'Iceland',
      'Ireland',
      'Italy',
      'Kazakhstan',
      'Kosovo',
      'Latvia',
      'Liechtenstein',
      'Lithuania',
      'Luxembourg',
      'Macedonia',
      'Malta',
      'Moldova',
      'Monaco',
      'Montenegro',
      'Netherlands',
      'Norway',
      'Poland',
      'Portugal',
      'Romania',
      'Russia',
      'San Marino',
      'Serbia',
      'Slovakia',
      'Slovenia',
      'Spain',
      'Sweden',
      'Switzerland',
      'Turkey',
      'Ukraine',
      'United Kingdom',
      'Vatican City'
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

    final arrayList = ListView.separated(
      padding: EdgeInsets.all(10.0),
      itemCount: europeanCountries.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return banner;
        } else if (index == 1) {
          return Container(
            child: Padding(
                padding: EdgeInsets.all(5.5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "List Bid Tender",
                    style: TextStyle(fontSize: 20.0),
                  ),
                )),
          );
        }

        return Container(
            color: Colors.red,
            child: Container(
              margin: EdgeInsets.only(left: 4.0),
              color: Colors.white,
              child: ListTile(
                title: Text(
                  europeanCountries[index],
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
                      Text("Instansi"),
                      SizedBox(width: 170.0),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Rp 6.9 Jt",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ]),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  print("Hai");
                },
              ),
            ));
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );

    final sliverList = CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          pinned: true,
          elevation: 40.0,
          expandedHeight: 250.0,
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
        SliverFixedExtentList(
          itemExtent: 100.0,
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
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
                        europeanCountries[index],
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
                            Text("Instansi"),
                            SizedBox(width: 170.0),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Rp 6.9 Jt",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ]),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                        print("Hai");
                      },
                    ),
                  )),
            );
          }),
        )
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
