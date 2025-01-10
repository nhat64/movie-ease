import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/outline_textfield_custom.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/presentation/module/profile/edit_profile/edit_profile_controller.dart';
import 'package:base_flutter/presentation/module/profile/widget/app_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EditProfilePage extends BaseScreen<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Function() get onTapScreen => () {
        FocusScope.of(Get.context!).requestFocus(FocusNode());
      };

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  bool get wrapWithSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Text('Chỉnh sửa thông tin'),
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
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              _buildUserAvatar(),
              const SizedBox(height: 40),
              _buildTextField(
                textController: controller.nameController,
                focusNode: controller.nameFocusNode,
                title: 'Tên người dùng',
                hint: 'Nhập tên người dùng',
                inputAction: TextInputAction.next,
                errorText: controller.errorText.value,
              ),
              const SizedBox(height: 32),
              _buildTextField(
                textController: controller.emailController,
                focusNode: controller.emailFocusNode,
                title: 'Email',
                hint: 'Nhập email',
                isDisable: true,
                errorText: controller.errorText.value,
              ),
              const SizedBox(height: 32),
              _buildTextField(
                textController: controller.ageController,
                focusNode: controller.ageFocusNode,
                title: 'Tuổi',
                hint: 'Nhập tuổi',
                inputAction: TextInputAction.next,
                errorText: controller.errorText.value,
                textInputType: TextInputType.number,
                inputFormatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 32),
              _buildTextField(
                textController: controller.phoneController,
                focusNode: controller.phoneFocusNode,
                title: 'Số điện thoại',
                hint: 'Nhập số điện thoại',
                inputAction: TextInputAction.done,
                errorText: controller.errorText.value,
                textInputType: TextInputType.phone,
                inputFormatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 30),
              ScaleButton(
                onTap: () {
                  controller.updateProfile();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: AppColors.yellowFCC434,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Cập nhập',
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
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 100,
        height: 100,
        child: GestureDetector(
          onTap: () {
            controller.pickImage();
          },
          child: Obx(
            () => Stack(
              fit: StackFit.expand,
              children: [
                AppAvatar(
                  name: controller.nameController.text,
                  avatarPath: controller.avatarPath.value,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const ShapeDecoration(
                      shape: OvalBorder(),
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildTextField({
    required TextEditingController textController,
    required FocusNode focusNode,
    required String title,
    required String hint,
    bool isPassword = false,
    bool isDisable = false,
    TextInputAction? inputAction,
    TextInputType? textInputType,
    List<TextInputFormatter>? inputFormatter,
    String? errorText,
    VoidCallback? onSubmited,
  }) {
    return OutlineTextFieldCustom(
      controller: textController,
      focusNode: focusNode,
      isDisable: isDisable,
      contentStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: isDisable ? AppColors.neutral8C8C8C : Colors.white,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      textInputType: textInputType ?? TextInputType.text,
      labelText: title,
      labelStyle: TextStyle(
        fontSize: 16,
        color: isDisable ? AppColors.neutral8C8C8C : Colors.white,
        fontWeight: FontWeight.w400,
      ),
      textInputAction: inputAction,
      inputFormatters: inputFormatter,
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
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.neutral8C8C8C),
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
