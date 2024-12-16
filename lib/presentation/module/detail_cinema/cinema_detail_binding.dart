import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/data/entity/cinema_entity.dart';
import 'package:get/get.dart';

import 'cinema_detail_controller.dart';

class CinemaDetailBinding extends Bindings {
  @override
  void dependencies() {
    final arg = Get.arguments;

    if (arg is CinemaEntity) {
      Get.lazyPut<CinemaDetailController>(() => CinemaDetailController(arg));
    } else {
      Log.console('VoucherDetailBinding: argument is not CinemaEntity');
    }
  }
}
