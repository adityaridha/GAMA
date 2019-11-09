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
    String apiURL = "http://5db5998c4e41670014ef2aeb.mockapi.io/api/lpse";
    var header = {'Content-Type': 'application/json'};
    var apiResult = await http.get(apiURL, headers: header);
    var jsonObject = json.decode(apiResult.body);

    print(jsonObject);

    return LPSEList.fromJson(jsonObject);
  }
}

class LPSE {
  String id;
  String instansi;


  LPSE({this.id, this.instansi});

  factory LPSE.fromJson(Map<String, dynamic> object) {
    return LPSE(
        id: object['id'],
        instansi: object['instansi']);
  }
}