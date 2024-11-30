import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:flutter/material.dart';

class LoginController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
