import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  static const name = 'NAME';
  static const list = 'LIST';
  static const date = 'DATE';
  static const updateDate = "UDATE";
  static const quoteIndex = "QUOTEINDEX";

  Future<List<String>> getLessons() async {
    List<String> defaultLessons = ['0'];
    final prefs = await SharedPreferences.getInstance();
    final lessons = prefs.getStringList(list);
    return lessons ?? defaultLessons;
  }

  Future<bool> setLessons(List<String> lessons) async {
    final prefs = await SharedPreferences.getInstance();
    lessons.toSet().toList();
    lessons.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
    return prefs.setStringList(list, lessons);
  }

  Future<void> setName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, value);
  }

  Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name) ?? '';
  }

  Future<void> setDate(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(date, value);
  }

  Future<String> getDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(date) ?? '';
  }

  Future<void> setUpdateDate(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(updateDate, value);
  }

  Future<String> getUpdateDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(updateDate) ?? '';
  }

  Future<void> setQuoteIndex(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(quoteIndex, value);
  }

  Future<int> getQuoteIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(quoteIndex) ?? 0;
  }
}
