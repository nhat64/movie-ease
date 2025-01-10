import 'package:base_flutter/presentation/module/home/home_controller.dart';
import 'package:base_flutter/presentation/module/list_cinema/list_cinema_controller.dart';
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
    Get.put(ListCinemaController());
    Get.put(VoucherController());
  }
}
