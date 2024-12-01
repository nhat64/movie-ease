import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:flutter/widgets.dart';

class RegisterController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final FocusNode emaiFocusNode = FocusNode();
  final FocusNode passFocusNode = FocusNode();
  final FocusNode confirmFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();

    emaiFocusNode.dispose();
    passFocusNode.dispose();
    confirmFocusNode.dispose();
    super.dispose();
  }
}
