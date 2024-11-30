import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode mode = ThemeMode.system;
  Locale locale = const Locale('en');

  bool get isDarkMode => mode == ThemeMode.dark;

  ThemeProvider() {
    mode = LocalStorage.getBool(SharedPreferencesKeys.darkMode) ?? true ? ThemeMode.dark : ThemeMode.light;
    locale = _convertStringToLocale(LocalStorage.getString(SharedPreferencesKeys.locale) ?? 'en');
  }

  void setThemeMode(ThemeMode mode) {
    if (this.mode == mode) return;
    LocalStorage.setBool(
      SharedPreferencesKeys.darkMode,
      mode == ThemeMode.dark,
    );
    this.mode = mode;
    notifyListeners();
  }

  void saveChangedLocale(Locale locale) {
    // only save the locale to local storage
    // why not setLocele/notifyListenrs() ? because EasyLocalization will handle it by setLocale(Locale locale) func, we just need to save it
    // so let call this function affter: await context.setLocale(const Locale('vi'));
    LocalStorage.setString(SharedPreferencesKeys.locale, locale.toString());
  }

  /// Convert locale from string to Locale
  static Locale _convertStringToLocale(String localeString) {
    // Chia tách chuỗi thành danh sách ngôn ngữ và quốc gia
    final List<String> parts = localeString.split('_');
    if (parts.length == 2) {
      return Locale(parts[0], parts[1]); // trả về Locale
    } else {
      return Locale(parts[0]); // trả về Locale không có quốc gia
    }
  }
}
