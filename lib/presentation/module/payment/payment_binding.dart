import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/data/page_data/payment_page_data.dart';
import 'package:base_flutter/presentation/module/payment/payment_controller.dart';
import 'package:get/get.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments;

    if (args is PaymentPageData) {
      Get.put<PaymentController>(PaymentController(pageData: args));
    } else {
      Log.console('PaymentBinding: args is not PaymentPageData');
    }
  }
}
