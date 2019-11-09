import 'package:telkom_bidding_app/model/list_tender_model.dart';

class FilterTender {
  Future<TenderList> filter(List<String> searchItem) {
    print("Yang dicari $searchItem");

    if (searchItem == "") {
      print("Search return null");
      return null;
    }

    var searchResult = TenderList.getTenders(searchItem);
    print(searchResult);
    return searchResult;
  }
}
