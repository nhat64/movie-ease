import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/presentation/module/booking/my_ticket/detail_bill/bill_detail_controller.dart';
import 'package:get/get.dart';

class BillDetailBinding extends Bindings {
  @override
  void dependencies() {
    final arg = Get.arguments;

    if (arg is int) {
      Get.put(BillDetailController(billId: arg));
    } else {
      Log.console('BillDetailBinding: argument is not int');
    }
  }
}
