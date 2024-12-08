import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:flutter/material.dart';

class MyTicketController extends BaseController {
  final List<Tab> tabs = [
    const Tab(text: 'Vé chưa xem'),
    const Tab(text: 'Vé đã xem'),
  ];

  onTabBarChanged(int index) {}
}
