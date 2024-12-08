import 'package:base_flutter/presentation/module/home/home_controller.dart';
import 'package:base_flutter/presentation/module/popcorn/popcorn_controller.dart';
import 'package:base_flutter/presentation/module/profile/profile_controller.dart';
import 'package:base_flutter/presentation/module/root/root_controller.dart';
import 'package:base_flutter/presentation/module/voucher/voucher_controller.dart';
import 'package:get/get.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(RootController());
    Get.put(ProfileController());
    Get.put(PopcornController());
    Get.put(VoucherController());
  }
}
