import 'package:base_flutter/app_provider.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final AppProvider appProvider = Get.find<AppProvider>();

  final loading = false.obs;

  void onBackpress() {
    Get.back();
  }
}
