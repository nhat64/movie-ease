import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/app/base/widget_common/custom_snack_bar.dart';
import 'package:base_flutter/app/utils/file_utils.dart';
import 'package:base_flutter/app/utils/image_choice.dart';
import 'package:base_flutter/data/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends BaseController {
  final _profileRepository = ProfileRepository();

  RxString errorText = ''.obs;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();

  final nameFocusNode = FocusNode();
  final ageFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  RxString avatarPath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    nameController.text = appProvider.userData.value!.name;
    emailController.text = appProvider.userData.value!.account.email;
    ageController.text = appProvider.userData.value!.age?.toString() ?? '';
    phoneController.text = appProvider.userData.value!.phoneNumber;

    avatarPath.value = appProvider.userData.value!.avatar ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    phoneController.dispose();
    nameFocusNode.dispose();
    ageFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();

    super.dispose();
  }

  pickImage() async {
    final String path = await showImageChoices(context: Get.context!);
    if (path.isNotEmpty) {
      avatarPath.value = path;
    }
  }

  updateProfile() async {
    if (nameController.text.isEmpty) {
      errorText.value = 'Name is required';
      return;
    }

    if (ageController.text.isEmpty) {
      errorText.value = 'Age is required';
      return;
    }

    if (phoneController.text.isEmpty) {
      errorText.value = 'Phone is required';
      return;
    }

    final ApiResult rs = await CallApiWidget.checkTimeCallApi(
      api: _profileRepository.updateProfile(
        name: nameController.text,
        avatar: await getImgMultipartFileByPath(avatarPath.value),
        phone: phoneController.text,
        age: int.parse(ageController.text),
      ),
      context: Get.context!,
    );

    rs.when(
      apiSuccess: (data) {
        if (data.status == 200) {
          appProvider.userData.value = appProvider.userData.value!.copyWith(
            name: nameController.text,
            age: ageController.text,
            phoneNumber: phoneController.text,
            avatar: data.data['avatar'],
          );

          Get.back();
          Future.delayed(const Duration(milliseconds: 500), () {
            showCustomSnackBar(title: 'Cập nhập thông tin', message: 'Cập nhập thông tin thành công');
          });
        } else {
          showCustomSnackBar(title: 'Cập nhập thông tin', message: data.message ?? 'Thất bại');
        }
      },
      apiFailure: (error) {
        showCustomSnackBar(title: 'Cập nhập thông tin', message: 'Cập nhập thất bại, kiểm tra kết nối');
      },
    );
  }
}
