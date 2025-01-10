import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/presentation/module/booking/my_ticket/my_ticket_controller.dart';
import 'package:base_flutter/presentation/module/booking/my_ticket/widget/my_ticket_tabar.dart';
import 'package:flutter/material.dart';

class MyTicketPage extends BaseScreen<MyTicketController> {
  const MyTicketPage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  bool get wrapWithSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Text('Vé của tôi'),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Column(
      children: [
        MyTicketTabBar(controller: controller),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: TabBarView(
              controller: controller.tabController,
              children: controller.tabViews,
            ),
          ),
        ),
      ],
    );
  }
}
