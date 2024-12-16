import 'package:base_flutter/app/base/widget_common/custom_bottomsheet.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/presentation/module/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showConfirmLogoutBottomsheet({
  required ProfileController controller,
}) {
  showCustomModalBottomSheet(
    context: Get.context!,
    backgroundColor: AppColors.black262626,
    isScrollControlled: true,
    child: Container(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      height: 200,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 24),
              const Text(
                'Đăng xuất',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 0.5,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 16, right: 16),
            color: AppColors.greyCCCCCC,
          ),
          const SizedBox(height: 16),
          const Text(
            'Bạn có chắc chắn muốn đăng xuất?',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ScaleButton(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 45,
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
                        fontSize: 16,
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
                    Get.back();
                    controller.logout();
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Đăng xuất',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
  );
}
