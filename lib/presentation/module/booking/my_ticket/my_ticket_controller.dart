import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/data/entity/bill_entity.dart';
import 'package:base_flutter/data/repositories/book_repository.dart';
import 'package:base_flutter/presentation/module/booking/my_ticket/widget/list_bill_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TypeBill {
  unseen(1, 'Vé chưa xem'),
  seen(0, 'Vé đã xem');

  final int value;
  final String title;

  const TypeBill(this.value, this.title);
}

class MyTicketController extends BaseController with GetTickerProviderStateMixin {
  final BookRepository _bookRepository = BookRepository();

  final List<Tab> tabs = [
    const Tab(text: 'Vé chưa xem'),
    const Tab(text: 'Vé đã xem'),
  ];

  final List<Widget> tabViews = [
    const ListBillView(typeBill: TypeBill.unseen),
    const ListBillView(typeBill: TypeBill.seen),
  ];

  late TabController tabController;

  @override
  onInit() {
    super.onInit();
    tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  onTabBarChanged(int index) {}

  callApiGetListBill({required int typeBill}) async {
    final rs = await _bookRepository.getListMyBill(typeBill);

    List<BillEntity> tmpListBill = [];

    await rs.when(
      apiSuccess: (res) async {
        tmpListBill = (res.data as List).map((e) => BillEntity.fromJson(e)).toList();
      },
      apiFailure: (error) async {
        Log.console('error: $error');
      },
    );

    return tmpListBill;
  }
}
