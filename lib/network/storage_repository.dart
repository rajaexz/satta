import 'package:shared_preferences/shared_preferences.dart';

import '../utilis/app_constant.dart';

  class StorageRepository {
  static Future<void> saveOffline(String key, dynamic value) async {
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
  static Future<void> destroyOfflineStorageOne(name) async {
    final store = await SharedPreferences.getInstance();
    await store.remove(name);
  }
  static Future<Object?> isLoggedIn() async {
    final store = await SharedPreferences.getInstance();
    // Read the value from storage and return it
    return await store.get(AppConstant.isLoggedInKey);
  }

  static Future<dynamic> getToken() async {
    final store = await SharedPreferences.getInstance();
    // store.setString('KYCstatus', kyc);

    return await store.get(AppConstant.tokenKey);
  }

    static Future<dynamic> getTokenpin() async {
    final store = await SharedPreferences.getInstance();
    // store.setString('KYCstatus', kyc);

    return await store.get(AppConstant.tokenKeypin);
  }

// static Future<String?> getFirebaseToken() async{
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   return await messaging.getToken();
// }
}
