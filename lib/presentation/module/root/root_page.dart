import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/presentation/module/root/root_controller.dart';
import 'package:base_flutter/presentation/module/root/widget/cinema_bottom_nav.dart';
import 'package:base_flutter/presentation/module/root/widget/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootPage extends BaseScreen<RootController> {
  const RootPage({super.key});

  @override
  Color? get screenBackgroundColor => const Color(0xFF2C2C2C);

  @override
  bool get wrapWithSafeArea => true;
  @override
  bool get setTopSafeArea => false;
  @override
  bool get setBottomSafeArea => true;

  @override
  Widget buildScreen(BuildContext context) {
    return Obx(
      () {
        return Stack(
          children: [
            _buildStackPage(),
            Visibility(
              visible: controller.isShowingDrawer.value,
              child: AnimatedModalBarrier(
                onDismiss: () {
                  controller.toggleDrawer();
                },
                dismissible: true,
                color: controller.barierAnimation,
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              top: 0,
              bottom: 0,
              left: controller.isShowingDrawer.value ? 0 : -260,
              width: 260,
              child: const DrawerMenu(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStackPage() {
    return Obx(() {
      return Stack(
        children: [
          IndexedStack(
            index: controller.currentPageIndex.value,
            children: controller.listScreen,
          ),
          Positioned(
            bottom: 0,
            child: CinemaBottomNav(
              currentIndex: controller.currentPageIndex.value,
              onIndexChange: controller.onIndexNavChanged,
              onNotchTap: controller.onAddTicket,
            ),
          ),
        ],
      );
    });
  }
}
