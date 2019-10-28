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
    String apiURL = "http://5db5998c4e41670014ef2aeb.mockapi.io/api/tender";

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);
//    var rawData = (jsonObject as Map<String, dynamic>);
    return UserList.fromJson(jsonObject);
  }
}

class User {
  String id;
  String title;
  String institution;
  String value;

  User({this.id, this.title, this.institution, this.value});

  factory User.fromJson(Map<String, dynamic> object) {
    return User(
        id: object['id'],
        title: object['title'],
        institution: object['institution'],
        value: object['value']);
  }
}
