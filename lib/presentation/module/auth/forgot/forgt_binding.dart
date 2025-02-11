import 'package:base_flutter/data/repositories/auth_repository.dart';
import 'package:base_flutter/presentation/module/auth/forgot/forgot_controller.dart';
import 'package:get/get.dart';

class ForgotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut(() => ForgotController());
  }
}