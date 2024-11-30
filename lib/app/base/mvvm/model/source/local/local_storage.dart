import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _appStorage = LocalStorage._init();

  factory LocalStorage() {
    return _appStorage;
  }
  LocalStorage._init();

  // hàm lấy instance của SharedPreferences
  // => dùng cái này để lấy pref rồi dùng cho chỗ khác dùng nữa
  Future<SharedPreferences> sharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static setString(String key, String value) {
    SharedPreferences pref = Get.find<SharedPreferences>();
    pref.setString(key, value);
  }

  static String? getString(String key) {
    SharedPreferences pref = Get.find<SharedPreferences>();
    return pref.getString(key);
  }

  static setInt(String key, int value) {
    SharedPreferences pref = Get.find<SharedPreferences>();
    pref.setInt(key, value);
  }

  static int? getInt(String key) {
    SharedPreferences pref = Get.find<SharedPreferences>();
    return pref.getInt(key);
  }

  static setListString(String key, List<String> value) {
    SharedPreferences pref = Get.find<SharedPreferences>();
    pref.setStringList(key, value);
  }

  static List<String>? getListString(String key) {
    SharedPreferences pref = Get.find<SharedPreferences>();
    return pref.getStringList(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    SharedPreferences pref = Get.find<SharedPreferences>();
    return pref.setBool(key, value);
  }

  static bool? getBool(String key) {
    SharedPreferences pref = Get.find<SharedPreferences>();
    return pref.getBool(key);
  }

  static removeSharedPrefrences(String key) {
    SharedPreferences pref = Get.find<SharedPreferences>();
    pref.remove(key);
  }
}

class SharedPreferencesKeys {
  static const accessToken = 'accessToken'; // String
  static const refreshToken = 'refreshToken'; // String
  static const darkMode = 'darkMode'; // bool
  static const locale = 'locale'; // String vi_VN, en_US
}
