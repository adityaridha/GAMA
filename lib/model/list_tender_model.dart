import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserList {
  final List<User> users;

  UserList({
    this.users,
  });

  factory UserList.fromJson(List<dynamic> parsedJson) {
    List<User> users = new List<User>();
    users = parsedJson.map((i) => User.fromJson(i)).toList();

    return new UserList(users: users);
  }


  static Future<UserList> connectToAPI(List<String> values) async {


    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('instansiKey') ?? "";
    final blacklist = prefs.getStringList('blacklist') ?? [""];

    List<String> filter  = [];
    filter.add(value);

    print(filter);

    List<String> listword = ["irigasi"];
    listword.addAll(blacklist);


    String apiURL = "http://54.251.134.177/api/v1//tender";
    Map rawBody = {
      "page": 1,
      "limit": 200,
      "criteria": ["instansi"],
      "values": filter,
      "blacklist_keywords": listword,
    };
    var loginBody = json.encode(rawBody);
    var header = {'Content-Type': 'application/json'};
    var apiResult = await http.post(apiURL, body: loginBody, headers: header);
    var jsonObject = json.decode(apiResult.body);

    print("hasilnya $jsonObject");

    if(jsonObject["data"] == null){
      return null;
    } else {
      return UserList.fromJson(jsonObject["data"]);
    }



  }
}

class User {
  int id;
  String link;
  String title;
  String instansi;
  String status;
  String pagu;

  User({this.id, this.title, this.instansi, this.pagu, this.link, this.status});

  factory User.fromJson(Map<String, dynamic> object) {
    return User(
        id: object['id'],
        title: object['title'],
        instansi: object['instansi'],
        pagu: object['pagu'],
        link: object["link"],
        status: object["status"]);
  }
}
