import 'dart:convert';

import 'package:http/http.dart' as http;

class APICall {

  String baseURL = "http://54.251.134.177/api/v1/auth";

  static Future<http.Response> login(String nik, String password) async {
    String apiURL = "http://54.251.134.177/api/v1/auth/login";

    Map rawBody = {"nik": "${nik}", "password": "${password}"};
    var loginBody = json.encode(rawBody);
    var header = {'Content-Type': 'application/json'};

    var apiResult = await http.post(apiURL, body: loginBody, headers: header);

    return apiResult;
  }

  static Future<http.Response> register(
      String name, String nik, String email, String password) async {
    String apiURL = "http://54.251.134.177/api/v1/auth/register";

    Map rawBody = {
      "name": "$name",
      "nik": "$nik",
      "email": "$email",
      "password": "${password}",
    };
    var loginBody = json.encode(rawBody);
    var header = {'Content-Type': 'application/json'};

    var apiResult = await http.post(apiURL, body: loginBody, headers: header);

    print("this is API result : ${apiResult}");

    return apiResult;
  }
}
