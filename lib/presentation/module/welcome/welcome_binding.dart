import 'package:base_flutter/presentation/module/welcome/welcome_controller.dart';
import 'package:get/get.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WelcomeController>(WelcomeController());
  }
}
