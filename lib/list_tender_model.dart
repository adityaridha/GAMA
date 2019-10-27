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


  static Future<UserList> connectToAPI(String id) async {
    String apiURL = "https://reqres.in/api/users?page=1&per_page=13";

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);
    var rawData = (jsonObject as Map<String, dynamic>)['data'];
    return UserList.fromJson(rawData);
  }

}

class User {
  int id;
  String first_name;
  String last_name;
  String avatar;

  User({this.id, this.first_name, this.last_name, this.avatar});

  factory User.fromJson(Map<String, dynamic> object) {
    return User(
        id: object['id'],
        first_name: object['first_name'],
        last_name: object['last_name'],
        avatar: object['avatar']);
  }

  static Future<UserList> connectToAPI(String id) async {
    String apiURL = "https://reqres.in/api/users?page" + id;

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);
    var rawData = (jsonObject as Map<String, dynamic>)['data'];
    var userData = rawData[0];
    return UserList.fromJson(userData);
  }
}
