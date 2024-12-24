import 'package:base_flutter/app/base/widget_common/custom_dialog.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showAlerDialog({
  required String content,
  VoidCallback? onOk,
}) async {
  await showCustomDialog<bool>(
    context: Get.context!,
    backgroundColor: AppColors.black262626,
    barrierDismissible: false,
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
          Text(
            content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ScaleButton(
            onTap: () {
              Get.back();
              Future.delayed(const Duration(milliseconds: 100), () {
                onOk?.call();
              });
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.yellowFCC434,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
