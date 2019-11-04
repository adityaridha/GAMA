import 'package:telkom_bidding_app/model/list_tender_model.dart';

class FilterTender {
  Future<UserList> filter(List<String> searchItem) {
    print("Yang dicari $searchItem");

    if (searchItem == "") {
      print("Search return null");
      return null;
    }

    var searchResult = UserList.connectToAPI(searchItem);
    print(searchResult);
    return searchResult;
  }
}
