import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/app/base/widget_common/custom_snack_bar.dart';
import 'package:base_flutter/data/repositories/auth_repository.dart';
import 'package:base_flutter/data/response/register_message_error.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends BaseController {
  final _authRepos = Get.find<AuthRepository>();

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final nameFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final passFocusNode = FocusNode();
  final confirmFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFucusNode = FocusNode();

  RxString emailErrorText = ''.obs;
  RxString passwordErrorText = ''.obs;
  RxString nameErrorText = ''.obs;
  RxString phoneNumberErrorText = ''.obs;
  RxString usernameErrorText = ''.obs;
  RxString confirmErrorText = ''.obs;

  @override
  void onInit() {
    super.onInit();

    nameController.addListener(
      () {
        nameErrorText.value = '';
      },
    );
    usernameController.addListener(
      () {
        usernameErrorText.value = '';
      },
    );
    passwordController.addListener(
      () {
        passwordErrorText.value = '';
      },
    );
    confirmController.addListener(
      () {
        confirmErrorText.value = '';
      },
    );
    emailController.addListener(
      () {
        emailErrorText.value = '';
      },
    );
    phoneController.addListener(
      () {
        phoneNumberErrorText.value = '';
      },
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    usernameFocusNode.dispose();
    passFocusNode.dispose();
    confirmFocusNode.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFucusNode.dispose();

    super.dispose();
  }

  callRegister() async {
    final bool isValid = validateField();

    if (!isValid) {
      return;
    }

    final ApiResult rs = await CallApiWidget.checkTimeCallApi(
        api: _authRepos.register(
            name: nameController.text,
            username: usernameController.text,
            pass: passwordController.text,
            email: emailController.text,
            phone: phoneController.text),
        context: Get.context!);

    rs.when(
      apiSuccess: (res) {
        if (res.status == 200) {
          Get.back();

          showSnackBar(
            title: 'Đăng ký',
            message: 'Đăng kí thành công!',
          );
        } else {
          final messError = RegisterMessageError.fromJson(res.message);

          if (messError.name != null) {
            nameErrorText.value = messError.email![0];
          }

          if (messError.username != null) {
            usernameErrorText.value = messError.username![0];
          }

          if (messError.password != null) {
            passwordErrorText.value = messError.password![0];
          }

          if (messError.email != null) {
            emailErrorText.value = messError.email![0];
          }

          if (messError.phoneNumber != null) {
            phoneNumberErrorText.value = messError.phoneNumber![0];
          }
        }
      },
      apiFailure: (error) {},
    );
  }

  bool validateField() {
    if (usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty ||
        confirmController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty) {
      emailErrorText.value = 'Không được bỏ trống';
      passwordErrorText.value = 'Không được bỏ trống';
      nameErrorText.value = 'Không được bỏ trống';
      phoneNumberErrorText.value = 'Không được bỏ trống';
      usernameErrorText.value = 'Không được bỏ trống';
      confirmErrorText.value = 'Không được bỏ trống';
      return false;
    }

    if (confirmController.text != passwordController.text) {
      confirmErrorText.value = 'Mật khẩu không trùng khớp';
      emailErrorText.value = '';
      passwordErrorText.value = '';
      nameErrorText.value = '';
      phoneNumberErrorText.value = '';
      usernameErrorText.value = '';
      return false;
    }
    emailErrorText.value = '';
    passwordErrorText.value = '';
    nameErrorText.value = '';
    phoneNumberErrorText.value = '';
    usernameErrorText.value = '';
    confirmErrorText.value = '';
    return true;
  }
}
