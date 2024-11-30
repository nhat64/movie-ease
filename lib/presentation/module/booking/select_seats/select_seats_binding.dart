import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/data/page_data/select_seats_page_data.dart';
import 'package:base_flutter/presentation/module/booking/select_seats/select_seats_controller.dart';
import 'package:get/get.dart';

class SelectSeatsBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments;

    if (args is SelectSeatsPageData) {
      Get.put(SelectSeatsController(pageData: args));
    } else {
      Log.console('SelectSeatsBinding: args is not SelectSeatsPageData');
    }
  }
}
