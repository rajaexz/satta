import 'package:shared_preferences/shared_preferences.dart';

import '../utilis/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  static Future<void> saveOffline(String key, String value) async {
    final store = await SharedPreferences.getInstance();
    await store.setString(key, value);
  }

  static Future<dynamic> getOfflineKey(String key) async {
    final store = await SharedPreferences.getInstance();
    return store.get(key);
  }

  static Future<void> destroyOfflineStorage() async {
    final store = await SharedPreferences.getInstance();
    await store.clear();
  }

  static Future<void> destroyOfflineStorageOne(String name) async {
    final store = await SharedPreferences.getInstance();
    await store.remove(name);
  }

  static Future<bool?> isLoggedIn() async {
    final store = await SharedPreferences.getInstance();
    return store.getBool(AppConstant.isLoggedInKey);
  }

  static Future<String?> getToken() async {
    final store = await SharedPreferences.getInstance();
    return store.getString(AppConstant.tokenKey);
  }

  static Future<String?> getcreatepin() async {
    final store = await SharedPreferences.getInstance();
    return store.getString(AppConstant.createpin);
  }

  static Future<String?> getTokenpin() async {
    final store = await SharedPreferences.getInstance();
    return store.getString(AppConstant.tokenKeypin);
  }

  static Future<String?> getTokenpinCreate() async {
    final store = await SharedPreferences.getInstance();
    return store.getString(AppConstant.createpin);
  }
}
