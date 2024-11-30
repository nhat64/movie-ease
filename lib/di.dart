

import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app_provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> configureDependencies() async {
  // register SharedPreferences
  SharedPreferences sharedPreferences = await LocalStorage().sharedPreferences();
  Get.put<SharedPreferences>(sharedPreferences);

  Get.put<AppProvider>(AppProvider());
}
