import 'package:base_flutter/data/repositories/auth_repository.dart';
import 'package:base_flutter/presentation/module/auth/register/register_controller.dart';
import 'package:get/get.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut(() => AuthRepository());
  }
}
