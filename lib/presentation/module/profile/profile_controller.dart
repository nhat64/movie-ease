import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/widget_common/custom_snack_bar.dart';
import 'package:base_flutter/presentation/module/root/root_controller.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController {
  logout() {
    appProvider.removeUserData();
    Get.find<RootController>().onIndexNavChanged(0);
    showCustomSnackBar(title: 'Đăng xuất', message: 'Đăng xuất thành công');
  }
}
