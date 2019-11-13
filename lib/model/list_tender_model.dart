import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_bidding_app/utility/local_data.dart';
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
    var filterinstansi = prefs.getString('instansiKey') ?? "";
    var blacklist = prefs.getStringList('blacklist') ?? ["pipa"];
    var whitelist = prefs.getStringList('whitelist') ?? [" "];
    var sortState = prefs.getBool("sorting") ?? false;

    SortTender sortTender = new SortTender();

    List<String> filter = [];
    List<String> searchCriteria = [""];

    print(whitelist);

    if (mode[0] == "nosearch") {
      searchCriteria = ["witel"];
      if (filterinstansi == "None") {
        filter = [""];
      } else {
        filter = [filterinstansi];
      }
    } else {
      searchCriteria = ["title"];
      filter = mode;
    }

    if(whitelist.isEmpty){
      print("set whitelist default");
      whitelist = [" "];
    }

    print("---------------------------------------------------------");
    print("Criteria : $searchCriteria");
    print("Values : $filter");
    print("Blacklist : $blacklist");
    print("Whitelist : $whitelist");
    print("---------------------------------------------------------");

    String apiURL = "http://54.251.134.177/api/v1//tender";
    Map rawBody = {
      "page": 1,
      "limit": 200,
      "criteria": searchCriteria,
      "values": filter,
      "blacklist_keywords": blacklist,
      "whitelist_keywords": whitelist
    };
    var loginBody = json.encode(rawBody);
    var header = {'Content-Type': 'application/json'};
    var apiResult = await http.post(apiURL, body: loginBody, headers: header);
    var jsonObject = json.decode(apiResult.body);
    var listTender = jsonObject['data'];

    print(jsonObject);

    if (listTender == null) {
      return null;
    } else {
      if (sortState == true) {
        listTender = sortTender.sortByValue(listTender);
      }
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
  String end;

  Tender(
      {this.id,
      this.title,
      this.instansi,
      this.pagu,
      this.link,
      this.status,
      this.end});

  factory Tender.fromJson(Map<String, dynamic> object) {
    return Tender(
        id: object['id'],
        title: object['title'],
        instansi: object['instansi'],
        pagu: object['pagu'],
        link: object["link"],
        status: object["status"],
        end: object["end"]);
  }
}
