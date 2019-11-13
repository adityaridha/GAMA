import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  Future<List<String>> readBlackListWord() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('blacklist') ?? ["pipa"];
  }

  saveBlackListWord(List<String> words) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('blacklist', words);
  }

  Future<List<String>> readWhiteListWord() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('whitelist') ?? [" "];
  }

  saveWhiteListWord(List<String> words) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('whitelist', words);
  }

  Future<List<String>> readWitel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('witel') ?? [" "];
  }

  setWitel(List<String> words) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('witel', words);
  }

  Future<String> readFilterInstansi() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('instansiKey') ?? "";
    return value;
  }

  saveFilterInstansi(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('instansiKey', value);
  }

  Future<bool> readSorting() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool("sorting") ?? false;
    return value;
  }

  saveSorting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("sorting", value);
  }

  setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", value);
  }
}
