import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/data/page_data/select_popcorn_data.dart';
import 'package:base_flutter/data/repositories/popcorn_repository.dart';
import 'package:base_flutter/presentation/module/booking/select_popcorn/popcorn_controller.dart';
import 'package:get/get.dart';

class PopcornBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PopcornRepository());

    final args = Get.arguments;

    if (args is SelectPopcornPageData) {
      Get.put<PopcornController>(PopcornController(args));
    } else {
      Log.console('PopcornBinding: args is not SelectPopcornPageData');
    }
  }
}
