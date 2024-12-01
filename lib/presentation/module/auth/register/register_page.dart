import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/outline_textfield_custom.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/presentation/module/auth/register/register_controller.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends BaseScreen<RegisterController> {
  const RegisterPage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  Function() get onTapScreen => () {
        FocusScope.of(Get.context!).requestFocus(FocusNode());
      };

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Text('Đăng ký'),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const Icon(
              Icons.movie,
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 40),
            _buildTextField(
              textController: controller.emailController,
              focusNode: controller.emaiFocusNode,
              title: 'Email',
              hint: 'Email',
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(
                  Icons.email,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              inputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              textController: controller.passwordController,
              focusNode: controller.passFocusNode,
              title: 'Mật khẩu',
              hint: 'Mật khẩu',
              isPassword: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              inputAction: TextInputAction.done,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              textController: controller.passwordController,
              focusNode: controller.passFocusNode,
              title: 'Xác nhận mật khẩu',
              hint: 'Xác nhận mật khâu',
              isPassword: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              inputAction: TextInputAction.done,
            ),
            const SizedBox(height: 30),
            ScaleButton(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: AppColors.yellowFCC434,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Đăng ký',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Đã có tài khoản rồi ?',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.offNamed(RouteName.login);
                      },
                      child: const Text(
                        "Đăng nhập",
                        style: TextStyle(
                          color: AppColors.yellowFCC434,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildTextField({
    required TextEditingController textController,
    required FocusNode focusNode,
    required String title,
    required String hint,
    Widget? prefixIcon,
    bool isPassword = false,
    TextInputAction? inputAction,
  }) {
    return OutlineTextFieldCustom(
      controller: textController,
      focusNode: focusNode,
      contentStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      keyboardType: TextInputType.text,
      labelText: title,
      labelStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      textInputAction: inputAction,
      prefixIcon: prefixIcon,
      suffixColor: Colors.white,
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.neutral8C8C8C,
      ),
      isPassword: isPassword,
      cursorColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white),
      ),
    );
  }
}
