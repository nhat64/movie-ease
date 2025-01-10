import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/app/base/widget_common/custom_snack_bar.dart';
import 'package:base_flutter/data/repositories/auth_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgotController extends BaseController {
  final _authRepos = Get.find<AuthRepository>();

  final textController = TextEditingController();

  final textFocusNode = FocusNode();

  RxString errorText = ''.obs;

  @override
  onInit() {
    super.onInit();

    textController.addListener(
      () {
        errorText.value = '';
      },
    );
  }

  callApiForgot() async {
    final bool isValid = validateField();

    if (!isValid) {
      return;
    }

    final result = await CallApiWidget.checkTimeCallApi(
      api: _authRepos.forgot(email: textController.text),
      context: Get.context!,
    );

    result.when(
      apiSuccess: (data) {
        if (data.status == 200) {
          Get.back();
          showCustomSnackBar(
            title: 'Quên mật khẩu',
            message: 'Vui lòng kiểm tra email để lấy lại mật khẩu',
          );
        } else {
          errorText.value = data.message as String;
        }
      },
      apiFailure: (error) {},
    );
  }

  validateField() {
    if (textController.text.isEmpty) {
      errorText.value = 'Vui lòng nhập email';
      return false;
    }

    return true;
  }
}
