import 'package:base_flutter/app/base/widget_common/custom_dialog.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

showQrDialog(String ticketCode, {double? size, ImageProvider? imageQr}) {
  showCustomDialog(
    context: Get.context!,
    backgroundColor: AppColors.black262626,
    barrierColor: Colors.black.withOpacity(0.8),
    barrierDismissible: true,
    child: Container(
      padding: const EdgeInsets.all(16),
      width: Get.width * 0.8,
      height: Get.width * 0.8,
      color: Colors.white,
      alignment: Alignment.center,
      child: QrImageView(
      data: ticketCode,
      version: QrVersions.auto,
      size: size ?? 320,
      embeddedImage: imageQr,
      embeddedImageStyle: const QrEmbeddedImageStyle(),
      padding: const EdgeInsets.all(0),
      backgroundColor: Colors.white,
      eyeStyle:
          const QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.black),
      dataModuleStyle: const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square, color: Colors.black),
    ),
    ),
  );
}
