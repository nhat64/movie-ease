import 'package:base_flutter/data/repositories/profile_repository.dart';
import 'package:base_flutter/presentation/module/auth/change_pass/change_pass_controller.dart';
import 'package:get/get.dart';

class ChangePassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileRepository());
    Get.lazyPut(() => ChangePassController());
  }
}