import 'dart:convert';

import 'package:http/http.dart' as http;

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

  static Future<UserList> connectToAPI() async {
    String apiURL = "http://54.251.134.177/api/v1//tender";
    Map rawBody = {
      "page": 1,
      "limit": 200,
      "criteria": [],
      "values": [],
      "blacklist_keywords": ["irigasi"]
    };
    var loginBody = json.encode(rawBody);
    var header = {'Content-Type': 'application/json'};
    var apiResult = await http.post(apiURL, body: loginBody, headers: header);
    var jsonObject = json.decode(apiResult.body);
    return UserList.fromJson(jsonObject["data"]);
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
