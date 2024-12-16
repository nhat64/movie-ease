import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/presentation/module/home/home_page.dart';
import 'package:base_flutter/presentation/module/list_cinema/list_cinema_page.dart';
import 'package:base_flutter/presentation/module/booking/select_popcorn/popcorn_page.dart';
import 'package:base_flutter/presentation/module/profile/profile_page.dart';
import 'package:base_flutter/presentation/module/voucher/voucher_page.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:base_flutter/presentation/widgets/app_dialog/show_login_warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuOption {
  final String title;
  final String iconPath;

  MenuOption({required this.title, required this.iconPath});
}

class RootController extends BaseController with GetSingleTickerProviderStateMixin {
  RootController();

  List<MenuOption> listOption = [
    MenuOption(title: 'Vé', iconPath: SvgPaths.icMyTicket),
    MenuOption(title: 'Lịch sử giao dịch', iconPath: SvgPaths.icShoppingCart),
    MenuOption(title: 'Tài khoản', iconPath: SvgPaths.icUser),
  ];

  final List<Widget> listScreen = [
    const HomePage(),
    const ListCinemaPage(),
    const VoucherPage(),
    const ProfilePage(),
  ];

  late AnimationController drawerAniController;
  late Animation<double> slideAnimation;
  late Animation<Color?> barierAnimation;
  RxBool isShowingDrawer = false.obs;

  RxInt currentPageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    drawerAniController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    slideAnimation = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: drawerAniController,
      curve: Curves.easeInOut,
    ));

    barierAnimation = ColorTween(begin: Colors.transparent, end: Colors.black.withOpacity(0.5)).animate(CurvedAnimation(
      parent: drawerAniController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    drawerAniController.dispose();
    super.dispose();
  }

  onAddTicket() {
    Get.toNamed(RouteName.selectCinema);
  }

  onIndexNavChanged(int index) async {
    if (index == currentPageIndex.value) {
      return;
    }

    if (index == 3 && appProvider.isAuth == false) {
      final isLoginOk = await showShouldLoginDialog();
      if (isLoginOk == false) {
        return;
      }
    }

    currentPageIndex.value = index;
  }

  toggleDrawer() {
    if (isShowingDrawer.value) {
      drawerAniController.reverse();
      isShowingDrawer.value = false;
    } else {
      drawerAniController.forward();
      isShowingDrawer.value = true;
    }
  }
}
