import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/app/base/widget_common/custom_snack_bar.dart';
import 'package:base_flutter/data/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassController extends BaseController {
  final _profileRepos = Get.find<ProfileRepository>();

  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmController = TextEditingController();

  final oldPassFocusNode = FocusNode();
  final newPassFocusNode = FocusNode();
  final confirmFocusNode = FocusNode();

  RxString errorText = ''.obs;

  @override
  void onInit() {
    super.onInit();

    oldPassController.addListener(
      () {
        errorText.value = '';
      },
    );

    newPassController.addListener(
      () {
        errorText.value = '';
      },
    );
    confirmController.addListener(
      () {
        errorText.value = '';
      },
    );
  }

  @override
  void dispose() {
    newPassController.dispose();
    confirmController.dispose();

    newPassFocusNode.dispose();
    confirmFocusNode.dispose();
    super.dispose();
  }

  callChangePass() async {
    final bool isValid = validateField();

    if (!isValid) {
      return;
    }

    final ApiResult rs = await CallApiWidget.checkTimeCallApi(
        api: _profileRepos.changePass(
          oldPass: oldPassController.text,
          newPass: newPassController.text,
          confirm: confirmController.text,
        ),
        context: Get.context!);

    rs.when(
      apiSuccess: (res) {
        if (res.status == 200) {
          Get.back();

          showSnackBar(
            title: 'Đăng ký',
            message: 'Đổi mật khẩu thành công!',
          );
        } else {
          errorText.value = res.message as String;
        }
      },
      apiFailure: (error) {},
    );
  }

  bool validateField() {
    if (newPassController.text.isEmpty || oldPassController.text.isEmpty || confirmController.text.isEmpty) {
      errorText.value = 'Không được bỏ trống';
      return false;
    }

    if (confirmController.text != newPassController.text) {
      errorText.value = 'Xác nhận mật khẩu mới không trùng khớp';

      return false;
    }

    errorText.value = '';

    return true;
  }
}
