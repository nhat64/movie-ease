import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/data/entity/promotion_entity.dart';
import 'package:get/get.dart';

import 'voucher_detail_controller.dart';

class VoucherDetailBinding extends Bindings {
  @override
  void dependencies() {
    final arg = Get.arguments;

    if (arg is PromotionEntity) {
      Get.lazyPut<VoucherDetailController>(() => VoucherDetailController(arg));
    } else {
      Log.console('VoucherDetailBinding: argument is not PromotionEntity');
    }
  }
}
