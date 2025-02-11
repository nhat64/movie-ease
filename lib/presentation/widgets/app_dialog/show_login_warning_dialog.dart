import 'package:base_flutter/app/base/widget_common/custom_dialog.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> showShouldLoginDialog() async {
  bool result = false;

  await showCustomDialog<bool>(
    context: Get.context!,
    backgroundColor: AppColors.black262626,
    child: PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          result = false;
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        width: Get.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Thông báo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Bạn cần đăng nhập để sử dụng chức năng này!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ScaleButton(
                    onTap: () {
                      result = false;
                      Get.back();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.yellowFCC434,
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Hủy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ScaleButton(
                    onTap: () {
                      result = true;
                      Get.back();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.yellowFCC434,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );

  if (result == false) {
    return false;
  }

  final isLoginSuccess = await Get.toNamed(RouteName.login);

  if (isLoginSuccess == null) {
    return false;
  }

  return isLoginSuccess;
}
