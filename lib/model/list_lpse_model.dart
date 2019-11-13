import 'dart:convert';

import 'package:http/http.dart' as http;

class LPSEList {
  final List<LPSE> lpse;

  LPSEList({
    this.lpse,
  });

  factory LPSEList.fromJson(List<dynamic> parsedJson) {
    List<LPSE> _lpse = new List<LPSE>();
    _lpse = parsedJson.map((i) => LPSE.fromJson(i)).toList();

    return new LPSEList(lpse: _lpse);
  }

  static Future<LPSEList> getLPSE() async {
    String apiURL = "http://54.251.134.177/api/v1//tender/witel";
    var header = {'Content-Type': 'application/json'};
    var apiResult = await http.get(apiURL, headers: header);
    var jsonObject = json.decode(apiResult.body);

    print(jsonObject);

    return LPSEList.fromJson(jsonObject);
  }

  static Future<List<dynamic>> getListLPSE() async {
    String apiURL = "http://54.251.134.177/api/v1//tender/witel";
    var header = {'Content-Type': 'application/json'};
    var apiResult = await http.get(apiURL, headers: header);
    var jsonObject = json.decode(apiResult.body);

    print(jsonObject);

    return jsonObject;
  }



}

class LPSE {
  String witel;
  List<dynamic> lpse;


  LPSE({this.witel, this.lpse});

  factory LPSE.fromJson(Map<String, dynamic> object) {
    return LPSE(
        witel: object['Witel'],
        lpse: object['Lpse']);
  }
}