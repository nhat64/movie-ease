import 'package:base_flutter/presentation/module/booking/my_ticket/my_ticket_controller.dart';
import 'package:get/get.dart';

class MyTicketBindng extends Bindings {
  @override
  void dependencies() {
    Get.put(MyTicketController());
  }
}
