import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/presentation/module/home/home_controller.dart';
import 'package:flutter/material.dart';

class HomeTabBar extends StatefulWidget {
  const HomeTabBar({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  State<HomeTabBar> createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> with SingleTickerProviderStateMixin {
  late TabController tabController;

  HomeController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: controller.tabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48, // tabbar height sẽ được quyết định bởi cha của nó, width cũng vậy, nếu không nó sẽ tự fix bằng cách nào đó
      margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
      child: TabBar(
        onTap: controller.onTabBarChanged,
        controller: tabController,
        tabs: controller.tabs,
        isScrollable: false,
        dividerColor: const Color.fromRGBO(0, 0, 0, 0),
        dividerHeight: 0,
        unselectedLabelColor: AppColors.greyCCCCCC,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.yellowFCC434,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          border: const Border(bottom: BorderSide(color: AppColors.yellowFCC434, width: 1)),
        ),
        splashFactory: NoSplash.splashFactory,
        // physics: const NeverScrollableScrollPhysics(),
        // labelPadding: const EdgeInsets.symmetric(horizontal: 6),
        // tabAlignment: TabAlignment.center,
        // padding: const EdgeInsets.only(left: 18),
      ),
    );
  }
}
