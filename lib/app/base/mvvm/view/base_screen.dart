import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseScreen<T extends GetxController> extends GetView<T> {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!vm.initialized) {
      initController();
    }

    return GestureDetector(
      onTap: onTapScreen,
      behavior: HitTestBehavior.translucent,
      child: Container(
        color: unSafeAreaColor,
        child: wrapWithSafeArea
            ? SafeArea(
                top: setTopSafeArea,
                bottom: setBottomSafeArea,
                child: _buildScaffold(context),
              )
            : _buildScaffold(context),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      key: keyScaffold,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context),
      body: buildScreen(context),
      backgroundColor: screenBackgroundColor,
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  @protected
  Widget buildScreen(BuildContext context);

  @protected
  Widget? buildFloatingActionButton() => null;

  @protected
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;

  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @protected
  Color? get unSafeAreaColor => Colors.black;

  @protected
  Color? get screenBackgroundColor => Colors.white;

  //Ngăn body tự động điều chỉnh khi bàn phím xuất hiện
  @protected
  bool get resizeToAvoidBottomInset => false;

  // Bật tắt mở rộng phần body ra phía sau các phần khác
  @protected
  bool get extendBodyBehindAppBar => false;

  // Chuyển đổi layout safe area
  @protected
  bool get wrapWithSafeArea => false;

  // Bật tắt vùng bottom safe area
  @protected
  bool get setBottomSafeArea => true;

  // Bật tắt vùng top safe area
  @protected
  bool get setTopSafeArea => true;

  @protected
  VoidCallback? get onTapScreen => null;

  @protected
  Key? get keyScaffold => null;

  void initController() {
    vm.initialized;
  }

  @protected
  T get vm => controller;
}
