import 'package:get/get.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../network/network_config.dart';
import '../network/storage_repository.dart';

class StartUpService extends GetxService {
  static NetworkProvider? networkProvider;
  static bool? isLogin;
  static String? token;
  static String? userId;
  static String? name;
  static String? email;
  static String? mobile;

  static PackageInfo? packageInfo;
  static String? appVersion;

  Future<bool> init() async {
    token = await StorageRepository.getToken() ?? "";
    networkProvider = Get.put(NetworkProvider());

    isLogin = (await StorageRepository.isLoggedIn() ?? false) as bool?;

    packageInfo = await PackageInfo.fromPlatform();
    appVersion = "${packageInfo!.version}+${packageInfo!.buildNumber}";

    //Get.log("StartUp Services Started :::: ${isLogin} ${userToken} ${userId} ${email}");
    return true;
  }
}
