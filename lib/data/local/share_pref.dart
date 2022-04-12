import 'package:shared_preferences/shared_preferences.dart';

class SharePre{
  SharePre._internal();

  static final SharePre _instance = SharePre._internal();

  static SharePre get instance {
    return _instance;
  }

  Future set(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  dynamic get(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(key);
  }

  void clearSPref() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

}