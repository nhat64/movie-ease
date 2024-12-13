import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/data/repositories/auth_repository.dart';
import 'package:base_flutter/data/response/login_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final _authRepos = Get.find<AuthRepository>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final usernameFocusNode = FocusNode();
  final passFocusNode = FocusNode();

  RxString errorText = ''.obs;

  @override
  void onInit() {
    super.onInit();

    usernameController.addListener(
      () {
        errorText.value = '';
      },
    );

    passwordController.addListener(
      () {
        errorText.value = '';
      },
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();

    usernameFocusNode.dispose();
    passFocusNode.dispose();
    super.dispose();
  }

  callLogin() async {
    final bool isValid = validateField();

    if (!isValid) {
      return;
    }

    final ApiResult rs = await CallApiWidget.checkTimeCallApi(
        api: _authRepos.login(
          username: usernameController.text,
          pass: passwordController.text,
        ),
        context: Get.context!);

    rs.when(
      apiSuccess: (res) {
        if (res.status == 200) {
          final loginRes = LoginResponse.fromJson(res.data);
          LocalStorage.setString(LocalStorageKeys.accessToken, loginRes.token);
          appProvider.updateUserData(loginRes.user);
          Get.back(result: true);
        } else {
          errorText.value = res.message ?? 'Có lỗi xảy ra';
        }
      },
      apiFailure: (error) {},
    );
  }

  bool validateField() {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      errorText.value = 'Hãy nhập đầy đủ cả tên đăng nhập và mặt khẩu';
      return false;
    } else {
      errorText.value = '';
      return true;
    }
  }
}
