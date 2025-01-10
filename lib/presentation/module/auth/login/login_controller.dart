import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/data/entity/profile_entity.dart';
import 'package:base_flutter/data/repositories/auth_repository.dart';
import 'package:base_flutter/data/repositories/profile_repository.dart';
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

  onLogin() async {
    final bool isValid = validateField();

    if (!isValid) {
      return;
    }

    bool isLoginSuccess = await _getToken();
    if (isLoginSuccess == false) {
      return;
    }

    bool isGetProfileSuccess = await _getProfile();
    if (isGetProfileSuccess == false) {
      return;
    }

    Get.back(result: true);
  }

  Future<bool> _getToken() async {
    final ApiResult rs = await CallApiWidget.checkTimeCallApi(
        api: _authRepos.login(
          username: usernameController.text,
          pass: passwordController.text,
        ),
        context: Get.context!);

    bool isSuccess = await rs.when(
      apiSuccess: (res) async {
        if (res.status == 200) {
          final loginRes = LoginResponse.fromJson(res.data);
          LocalStorage.setString(LocalStorageKeys.accessToken, loginRes.token);
          return true;
        } else {
          if (res.message is String) {
            errorText.value = res.message!;
          } else {
            errorText.value = ((res.message as Map<String, dynamic>)['password'] as List<dynamic>)[0];
          }

          return false;
        }
      },
      apiFailure: (error) async {
        return false;
      },
    );

    return isSuccess;
  }

  _getProfile() async {
    final profileRepos = ProfileRepository();

    final ApiResult rs = await CallApiWidget.checkTimeCallApi(api: profileRepos.getProfile(), context: Get.context!);

    bool isSuccess = await rs.when(
      apiSuccess: (res) async {
        if (res.status == 200) {
          final profile = ProfileEntity.fromJson(res.data);
          appProvider.updateUserData(profile);
          return true;
        } else {
          errorText.value = res.message ?? 'Có lỗi xảy ra';
          return false;
        }
      },
      apiFailure: (error) async {
        return false;
      },
    );

    return isSuccess;
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
