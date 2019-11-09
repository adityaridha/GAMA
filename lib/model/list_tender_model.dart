import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_bidding_app/utility/sort_tender.dart';

class TenderList {
  final List<Tender> tenders;

  TenderList({
    this.tenders,
  });

  factory TenderList.fromJson(List<dynamic> parsedJson) {
    List<Tender> tenders = new List<Tender>();
    tenders = parsedJson.map((i) => Tender.fromJson(i)).toList();

    return new TenderList(tenders: tenders);
  }

  static Future<TenderList> getTenders(List<String> mode) async {
    final prefs = await SharedPreferences.getInstance();

    final filterinstansi = prefs.getString('instansiKey') ?? "";
    final blacklist = prefs.getStringList('blacklist') ?? ["pipa"];
    final sortState = prefs.getBool("sorting") ?? false;

    SortTender sortTender = new SortTender();

    List<String> filter = [];
    List<String> listword = ["irigasi"];
    List<String> searchCriteria = [""];
    listword.addAll(blacklist);

    print(mode);

    if (mode[0] == "nosearch") {
      searchCriteria = ["instansi"];
      if (filterinstansi == "None") {
        filter = [""];
      } else {
        filter = [filterinstansi];
      }
    } else {
      searchCriteria = ["title"];
      filter = mode;
    }

    print("Criteria : $searchCriteria");
    print("Values : $filter");
    print("keyword : $listword");

    String apiURL = "http://54.251.134.177/api/v1//tender";
    Map rawBody = {
      "page": 1,
      "limit": 200,
      "criteria": searchCriteria,
      "values": filter,
      "blacklist_keywords": listword,
    };
    var loginBody = json.encode(rawBody);
    var header = {'Content-Type': 'application/json'};
    var apiResult = await http.post(apiURL, body: loginBody, headers: header);
    var jsonObject = json.decode(apiResult.body);
    var listTender = jsonObject['data'];

    print("Runtype List Tender ${listTender.runtimeType}");

    if (sortState == true) {
      listTender = sortTender.sortByValue(listTender);
    }

    if (listTender == null) {
      return null;
    } else {
      return TenderList.fromJson(listTender);
    }
  }
}

class Tender {
  int id;
  String link;
  String title;
  String instansi;
  String status;
  String pagu;

  Tender({this.id, this.title, this.instansi, this.pagu, this.link, this.status});

  factory Tender.fromJson(Map<String, dynamic> object) {
    return Tender(
        id: object['id'],
        title: object['title'],
        instansi: object['instansi'],
        pagu: object['pagu'],
        link: object["link"],
        status: object["status"]);
  }
}
