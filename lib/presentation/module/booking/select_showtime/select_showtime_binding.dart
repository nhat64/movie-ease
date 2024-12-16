import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/data/page_data/select_showtime_page_data.dart';
import 'package:base_flutter/data/repositories/showtime_repository.dart';
import 'package:base_flutter/presentation/module/booking/select_showtime/select_showtime_controller.dart';
import 'package:get/get.dart';

class SelectShowtimeBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ShowtimeRepository());

    final args = Get.arguments;

    if (args is SelectShowtimePageData) {
      Get.put(SelectShowtimeController(pageData: args));
    } else {
      Log.console('SelectShowtimeBinding: args is not SelectShowtimePageData');
    }
  }
}
