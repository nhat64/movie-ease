import 'package:base_flutter/data/page_data/select_cinema_page_data.dart';
import 'package:base_flutter/presentation/module/booking/select_cinema/select_cinema_controller.dart';
import 'package:get/get.dart';

class SelectCinemaBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments;

    if (args is SelectCinemaPageData) {
      Get.put(SelectCinemaController(pageData: args));
    }

    Get.put(SelectCinemaController(pageData: SelectCinemaPageData()));
  }
}
