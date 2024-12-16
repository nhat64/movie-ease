import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/outline_textfield_custom.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/presentation/module/auth/forgot/forgot_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPage extends BaseScreen<ForgotController> {
  const ForgotPage({super.key});

  @override
  VoidCallback? get onTapScreen => () {
        controller.textFocusNode.unfocus();
      };

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  bool get wrapWithSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Text('Quên mật khẩu'),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(
              textController: controller.textController,
              focusNode: controller.textFocusNode,
              title: 'Email',
              hint: 'Nhập email',
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(
                  Icons.mail,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              errorText: controller.errorText.value,
            ),
            const Spacer(),
            ScaleButton(
              onTap: controller.callApiForgot,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: AppColors.yellowFCC434,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Quên mật khẩu',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
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
    TextInputType? textInputType,
    String? errorText,
    VoidCallback? onSubmited,
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
      textInputType: textInputType ?? TextInputType.text,
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
      onSubmit: (String? s) {
        onSubmited?.call();
      },
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFCC434)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFCC434)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
      ),
      errorStyle: const TextStyle(color: Colors.white),
      errorPadding: const EdgeInsets.only(top: 8, left: 8),
      errorWidget: errorText != null && errorText.isNotEmpty
          ? Text(
              errorText,
              style: const TextStyle(
                color: Color(0xFFFF4136),
              ),
            )
          : null,
    );
  }
}
